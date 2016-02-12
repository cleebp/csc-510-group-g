{ CompositeDisposable } = require 'atom'
TextmateClipboard = require './textmate-clipboard-view'

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
    @clipboard = new TextmateClipboard @history, atom.workspace.getActivePaneItem()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
