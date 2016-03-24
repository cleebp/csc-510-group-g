# Telemetry

Data is collected whenever items are copied onto the system clipboard, and when items are pasted in Atom. The data is stored in separate files, with the same structure to make reading it easy. The content copied/pasted, the timestamp the event occurred and window the data was copied from.

## Usage
No additional commands/programs are required to log data with regard to pastes.
In order to log copy/cut actions, `telem-<os>.py` needs to be executed with the following command:

On Mac:`python telem-mac.py -o <outputfilename>`
The program requires the `pyobjc` package to be installed in order to execute successfully.


On Windows: `python telem-windows.py -o <outputfilename>`
The program requires the `win32gui` package to be installed in order to execute successfully. Install instructions can be found at https://sourceforge.net/projects/pywin32/files/pywin32/Build%20220/. Please pick the correct build version (For eg: if you're using Python 2.7 on a 64 bit machine - use the AMD64 2.7 version).


## Todo
- Add compatibilty for Windows/Linux.
- Event driven for copies.
