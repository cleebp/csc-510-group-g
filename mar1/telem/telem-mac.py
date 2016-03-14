import Tkinter as tk
from time import gmtime, strftime
import applescript
import sys, getopt


def startTelem(outfile):
	
	root = tk.Tk()

	root.withdraw()
	prev = ""

	while True:
		clip_text = root.clipboard_get()
		if clip_text != prev:
			prev = clip_text
			window = get_active_window_title()
			with open(outfile, "a+") as myfile:
				myfile.write(str(clip_text) + ', ' +  str(strftime("%Y-%m-%d %H:%M:%S")) + ', ' + str(window) + '\n')

def get_active_window_title():
	scpt = applescript.AppleScript('''
	global frontApp, frontAppName, windowTitle
	set windowTitle to ""
	tell application "System Events"
		set frontApp to first application process whose frontmost is true
		set frontAppName to name of frontApp
		tell process frontAppName
			tell (1st window whose value of attribute "AXMain" is true)
				set windowTitle to value of attribute "AXTitle"
			end tell
		end tell
	end tell
	return {frontAppName, windowTitle}
	''')

	window = scpt.run()
	return window


def main(argv):
	outputfile = ''
	try:
		opts, args = getopt.getopt(argv,"ho:",["ofile="])
	except getopt.GetoptError:
		print 'telem-mac.py -o <outputfilename> (default path is current directory)'
		sys.exit(2)
	for opt, arg in opts:
		if opt == '-h':
 			print 'telem-mac.py -o <outputfilename> (default path is current directory)'
 			sys.exit()
		elif opt in ("-o", "--ofile"):
			outputfile = "./" + arg
	startTelem(outputfile)
	

   
if __name__ == "__main__":
   main(sys.argv[1:])
