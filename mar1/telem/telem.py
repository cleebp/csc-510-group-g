import Tkinter as tk
from time import gmtime, strftime
import applescript




root = tk.Tk()

root.withdraw()
prev = ""

def get_active_window_title():
	scpt = applescript.AppleScript('''
	osascript<<END
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
	END
	''')

	window = scpt.run()
	return window

while True:
	clip_text = root.clipboard_get()
	if clip_text != prev:
		prev = clip_text
		window = get_active_window_title()
		with open("./clipit.txt", "a+") as myfile:
			myfile.write(str(clip_text) + ', ' +  str(strftime("%Y-%m-%d %H:%M:%S")) + ', ' + str(window) + '\n')