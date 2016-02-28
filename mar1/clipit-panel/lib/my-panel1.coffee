MyPanel1View = require './my-panel1-view'
{CompositeDisposable} = require 'atom'

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
    enableCopyLine:
      type: 'boolean'
      default: true
      title: 'Enable Copy Line'
      description: 'Copy the whole line when no selection'

  history: []
  clipboard: null
  subscriptions: null

  activate: (state) ->
  #  @myPanel1View = new MyPanel1View(state.myPanel1ViewState)
  #  @modalPanel = atom.workspace.addModalPanel(item: @myPanel1View.getElement(), visible: false)
   #if state  # 2/28
   #history=state.data
    @subscriptions = new CompositeDisposable
    @clipboard = new MyPanel1View @history, atom.workspace.getActivePaneItem()


  deactivate: ->
    @modalPanel.destroy()
  #  @subscriptions.dispose()
  #  @myPanel1View.destroy()

  serialize: ->
    myPanel1ViewState: @myPanel1View.serialize()
   #clipboard.serialize
