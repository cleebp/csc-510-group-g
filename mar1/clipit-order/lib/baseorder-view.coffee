{ $$, SelectListView } = require 'atom-space-pen-views'
fs = require 'fs'

getDate = ->
  now = new Date
  year = '' + now.getFullYear()
  month = '' + now.getMonth() + 1
  if month.length == 1
    month = '0' + month
  day = '' + now.getDate()
  if day.length == 1
    day = '0' + day
  hour = '' + now.getHours()
  if hour.length == 1
    hour = '0' + hour
  minute = '' + now.getMinutes()
  if minute.length == 1
    minute = '0' + minute
  second = '' + now.getSeconds()
  if second.length == 1
    second = '0' + second
  year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second


module.exports =

class BaseorderView extends SelectListView

  atom.deserializers.add(this)

  editor: null
  forceClear: false
  workspaceView: atom.views.getView(atom.workspace)

  # Public methods
  ###############################
  initialize: (@history, @editorView) ->
    super
    @addClass('baseorder')
    @_handleEvents()

  copy: ->
    @storeFocusedElement()
    @editor = atom.workspace.getActiveTextEditor()

    if @editor
      selectedText = @editor.getSelectedText()

      # If no text selected, copy current line
      if selectedText.length > 0
        @_add selectedText
      else if atom.config.get 'baseorder.enableCopyLine'
        #@editor.buffer.beginTransaction()
        originalPosition = @editor.getCursorBufferPosition()
        @editor.selectLinesContainingCursors()
        selectedText = @editor.getSelectedText()
        @editor.setCursorBufferPosition originalPosition
        #@editor.buffer.commitTransaction()
        @_add selectedText

  paste: ->
    exists = false
    clipboardItem = atom.clipboard.read()

    # Check OS clipboard
    if clipboardItem.length > 0 and not @forceClear
      for item in @history
        if item.text is clipboardItem
          exists = true
      if not exists
        @_add clipboardItem

    # Attach to view
    if @history.length > 0
      @setItems @history.slice(0).reverse()
    else
      @setError "There are no items in your clipboard."
    @_attach()

  sortFreq: ->
    array = @history.slice(1, @history.length)
    @_sortFreq(array)
    @history = [@history[0]]
    for item in array
      @history.push(item)
    @byFreq = true
    @bySource = false
    @byTime = false

  sortSource: ->
    array = @history.slice(1, @history.length)
    @_sortSource(array)
    @history = [@history[0]]
    for item in array
      @history.push(item)
    @byFreq = false
    @bySource = true
    @byTime = false

  sortTime: ->
    array = @history.slice(1, @history.length)
    @_sortTime(array)
    @history = [@history[0]]
    for item in array
      @history.push(item)
    @byFreq = false
    @bySource = false
    @byTime = true

  # Overrides (Select List)
  ###############################
  viewForItem: ({text, date, count, source, clearHistory}) ->
    if clearHistory
      $$ ->
        @li class: 'two-lines text-center', =>
          @span text
    else
      text = @_limitString text, 65
      date = @_timeSince date
      count = @_showFreq count
      source = @_showSource source
      showOption = @_showOption()

      $$ ->
        @li class: 'two-lines', =>
          @div class: 'pull-right secondary-line', =>
            if showOption == 'T'
              @span date
            if showOption == 'F'
              @span count
            if showOption == 'S'
              @span source
          @span text.limited

          # Preview
          if atom.config.get 'baseorder.showSnippetForLargeItems'
            @div class: 'preview hidden panel-bottom padded', =>
              @pre text.initial

  selectItemView: (view) ->
    # Default behaviour
    return unless view.length
    @list.find('.selected').removeClass('selected')
    view.addClass 'selected'
    @scrollToItemView view

    # Show preview
    @list.find('.preview').addClass('hidden')
    preview = view.find '.preview'
    if preview.length isnt 0 and preview.text().length > 65 and atom.config.get 'baseorder.showSnippetForLargeItems'
      if view.position().top isnt 0
        preview.css({ 'top': (view.position().top - 5) + 'px'})
      preview.removeClass 'hidden'

  confirmed: (item) ->
    if item.clearHistory?
      @history = []
      @forceClear = true
    else
      @history.splice(@history.indexOf(item), 1)
      @history.push(item)
      item.count++
      atom.clipboard.write(item.text)
      atom.workspace.getActivePaneItem().insertText item.text, select: true
      pastedText = item.text + ', ' + getDate() + ', atom/' + atom.workspace.getActivePaneItem().getTitle() + '\n'
      fs.appendFile process.env.HOME + '/test.txt', pastedText, (err) ->
       if err
         throw err
       console.log 'Saved!'
    @cancel()

  getFilterKey: ->
    'text'

  cancelled: ->
    @panel?.hide()


  # Helper methods
  ##############################
  _handleEvents: ->

    atom.commands.add 'atom-workspace',
      'baseorder:copy': (event) =>
        @copy()

    atom.commands.add 'atom-workspace',
      'baseorder:paste': (event) =>
        if @panel?.isVisible()
          @cancel()
        else
          @paste()

    atom.commands.add 'atom-workspace',
      'baseorder:sortFreq': (event) =>
        @sortFreq()

    atom.commands.add 'atom-workspace',
      'baseorder:sortSource': (event) =>
        @sortSource()

    atom.commands.add 'atom-workspace',
      'baseorder:sortTime': (event) =>
        @sortTime()

  _setPosition: ->
    @panel.item.parent().css('margin-left': 'auto', 'margin-right': 'auto', top: 200, bottom: 'inherit')

  _add: (element, metadata = {}) ->
    atom.clipboard.write element, metadata
    @forceClear = false

    if @history.length is 0 and atom.config.get 'baseorder.showClearHistoryButton'
      @history.push
        text: 'Clear History',
        clearHistory: true

    @history.push
      'text': element
      'date': Date.now()
      'count': 0
      'source': atom.workspace.getActivePaneItem().getTitle()
      'like': false

  _attach: ->
    @panel ?= atom.workspace.addModalPanel(item: this)
    @_setPosition()
    @panel.show()

    @focusFilterEditor()

  _showFreq: (count) ->
    return "Frequency: " + count

  _showSource: (source) ->
    return "Source: " + source

  _timeSince: (date) ->
    if date
      seconds = Math.floor((new Date() - date) / 1000)
      interval = Math.floor(seconds / 3600)
      return interval + " hours ago"  if interval > 1

      interval = Math.floor(seconds / 60)
      return interval + " minutes ago"  if interval > 1

      return Math.floor(seconds) + " seconds ago" if seconds > 0
      return "now"

  _limitString: (string, limit) ->
    text = {}
    text.initial = text.limited = string
    if string.length > limit
      text.limited = string.substr(0, limit) + ' ...'
    return text

  _showOption: ->
    if @byTime
      return 'T'
    if @bySource
      return 'S'
    if @byFreq
      return 'F'

  _sortFreq: (arr) ->
    len = arr.length
    i = len - 1
    while i >= 0
      j = 1
      while j <= i
        if arr[j - 1].count > arr[j].count
          temp = arr[j - 1]
          arr[j - 1] = arr[j]
          arr[j] = temp
        j++
      i--
    arr

  _sortSource: (arr) ->
    len = arr.length
    i = len - 1
    while i >= 0
      j = 1
      while j <= i
        if arr[j - 1].source < arr[j].source
          temp = arr[j - 1]
          arr[j - 1] = arr[j]
          arr[j] = temp
        j++
      i--
    arr

  _sortTime: (arr) ->
    len = arr.length
    i = len - 1
    while i >= 0
      j = 1
      while j <= i
        if arr[j - 1].date > arr[j].date
          temp = arr[j - 1]
          arr[j - 1] = arr[j]
          arr[j] = temp
        j++
      i--
    arr

  serialize: -> { deserializer: 'BaseorderView', data: @history }
