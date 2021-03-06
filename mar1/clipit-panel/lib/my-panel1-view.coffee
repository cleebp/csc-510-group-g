{SelectListView, $$} = require 'atom-space-pen-views'
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
class MyPanel1View extends SelectListView

  editor: null
  forceClear: false
  workspaceView: atom.views.getView(atom.workspace)

# atom.deserializers.add(this) #2/28


  # Public methods
  ###############################
  initialize: (@history, @editorView) ->
    super
    @addClass('my-panel1')
    @_handleEvents()

    message = document.createElement('div')
    message.textContent = "Atom Clipboard Panel"
    message.classList.add('message')
    @element.appendChild(message)

    @panel ?= atom.workspace.addRightPanel(item: this)
    @panel.show()

  copy: ->
    console.log 'copy called'
    @storeFocusedElement()
    @editor = atom.workspace.getActiveTextEditor()

    if @editor
      selectedText = @editor.getSelectedText()
      if selectedText.length > 0
        @_add selectedText
        #display the item on the pane
        if @history.length >= 0 #I made change
          @setItems @history.slice(0).reverse()
          @_attach()
      else if atom.config.get 'my-panel1.enableCopyLine'
        #@editor.buffer.beginTransaction()
        originalPosition = @editor.getCursorBufferPosition()
        @editor.selectLinesContainingCursors()
        selectedText = @editor.getSelectedText()
        @editor.setCursorBufferPosition originalPosition
        #@editor.buffer.commitTransaction()
        if selectedText.length > 0
          atom.clipboard.metadata = atom.clipboard.metadata || {}
          atom.clipboard.metadata.fullline = true
          atom.clipboard.metadata.fullLine = true
          @_add selectedText, atom.clipboard.metadata
          #display the item on the pane
          if @history.length >= 0 # I made change
            @setItems @history.slice(0).reverse()
            @_attach()

  paste: ->
    console.log 'paste called'
    exists = false
    clipboardItem = atom.clipboard.read()

    # Check OS clipboard
    if clipboardItem.length > 0 # and not @forceClear --- I made change
      for item in @history
        if item.text is clipboardItem
          exists = true
      if not exists
        @_add clipboardItem

    # Attach to view
    if @history.length > 0
      @setItems @history.slice(0).reverse()
      #also actually paste the most recent item, because thats helpful
      atom.workspace.getActivePaneItem().insertText clipboardItem,
        select: true
      pastedText = item.text + ', ' + getDate() + ', atom/' + atom.workspace.getActivePaneItem().getTitle() + '\n'
      fs.appendFile process.env.HOME + '/test.txt', pastedText, (err) ->
        if err
          throw err
        console.log 'Saved!'

    else
      @setError "There are no items in your clipboard."
    @_attach()

  # Overrides (Select List)
  ###############################
  viewForItem: ({text, date, clearHistory}) ->
    if clearHistory
      $$ ->
        @li class: 'two-lines text-center', =>
          @span text
    else
      text = @_limitString text, 65
      date = @_timeSince date

      $$ ->
        @li class: 'two-lines', =>
          @div class: 'pull-right secondary-line', =>
            @span date
          @span text.limited

          # Preview
          if atom.config.get 'my-panel1.showSnippetForLargeItems'
            @div class: 'preview hidden panel-bottom padded', =>
              @pre text.initial

  selectItemView: (view) ->
    # Default behaviour
    return unless view.length
    @list.find('.selected').removeClass('selected')
    view.addClass 'selected'
    @scrollToItemView view

    # Show preview
    @list.find('.preview').addClass('hidden') # 2/28
    preview = view.find '.preview'
    if preview.length isnt 0 and preview.text().length > 65 and atom.config.get 'my-panel1.showSnippetForLargeItems'
      if view.position().top isnt 0
        preview.css({ 'top': (view.position().top - 5) + 'px'})
      preview.removeClass 'hidden'

  confirmed: (item) ->
    console.log 'confirming'
    if item.clearHistory?
      @history = []
      @forceClear = true
    else
      @history.splice(@history.indexOf(item), 1)
      @history.push(item)
      atom.clipboard.write(item.text)
      atom.workspace.getActivePaneItem().insertText item.text,
        select: true
      pastedText = item.text + ', ' + getDate() + ', atom/' + atom.workspace.getActivePaneItem().getTitle() + '\n'
      fs.appendFile process.env.HOME + '/test.txt', pastedText, (err) ->
        if err
          throw err
        console.log 'Saved!'


    @cancel()
    #tiny hack to get the panel updated and displaying
    @setItems @history.slice(0).reverse()
    @_attach()

  getFilterKey: ->
    'text'

  cancelled: ->
    #@panel?.hide()


  # Helper methods
  ##############################
  _add: (element, metadata = {}) ->
    atom.clipboard.write element, metadata
    @forceClear = false

    if @history.length is 0 and atom.config.get 'my-panel1.showClearHistoryButton'
      @history.push
        text: 'Clear History',
        clearHistory: true
    @history.push
      'text': element
      'date': Date.now()

  _handleEvents: ->

    atom.commands.add 'atom-workspace',
      'my-panel1:copy': (event) =>
        @copy()

    atom.commands.add 'atom-workspace',
      'my-panel1:paste': (event) =>
        @paste()

  _setPosition: ->
    @panel.item.parent().css('margin-left': 'auto', 'margin-right': 'auto', top: 200, bottom: 'inherit')

  _attach: ->
    @panel = atom.workspace.addRightPanel(item: this)
    @_setPosition()

  #  @focusFilterEditor() # uncommenting this line will not show panel alwys

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


#serialize:-> {deserializers:'myPanel1View', data: @history} # 28/2
