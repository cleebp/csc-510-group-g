# clipit-order

This section adds contextual sorting feature to the base version of `clipit`. This package modifies the basic clipboard history view by allowing the user to sort the history under different contexts. The different modalities of sort provided by `clipit-order` are sort by time since last copy, sort by frequency of pastes (items that have been pasted more appear first), and sort by source (where the item was copied from). Finally, this package supports data persistence.

![A screenshot of your spankin' package](https://github.com/cleebp/csc-510-group-g/blob/master/mar1/clipit-order/demo.gif)

## Usage

- `cmd-c`:        copy
- `cmd-shift-v`:  display clipboard history
- `cmd-shift-t`:  sort history by time
- `cmd-shift-q`:  sort history by frequency of pastes
- `cmd-shift-s`:  sort history by sources

## Todo

- Fix preview bug eventually

- Some further improvement
  * add link to the source of copied  items
  * allow simple editing of copied items such as combining two items
