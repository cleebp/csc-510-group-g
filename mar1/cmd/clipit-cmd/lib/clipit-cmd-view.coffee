{ $$, SelectListView } = require 'atom-space-pen-views'

module.exports =

class ClipitCmd extends SelectListView

  editor: null
  forceClear: false
  workspaceView: atom.views.getView(atom.workspace)

  # Public methods
  ###############################
  initialize: (@history, @editorView) ->
    super
    @addClass('clipit-cmd')
    @_handleEvents()
    @resetPasteIndex()

  copy: ->
    @storeFocusedElement()
    @editor = atom.workspace.getActiveTextEditor()

    if @editor
      selectedText = @editor.getSelectedText()
      if selectedText.length > 0
        @_add selectedText

  cut: ->
    @editor = atom.workspace.getActiveTextEditor()
    if @editor
      @copy
      @editor.cutSelectedText()

  #pasteNext: ->
  indexNext: ->
    @_addIfNonExistent atom.clipboard.read()
    #our history is a stack
    if (@pasteIndex > 0)
      @pasteIndex--
    #@paste()

  indexPrevious: ->
    @_addIfNonExistent atom.clipboard.read()
    if (@pasteIndex < (@history.length - 2)) # the last one is a "clear history button"
      @pasteIndex++
    @paste()

  paste: ->
    item = ""
    if @history.length > 0
       item = @history.slice(0).reverse()[@pasteCursor]
       if (item)
        #  atom.clipboard.write(item.text)
         atom.workspace.getActivePaneItem().insertText item.text,
            select: false

  show: ->
    @_addIfNonExistent atom.clipboard.read()

    # Attach to view
    if @history.length > 0
      @setItems @history.slice(0).reverse()
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
          if atom.config.get 'clipit-cmd.showSnippetForLargeItems'
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
    if preview.length isnt 0 and preview.text().length > 65 and atom.config.get 'clipboard-history.showSnippetForLargeItems'
      if view.position().top isnt 0
        preview.css({ 'top': (view.position().top - 5) + 'px'})
      preview.removeClass 'hidden'

  confirmed: (item) ->
    if item.clearHistory?
      @history = []
      @forceClear = true
    else
      #@history.splice(@history.indexOf(item), 1)
      #@history.push(item)
      atom.clipboard.write(item.text)
      atom.workspace.getActivePaneItem().insertText item.text,
        select: true
    @cancel()

  getFilterKey: ->
    'text'

  cancelled: ->
    @panel?.hide()

  resetPasteIndex: ->
    # Start the cursor at the second item, not the first. The first is the
    # standard paste behavior's deal.
    @pasteCursor = 0

  # Helper methods
  ##############################
  _add: (element, metadata = {}) ->
    atom.clipboard.write element, metadata
    @forceClear = false

    if @history.length is 0 and atom.config.get 'clipit-cmd.showClearHistoryButton'
      @history.push
        text: 'Clear History',
        clearHistory: true

    @history.push
      'text': element
      'date': Date.now()

  _addIfNonExistent: (clipboardItem) ->
    exists = false

    if clipboardItem.length > 0 #and not @forceClear
      for item in @history
        if item.text is clipboardItem
          exists = true
      if not exists
        @_add clipboardItem

  _handleEvents: ->

    atom.commands.add 'atom-workspace',
      'clipit-cmd:copy': (event) =>
        @copy()

    atom.commands.add 'atom-workspace',
      'clipit-cmd:cut': (event) =>
        @cut()

    atom.commands.add 'atom-workspace',
      'clipit-cmd:paste': (event) =>
        @paste()

    atom.commands.add 'atom-workspace',
      'clipit-cmd:indexNext': (event) =>
        @indexNext()

    atom.commands.add 'atom-workspace',
      'clipit-cmd:indexPrevious': (event) =>
        @indexPrevious()

    atom.commands.add 'atom-workspace',
      'clipit-cmd:show': (event) =>
        if @panel?.isVisible()
          @cancel()
        else
          @show()

  _setPosition: ->
    @panel.item.parent().css('margin-left': 'auto', 'margin-right': 'auto', top: 200, bottom: 'inherit')

  _attach: ->
    @panel ?= atom.workspace.addModalPanel(item: this)
    @_setPosition()
    @panel.show()

    @focusFilterEditor()

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
