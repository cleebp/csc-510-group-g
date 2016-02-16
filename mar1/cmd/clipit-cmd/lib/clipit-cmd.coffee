ClipitCmdView = require './clipit-cmd-view'
{CompositeDisposable} = require 'atom'

module.exports = ClipitCmd =

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
    console.log 'clipit-cmd was activated'
    @subscriptions = new CompositeDisposable
    @clipboard = new ClipitCmd @history, atom.workspace.getActivePaneItem()

  deactivate: ->
    console.log 'clipit-cmd was deactivated'
    @subscriptions.dispose()

  serialize: ->
    clipitCmdViewState: @clipitCmdView.serialize()
