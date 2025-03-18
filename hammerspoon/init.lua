hs.loadSpoon("SpoonInstall")

local super = { "ctrl", "cmd" }

hs.hotkey.bind(super, "`", hs.reload)

BackspaceRemap = hs.eventtap
	.new({ hs.eventtap.event.types.keyDown }, function(event)
		if event:getFlags():containExactly({ "shift" }) and event:getKeyCode() == hs.keycodes.map["delete"] then
			return true, hs.eventtap.keyStroke("alt", "delete", 0)
		end
	end)
	:start()

---- KeyMap to use C-n and C-p for up and down
local nonTerminalHotkeys = {
	hs.hotkey.new("ctrl", "n", function()
		hs.eventtap.keyStroke({}, "down", 0)
	end),
	hs.hotkey.new("ctrl", "p", function()
		hs.eventtap.keyStroke({}, "up", 0)
	end),
}

local enableHotkeys = function()
	for _, hotkey in ipairs(nonTerminalHotkeys) do
		hotkey:enable()
	end
end

local disableHotkeys = function()
	for _, hotkey in ipairs(nonTerminalHotkeys) do
		hotkey:disable()
	end
end

TerminalWindowFilter = hs.window.filter.new({ "Ghostty" })
TerminalWindowFilter:subscribe(hs.window.filter.windowFocused, disableHotkeys)
TerminalWindowFilter:subscribe(hs.window.filter.windowUnfocused, enableHotkeys)

---- Launching Specific Apps
spoon.SpoonInstall:andUse("AppLauncher", {
	config = { modifiers = super },
	hotkeys = {
		q = "Finder",
		w = "Ghostty",
		e = "Brave Browser",
		a = "zoom.us",
		s = "Bruno",
		d = "Slack",
	},
})

---- window management
hs.window.animationDuration = 0

spoon.SpoonInstall:andUse("WindowHalfsAndThirds", {
	hotkeys = {
		left_half = { super, "h" },
		right_half = { super, "l" },
		bottom_half = { super, "j" },
		top_half = { super, "k" },
		max = { super, "return" },
		top_left = { super, "u" },
		top_right = { super, "o" },
		bottom_left = { super, "m" },
		bottom_right = { super, "." },
	},
})

spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", {
	config = { animationDuration = 0 },
	hotkeys = {
		screen_left = { super, "1" },
		screen_right = { super, "2" },
	},
})

-- HANDLE SCROLLING WITH MOUSE BUTTON PRESSED
local deferred = false

OverrideOtherMouseDown = hs.eventtap.new({ hs.eventtap.event.types.rightMouseDown }, function()
	deferred = true
	return true
end)

OverrideOtherMouseUp = hs.eventtap.new({ hs.eventtap.event.types.rightMouseUp }, function(e)
	if deferred then
		OverrideOtherMouseDown:stop()
		OverrideOtherMouseUp:stop()
		hs.eventtap.rightClick(e:location(), pressedMouseButton)
		OverrideOtherMouseDown:start()
		OverrideOtherMouseUp:start()
		return true
	end
	return false
end)

local oldmousepos = {}
local scrollmult = -2.5 -- negative multiplier makes mouse work like traditional scrollwheel, for macOS, use positive number.

DragOtherToScroll = hs.eventtap.new({ hs.eventtap.event.types.rightMouseDragged }, function(e)
	deferred = false
	oldmousepos = hs.mouse.absolutePosition()
	local dx = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaX"])
	local dy = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaY"])
	local scroll = hs.eventtap.event.newScrollEvent({ dx * scrollmult, dy * scrollmult }, {}, "pixel")
	-- put the mouse back
	hs.mouse.absolutePosition(oldmousepos)
	return true, { scroll }
end)

OverrideOtherMouseDown:start()
OverrideOtherMouseUp:start()
DragOtherToScroll:start()
