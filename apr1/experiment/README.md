# Experiment

This is the directory for all files related to the our experiment.

## Process

In total 8 participants were gathered with a sufficient programming background (all NCSU grad students), and we performed the same experiment on each participant such that each of our base features (and a control group) was tested twice. Each participant was given an Atom instance already running one of our packages (or the control), and they were given a short tutorial on how to use the package and get used to the Atom interface.

Following this, each participant was given the same 10 [tasks](https://github.com/cleebp/csc-510-group-g/blob/master/apr1/experiment/tasks.md) to complete as quickly and efficiently as possible. We had [background python telemetry](https://github.com/cleebp/csc-510-group-g/tree/master/mar1/telem) running to record the timestamps and content of each copy/paste in order to determine total time taken to complete each individual task (and total experiment time). We performed our tests in 2 rounds of 4 participants each, each round tested each feature once and the control once. Unfortunately, a [permissions related bug](https://github.com/cleebp/csc-510-group-g/issues/72) showed up right before our second round of testing so we resorted to using a stopwatch and oral queues from the participants to gather accurate timing data.

## Tasks

Our tasks are listed in the file [tasks.md](https://github.com/cleebp/csc-510-group-g/blob/master/apr1/experiment/tasks.md).

## Subdirectories

- [base](https://github.com/cleebp/csc-510-group-g/tree/master/apr1/experiment/base): base code which was given to participants to perform the tasks on
- [data](https://github.com/cleebp/csc-510-group-g/tree/master/apr1/experiment/data): contains all of the data gathered and summarized in excel documents (note all identifiable information has been sanitized)
