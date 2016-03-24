{ $$, SelectListView } = require 'atom-space-pen-views'

module.exports =

class ClipboardHistoryView extends SelectListView

  #task 7 - paste 3 below here

  #task 8 - paste 3 below here

  #task 8 - paste 4 below here
  

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
          if atom.config.get 'clipboard-history.showSnippetForLargeItems'
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
      @history.splice(@history.indexOf(item), 1)
      @history.push(item)
      atom.clipboard.write(item.text)
      atom.workspace.getActivePaneItem().insertText item.text,
        select: true
    @cancel()

  getFilterKey: ->
    'text'

  cancelled: ->
    @panel?.hide()


  # Helper methods
  ##############################
  _add: (element, metadata = {}) ->
    atom.clipboard.write element, metadata
    @forceClear = false

    if @history.length is 0 and atom.config.get 'clipboard-history.showClearHistoryButton'
      @history.push
        text: 'Clear History',
        clearHistory: true

    @history.push
      'text': element
      'date': Date.now()

  _handleEvents: ->

    atom.commands.add 'atom-workspace',
      'clipboard-history:copy': (event) =>
        @copy()

    atom.commands.add 'atom-workspace',
      'clipboard-history:paste': (event) =>
        if @panel?.isVisible()
          @cancel()
        else
          @paste()

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
