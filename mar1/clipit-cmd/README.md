# clipit-cmd

This version of clipit focuses on command interactions with the clipboard history. Essentially the goal of clipit-cmd is to allow users to interact fully with the clipboard history functionalities of clipit, solely through input commands. This is accomplished through the use of an indexing system, essentially an index points to the current item that will be pasted when the user types the paste command. Further, the user can manipulate this index through traversal commands, which allows them to paste any item in the clipboard history solely through commands.

![Demo screenshot](https://github.com/cleebp/csc-510-group-g/blob/master/mar1/clipit-cmd/demo_text.gif)

## Usage

- `cmd-c`:        copy
- `cmd-x`:        cut
- `cmd-v`:        paste from current index
- `cmd-shift-j`:  previous index
- `cmd-shift-k`:  next index
- `cmd-shift-v`:  show clipboard history

## Todo

- Currently does not support system-wide copies.
- Cut has issues with grabbing large bodies of text.

## Sources

This project is built from 2 open sourced Atom Packages (that were actually built off of each other), these are listed below with links to their respective repositories. In general the basic functionality was provided by the `clipboard-history` package, and specific command interactions were based off of the ones seen in `textmate-clipboard`.

- [clipboard-history](https://github.com/unDemian/clipboard-history)
- [textmate-clipboard](https://github.com/jkeen/atom-textmate-clipboard)
