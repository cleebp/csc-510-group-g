from time import gmtime, strftime
import sys, getopt
import win32clipboard
import win32gui

def startTelem(outfile):
	
	prev = ""

	while True:
		# get clipboard data
		win32clipboard.OpenClipboard()
		clip_text = win32clipboard.GetClipboardData()
		win32clipboard.CloseClipboard()
		
		if clip_text != prev:
			prev = clip_text
			window = get_active_window_title()
			with open(outfile, "a+") as myfile:
				myfile.write(str(clip_text) + ', ' +  str(strftime("%Y-%m-%d %H:%M:%S")) + ', ' + str(window) + '\n')

def get_active_window_title():
	w = win32gui
	window = w.GetWindowText(w.GetForegroundWindow())
	return window

def main(argv):
	outputfile = ''
	try:
		opts, args = getopt.getopt(argv,"ho:",["ofile="])
	except getopt.GetoptError:
		print 'telem-windows.py -o <outputfilename> (default path is current directory)'
		sys.exit(2)
	for opt, arg in opts:
		if opt == '-h':
 			print 'telem-windos.py -o <outputfilename> (default path is current directory)'
 			sys.exit()
		elif opt in ("-o", "--ofile"):
			outputfile = "./" + arg
	startTelem(outputfile)
	

   
if __name__ == "__main__":
   main(sys.argv[1:])
