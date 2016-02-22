# clipit-cmd

This version of clipit focuses on command interactions with the clipboard history. Essentially the goal of clipit-cmd is to allow users to interact fully with the clipboard history functionalities of clipit, solely through input commands. This is accomplished through the use of an indexing system, essentially an index points to the current item that will be pasted when the user types the paste command. Further, the user can manipulate this index through traversal commands, which allows them to paste any item in the clipboard history solely through commands.

![Demo screenshot](https://github.com/cleebp/csc-510-group-g/tree/cleebp/mar1/cmd/clipit-cmd/demo.gif)

## Usage

- `cmd-c`:        copy
- `cmd-x`:        cut
- `cmd-v`:        paste from current index
- `cmd-shift-j`:  previous index
- `cmd-shift-k`:  next index
- `cmd-shift-v`:  show clipboard history

## Notes

Currently does not support system-wide copies.
