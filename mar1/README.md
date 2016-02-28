# Mar1 Deliverable

For our project we adapted the open source Atom package `clipboard-history` which provides a clipboard manager for the Atom IDE. Our directories are explained below, but essentially we adapted this package into 3 new and unique versions which each provide different functionalities, each with their own pros and cons. Our new package is generally called `clipit`, and the 3 different versions are `clipit-cmd`, `clipit-panel`, and `clipit-context`. Additionally we have developed a telemetry package which logs system wide copy and pastes with contextual information for each instance (window names, copy content, time, etc).

## Useful Links

- [Issues](https://github.com/cleebp/csc-510-group-g/issues)
- [Milestones](https://github.com/cleebp/csc-510-group-g/milestones)
- [Contributors](https://github.com/cleebp/csc-510-group-g/graphs/contributors)
- [Logs]()

## Subdirectories

- `/base`: The base version of `clipboard-history` all of our packages are built on, see "sources"
- `/clipit-cmd`: Command based version of `clipit`, allows full interaction solely through command interaction
- `/clipit-order`: Contextual based ordering version of `clipit`, offers more contextual information in the clipboard history for sorting
- `/clipit-panel`: Static panel based version of `clipit`, clipboard history is now statically placed on the screen rather than dynamically called
- `/telem`: Telemetry package built to log copy and paste instances for future user testing

## Sources

This project is built from an open sourced Atom Package listed below with a link to its github repository. In general the basic functionality of `clipit` was provided by the `clipboard-history` package, it was then adapted into 3 new unique adaptations which provide new feature sets, or ways to interact with the clipboard history.

- [clipboard-history](https://github.com/unDemian/clipboard-history)
