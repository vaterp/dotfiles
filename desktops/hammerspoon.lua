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


--Trying to replace Rectangle because I can set multiple keys this way.
--  bottom left, bottom right, max height, almost maximize, smaller, larger
-- cetner, restore, 

function maximizeCurrentWindow() 
  hs.window.focusedWindow():maximize() 
end

function moveCurrentWindowToNextScreen()
  local win = hs.window.focusedWindow()
  win:moveToScreen(win:screen():next())
end

function moveCurrentWindowToLeftHalf()
  local win = hs.window.focusedWindow()
  local screenFrame = win:screen():frame()
  win:setFrame(hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w / 2, screenFrame.h))
end

function moveCurrentWindowToRightHalf()
  local win = hs.window.focusedWindow()
  local screenFrame = win:screen():frame()
  win:setFrame(hs.geometry.rect(screenFrame.x + screenFrame.w / 2, screenFrame.y, screenFrame.w / 2, screenFrame.h))
end

hs.hotkey.bind(hyperModifier, "pad*", maximizeCurrentWindow)

hs.hotkey.bind(hyperModifier, "pad6", moveCurrentWindowToRightHalf)
hs.hotkey.bind(hyperModifier, "right", moveCurrentWindowToRightHalf)

hs.hotkey.bind(hyperModifier, "pad4", moveCurrentWindowToLeftHalf)
hs.hotkey.bind(hyperModifier, "left", moveCurrentWindowToLeftHalf)

hs.hotkey.bind(hyperModifier, "space", moveCurrentWindowToNextScreen)


--- Playing

hs.hotkey.bind(hyperModifier, 'c', function() hs.window.focusedWindow():centerOnScreen() end)
----hs.hotkey.bind(hyperModifier, 'd', function()
----  local win = hs.window.focusedWindow()
-----  local f = win:frame()
-----  local max = win:screen():frame()

-----  local x = f

 ----- x.x = ((max.w - f.w) / 2) + max.x
-----  x.y = ((max.h - f.h) / 2) + max.y
 ----- win:setFrame(x)
 ------end)



--[=====[Using hs.grid stuff:

local This = {}
-- To easily layout windows on the screen, we use hs.grid to create
-- a 4x4 grid. If you want to use a more detailed grid, simply 
-- change its dimension here
local GRID_SIZE = 4
local HALF_GRID_SIZE = GRID_SIZE / 2
-- Set the grid size and add a few pixels of margin
-- Also, don't animate window changes... That's too slow
hs.grid.setGrid(GRID_SIZE .. 'x' .. GRID_SIZE)
hs.grid.setMargins({5, 5})
local screenPositions       = {}
screenPositions.left        = {
  x = 0, y = 0,
  w = HALF_GRID_SIZE, h = GRID_SIZE
}
screenPositions.right       = {
  x = HALF_GRID_SIZE, y = 0,
  w = HALF_GRID_SIZE, h = GRID_SIZE
}
screenPositions.top         = {
  x = 0, y = 0,
  w = GRID_SIZE, h = HALF_GRID_SIZE
}
screenPositions.bottom      = {
  x = 0, y = HALF_GRID_SIZE,
  w = GRID_SIZE, h = HALF_GRID_SIZE
}
screenPositions.topLeft     = {
  x = 0, y = 0,
  w = HALF_GRID_SIZE, h = HALF_GRID_SIZE
}
screenPositions.topRight    = {
  x = HALF_GRID_SIZE, y = 0,
  w = HALF_GRID_SIZE, h = HALF_GRID_SIZE
}
screenPositions.bottomLeft  = {
  x = 0, y = HALF_GRID_SIZE,
  w = HALF_GRID_SIZE, h = HALF_GRID_SIZE
}
screenPositions.bottomRight = {
  x = HALF_GRID_SIZE, y = HALF_GRID_SIZE,
  w = HALF_GRID_SIZE, h = HALF_GRID_SIZE
}
This.screenPositions = screenPositions

-- This function will move either the specified or the focuesd
-- window to the requested screen position
function This.moveWindowToPosition(cell, window)
  if window == nil then
    window = hs.window.focusedWindow()
  end
  if window then
    local screen = window:screen()
    hs.grid.set(window, cell, screen)
  end
end
-- This function will move either the specified or the focused
-- window to the center of the sreen and let it fill up the
-- entire screen.
function This.windowMaximize(factor, window)
   if window == nil then
      window = hs.window.focusedWindow()
   end
   if window then
      window:maximize()
   end
end
return This

--]=====]



--[=====[Trying to build a clipboard replacer

hs.hotkey.bind({"cmd"}, "0", function()
    hs.eventtap.keyStroke({"cmd"}, "c")
    copy = hs.pasteboard.getContents()
    for index = 8, 0, -1 do
      paste = hs.pasteboard.readAllData(tostring(index))
      if paste["public.utf8-plain-text"] == nil then
        hs.pasteboard.writeObjects("", tostring(index + 1))
      else
        hs.pasteboard.writeObjects(paste["public.utf8-plain-text"], tostring(index + 1))
      end
    end
    hs.pasteboard.writeObjects(copy, "0")
    hs.pasteboard.setContents(copy)
end)


local choices = {}
local function focusLastFocused()
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then lastFocused[1]:focus() end
end
local chooser = hs.chooser.new(function(choice)
    if not choice then focusLastFocused(); return end
    hs.pasteboard.setContents(choice["text"])
    focusLastFocused()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
function get_content(index)
  paste = hs.pasteboard.readAllData(tostring(index));
  return paste["public.utf8-plain-text"];
end
function update_choices()
  choices = {}
  for i = 1, 9, 1 do
    table.insert(choices,{["text"] = get_content(i)})
  end
  chooser:choices(choices)
end
hs.hotkey.bind(hyperModifier, "e", function() update_choices() chooser:show() end)
--]=====]

--hs.hotkey.bind(hyperModifier, "up", moveCurrentWindowToNextScreen)
--hs.hotkey.bind(hyperModifier, "down", moveCurrentWindowToNextScreen)


--hs.hotkey.bindSpec({ { "ctrl", "cmd", "alt" }, "left" }, moveCurrentWindowToLeftHalf)
--hs.hotkey.bindSpec({ { "ctrl", "cmd", "alt" }, "left" }, moveCurrentWindowToLeftHalf)
--hs.hotkey.bindSpec({ { "ctrl", "cmd", "alt" }, "left" }, moveCurrentWindowToLeftHalf)


--hs.hotkey.bind(hyperModifier, "w", function() hs.application.launchOrFocusByBundleID("com.jetbrains.intellij") end)


--HELP/EXAMPLES

--https://www.hammerspoon.org/docs/hs.application.html#launchOrFocus
--https://github-wiki-see.page/m/Hammerspoon/hammerspoon/wiki/Sample-Configurations
--https://github.com/mengelbrecht/hammerspoon-config/blob/main/init.lua


-- hs.fnutils.each(hs.application.runningApplications(), function(app) print(app:title()) end)
