local hyperModifier = {"cmd","alt","ctrl"}
local windowModifer = {"ctrl","cmd"}

hs.window.animationDuration=0

--Hammerspoon Control Helpers
--hs.hotkey.bind(hyperModifier,"W", function() hs.alert.show("Hello World!") end)
hs.hotkey.bind(hyperModifier, "y" , hs.toggleConsole)
hs.hotkey.bind(hyperModifier, "r" , function() hs.console.clearConsole(); hs.reload(); end)

--These replace quicksilver triggers in a tighter package
hs.hotkey.bind({"alt"}, "0", function() hs.application.launchOrFocus("Finder") end)
hs.hotkey.bind({"alt"}, "1", function() hs.application.launchOrFocus("GMAIL") end)
hs.hotkey.bind({"alt"}, "2", function() hs.application.launchOrFocus("Google Chat") end)
hs.hotkey.bind({"alt"}, "3", function() hs.application.launchOrFocus("Google Calendar") end)
hs.hotkey.bind({"alt"}, "4", function() hs.application.launchOrFocus("Google Drive") end)
hs.hotkey.bind({"alt"}, "5", function() hs.application.launchOrFocus("Google Keep") end)

hs.hotkey.bind({"alt"}, "7", function() hs.application.launchOrFocus("lichess.org") end)
hs.hotkey.bind({"alt"}, "8", function() hs.application.launchOrFocus("Stickies") end)
hs.hotkey.bind({"alt"}, "9", function() hs.application.launchOrFocus("Youtube Music") end)
