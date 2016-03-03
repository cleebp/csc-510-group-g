# Telemetry

Data is collected whenever items are copied onto the system clipboard, and when items are pasted in Atom. The data is stored in separate files, with the same structure to make reading it easy. The content copied/pasted, the timestamp the event occurred and window the data was copied from.

## Usage
No additional commands/programs are required to log data with regard to pastes.
In order to log copy/cut actions, `telem.py` needs to be executed with the following command:
`python telem.py`
The program requires the `pyobjc` package to be installed in order to execute successfully.

## Todo
- Add compatibilty for Windows/Linux.
- Event driven for copies.
