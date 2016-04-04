{ CompositeDisposable } = require 'atom'
BaseorderView = require './baseorder-view'

module.exports = Baseorder =

  config:
    showSnippetForLargeItems:
      type: 'boolean'
      default: true
      title: 'Show Snippet'
      description: 'When a long clipboard item, preview it a separate tooltip'
    showClearHistoryButton:
      type: 'boolean'
      default: true
      title: 'Show Clear History'
      description: 'Display a button to clear your clipboard\'s history'
    enableCopyLine:
      type: 'boolean'
      default: true
      title: 'Enable Copy Line'
      description: 'Copy the whole line when no selection'

  history: []
  byTime: false
  bySource: false
  byFreq: false
  clipboard: null
  subscriptions: null

  activate: (state) ->
    #data persistence bug below
    #if state
    #  @history = state.data
    @clipboard = new BaseorderView @history,
        atom.workspace.getActivePaneItem()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
    @clipboard.serialize()
