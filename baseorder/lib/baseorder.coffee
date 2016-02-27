{ CompositeDisposable } = require 'atom'
BaseorderView = require './baseorder-view'
jsonfile = require 'jsonfile'
util = require 'util'

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
  clipboard: null
  subscriptions: null

  activate: (state) ->
    @history = state.data
    @clipboard = new BaseorderView @history,
        atom.workspace.getActivePaneItem()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
    @clipboard.serialize()
