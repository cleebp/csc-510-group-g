require 'atom'
systemClipboard = require 'clipboard'
Activator = require '../lib/textmate-clipboard'
TextmateClipboard = require '../lib/textmate-clipboard-view'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "TextmateClipboard", ->
  [textmateClipboard, workspaceElement, editorElement, editor, manager] = []

  clearHistory = () ->
    manager.history = []

  loadClipboard = () ->
    clearHistory()

    editor.insertText("abcdefghijklmnopqrstuvwxyz")
    #copy a
    editor.addSelectionForBufferRange([[0, 0], [0, 1]])
    atom.commands.dispatch workspaceElement, 'textmate-clipboard:copy'

    #copy b
    editor.addSelectionForBufferRange([[0, 1], [0, 2]])
    atom.commands.dispatch workspaceElement, 'textmate-clipboard:copy'

    #copy c
    editor.addSelectionForBufferRange([[0, 2], [0, 3]])
    atom.commands.dispatch workspaceElement, 'textmate-clipboard:copy'

    #copy d
    editor.addSelectionForBufferRange([[0, 3], [0, 4]])
    atom.commands.dispatch workspaceElement, 'textmate-clipboard:copy'

    #copy 3
    editor.addSelectionForBufferRange([[0, 4], [0, 5]])
    atom.commands.dispatch workspaceElement, 'textmate-clipboard:copy'


    #insert new line
    editor.setCursorBufferPosition([1, 0])
    editor.insertNewline()

  beforeEach ->
    # Initialize without any history
    manager = Activator
    manager.activate()
    textmateClipboard = manager.clipboard

    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)
    waitsForPromise ->
      atom.workspace.open(null, autoIndent: false).then (o) ->
        editor = o
        editorElement = atom.views.getView(editor)

  describe "cutcopy", ->
    it "adds items to the history on copy", ->
      editor.insertText("abcdefghijklmnopqrstuvwxyz")
      editor.addSelectionForBufferRange([[0, 0], [0, 26]], reversed: true)
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:copy'
      expect(manager.clipboard.history[0].text).toEqual("abcdefghijklmnopqrstuvwxyz")

    it "adds items to the history on cut", ->
      editor.insertText("abcdefghijklmnopqrstuvwxyz")
      editor.addSelectionForBufferRange([[0, 0], [0, 26]], reversed: true)
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:cut'
      expect(manager.clipboard.history[0].text).toEqual("abcdefghijklmnopqrstuvwxyz")

  describe "pastePrevious", ->
    beforeEach ->
      loadClipboard()

    afterEach ->
      clearHistory()

    it "pastes the previous item, and keeps pasting after reaching the end", ->
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pastePrevious'
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pastePrevious'
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pastePrevious'
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pastePrevious'
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pastePrevious'
      editor.addSelectionForBufferRange([[1, 0], [1, 5]], reversed: true)
      expect(editor.getSelectedText()).toEqual("dcbaa")

    it "doesn't remove it from the history", ->
      expect(textmateClipboard.history.length).toEqual(5)

  describe "pasteNext", ->
    beforeEach ->
      clearHistory()
      loadClipboard()

    it "pastes the next item, and keeps pasting after reaching the end", ->
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pastePrevious'
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pastePrevious'
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pasteNext'
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pasteNext'
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pasteNext'
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pasteNext'
      atom.commands.dispatch workspaceElement, 'textmate-clipboard:pasteNext'
      editor.addSelectionForBufferRange([[1, 0], [1, 10]], reversed: true)
      expect(editor.getSelectedText()).toEqual("dcdeeee")

    it "doesn't remove it from the history", ->
      expect(textmateClipboard.history.length).toEqual(5)

  describe "showHistory", ->
    it "shows the history items when requested", ->
      expect(workspaceElement.querySelector('.textmate-clipboard')).not.toExist()
      atom.commands.dispatch editorElement, 'textmate-clipboard:show'
      expect(workspaceElement.querySelector('.textmate-clipboard')).toExist()

    it "sorts the items in the history window in reverse order", ->
      loadClipboard()
      atom.commands.dispatch editorElement, 'textmate-clipboard:show'
      els = workspaceElement.querySelectorAll('ol >li > span')
      values = (m.innerHTML for m in els)
      expect(values).toEqual(["e", "d", "c", "b", "a", "initial clipboard content"])
      clearHistory()

    it "first item in history window is on system clipboard", ->
      clearHistory()
      # systemClipboard = atom.clipboard.read()
      atom.commands.dispatch editorElement, 'textmate-clipboard:show'
      els = workspaceElement.querySelectorAll('ol > li > span')
      values = (m.innerHTML for m in els)
      expect(values).toEqual([atom.clipboard.read()])

    it "doesn't change the history order when pasting from the window", ->
