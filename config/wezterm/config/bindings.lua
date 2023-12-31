local wezterm = require("wezterm")
local platform = require("utils.platform")()
local act = wezterm.action

local mod = {}

local keys = {
	{
		key = "R",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{ key = "1", mods = "ALT", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "ALT", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "ALT", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "ALT", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "ALT", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "ALT", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "ALT", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "ALT", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "ALT", action = wezterm.action({ ActivateTab = 8 }) },
	{ key = "LeftArrow", mods = "ALT", action = wezterm.action({ MoveTabRelative = -1 }) },
	{ key = "RightArrow", mods = "ALT", action = wezterm.action({ MoveTabRelative = 1 }) },
	{ key = "LeftArrow", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "RightArrow", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "t", mods = "SHIFT|CTRL", action = wezterm.action({ SpawnTab = "DefaultDomain" }) },
	{ key = "h", mods = "SHIFT|CTRL", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "SHIFT|CTRL", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "SHIFT|CTRL", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "SHIFT|CTRL", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "v", mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "c", mods = "SHIFT|CTRL", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "q", mods = "SHIFT|CTRL", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	-- { key = "x", mods = "CTRL", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "-", mods = "CTRL", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\", mods = "CTRL", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "w", mods = "CTRL", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
}

local key_tables = {
	resize_font = {
		{ key = "k", action = act.IncreaseFontSize },
		{ key = "j", action = act.DecreaseFontSize },
		{ key = "r", action = act.ResetFontSize },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "q", action = "PopKeyTable" },
	},
	resize_pane = {
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "q", action = "PopKeyTable" },
	},
}

local mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

return {
	disable_default_key_bindings = true,
	leader = { key = "Space", mods = "CTRL|SHIFT" },
	keys = keys,
	key_tables = key_tables,
	mouse_bindings = mouse_bindings,
}
