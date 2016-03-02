# Mar1 Deliverable

For our project we adapted the open source Atom package `clipboard-history` which provides a clipboard manager for the Atom IDE. Our directories are explained below, but essentially we adapted this package into 3 new and unique versions which each provide different functionalities, each with their own pros and cons. Our new package is generally called `clipit`, and the 3 different versions are `clipit-cmd`, `clipit-panel`, and `clipit-context`. Additionally we have developed a telemetry package which logs system wide copy and pastes with contextual information for each instance (window names, copy content, time, etc).

## Useful Links

- [Issues](https://github.com/cleebp/csc-510-group-g/issues)
- [Milestones](https://github.com/cleebp/csc-510-group-g/milestones)
- [Contributors](https://github.com/cleebp/csc-510-group-g/graphs/contributors)
- [Sample Log](https://github.com/cleebp/csc-510-group-g/blob/master/mar1/telem/logSample.txt)

## Subdirectories

- [Base code](https://github.com/cleebp/csc-510-group-g/tree/master/mar1/base) `clipboard-history`: base version all packages are built on, see "sources"
- [Feature #1](https://github.com/cleebp/csc-510-group-g/tree/master/mar1/clipit-cmd) `clipit-cmd`: command based version of `clipit`, allows full interaction solely through command interaction
- [Feature #2](https://github.com/cleebp/csc-510-group-g/tree/master/mar1/clipit-order) `clipit-order`: contextual based ordering version of `clipit`, allows sorting clipboard by time, frequencey, and source
- [Feature #3](https://github.com/cleebp/csc-510-group-g/tree/master/mar1/clipit-panel) `clipit-panel`: static panel based version of `clipit`, clipboard history is now statically placed on the screen rather than dynamically called
- [Telemetry](https://github.com/cleebp/csc-510-group-g/tree/master/mar1/telem) `telem`: telemetry package built to log copy and paste instances for future user testing

## Evaluation Plan

In order to evaluate our features for the clipboard manager, we will be performing user tests on each of the clipboard features. Each group member will be in charge of finding 4 participants who are familiar with coding in modern text editors, 1 participant for each feature, and 1 participant as a control group using standard copy/paste commands. By doing this we will gather 16 total user tests, 4 tests per feature, 4 tests for the control group, and more importantly each participant will only interact with 1 feature, avoiding learning bias.

During our user tests our telemetry package (see `telem`) will be running and logging all user copy and paste events, along with the location and content of the events. Furthermore, a group member will be present and taking active notes on any problems or insights the users exhibit. The actual content of the test will involve the participant being provided an existing code base in the Atom IDE, and then being asked to perform a set of operations and changes to that code base that favor copy and paste events under different circumstances (copies in the same file, copies across files, copies across applications).

Finally, we will gather all of the information from these user tests and through detailed analysis on each feature, make meaningful judgements on which feature best allowed users to copy and paste effectively and efficiently.

## Sources

This project is built from an open sourced Atom Package listed below with a link to its github repository. In general the basic functionality of `clipit` was provided by the `clipboard-history` package, it was then adapted into 3 new unique adaptations which provide new feature sets, or ways to interact with the clipboard history.

- [clipboard-history](https://github.com/unDemian/clipboard-history)
