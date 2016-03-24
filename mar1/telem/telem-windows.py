from time import gmtime, strftime
import sys, getopt
import win32gui
import ctypes

ocb = ctypes.windll.user32.OpenClipboard    #Basic Clipboard functions
ecb = ctypes.windll.user32.EmptyClipboard
gcd = ctypes.windll.user32.GetClipboardData
scd = ctypes.windll.user32.SetClipboardData
ccb = ctypes.windll.user32.CloseClipboard
ga = ctypes.windll.kernel32.GlobalAlloc    # Global Memory allocation
gl = ctypes.windll.kernel32.GlobalLock     # Global Memory Locking
gul = ctypes.windll.kernel32.GlobalUnlock
GMEM_DDESHARE = 0x2000 

def Get():
	ocb(None)
	pcontents = gcd(1) 
	data = ctypes.c_char_p(pcontents).value
	ccb()
	return data

def startTelem(outfile):
	prev = Get()
	
	while True:
		clip_text = Get()

		if clip_text != prev and clip_text != None:
			prev = clip_text
			window = get_active_window_title()
			with open(outfile, "a+") as myfile:
				myfile.write(str(clip_text) + ', ' + str(strftime("%Y-%m-%d %H:%M:%S")) + ', ' + str(window) + '\n')

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