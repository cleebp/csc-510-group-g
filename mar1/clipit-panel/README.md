# my-panel1 package

This section adds a panel feature to the base version of `clipit`. Users can view their clipboard history on a static right panel inside the Atom editor. Whenever a user copies an item from the atom workspace, it immediately appears on the panel, while items that are copied from outside of the atom workspace will be displayed on the panel only after pasting them inside the workspace.

![A screenshot of your spankin' package](https://github.com/cleebp/csc-510-group-g/blob/master/mar1/clipit-panel/panel1.gif)

## Usage

- `cmd-c`: standard copy (item appears in the panel)
- `cmd-v`: standard paste (pastes the most recent item)
- Clicking on an item in the history panel will immediately paste that item wherever your curser is located inside the workspace

## Todo

- Add favorites functionality where user can "sticky" an item such that it doesn't disappear when the history is cleared.
