{ $$, SelectListView } = require 'atom-space-pen-views'

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
    console.log(array)

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

      $$ ->
        @li class: 'two-lines', =>
          @div class: 'pull-right secondary-line', =>
            @span date
          @div class: 'pull-left secondary-line', =>
            @span count
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

  serialize: -> { deserializer: 'BaseorderView', data: @history }
