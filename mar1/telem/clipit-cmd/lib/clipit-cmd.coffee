{ CompositeDisposable } = require 'atom'
ClipitCmdView = require './clipit-cmd-view'

module.exports =

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

  history: []
  clipboard: null
  subscriptions: null

  activate: () ->
    @subscriptions = new CompositeDisposable
    @clipboard = new ClipitCmdView @history, atom.workspace.getActivePaneItem()
    console.log 'clipit-cmd was activated'

  deactivate: ->
    @subscriptions.dispose()
    console.log 'clipit-cmd was deactivated'

  serialize: ->
    #clipitCmdViewState: @clipitCmdView.serialize()
