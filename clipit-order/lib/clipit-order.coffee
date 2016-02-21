ClipitOrderView = require './clipit-order-view'
{CompositeDisposable} = require 'atom'

module.exports = ClipitOrder =
  clipitOrderView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @clipitOrderView = new ClipitOrderView(state.clipitOrderViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @clipitOrderView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'clipit-order:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @clipitOrderView.destroy()

  serialize: ->
    clipitOrderViewState: @clipitOrderView.serialize()

  toggle: ->
    console.log 'ClipitOrder was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      # This section is added accoding to word count function
      editor = atom.workspace.getActiveTextEditor()
      count = editor.getText().split(/\s+/).length
      # console.log(@clipitOrderView)
      @clipitOrderView.setCount(count)
      @modalPanel.show()
