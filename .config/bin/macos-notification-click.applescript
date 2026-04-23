tell application "System Events"
	tell process "NotificationCenter"
		if (count of windows) > 0 then
			set theWindow to window 1
			try
				-- Sequoia: click first notification group in scroll area
				click (first group of UI element 1 of scroll area 1 of theWindow)
			on error
				-- Fallback: click the window directly
				click theWindow
			end try
		end if
	end tell
end tell
