local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on("update-right-status", function(window, pane)
    local date = wezterm.strftime("%H:%M:%S")
    window:set_right_status(wezterm.format({
        { Text = '[' .. date .. '] ' },
    }))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local cwd = tab.active_pane.current_working_dir.path
    local basename = string.gsub(cwd, "(.*/)(.*/)(.*)", "%2%3")
    return tab.tab_index + 1 .. ': ' .. basename
end)

config.window_padding = {
    left = 2,
    top = 0,
    right = 2,
    bottom = 0,
}
config.color_scheme = 'Solarized Dark - Patched'
config.leader = { key = 'q', mods = 'CTRL', timeout_milliseconds = 1000 }
config.font = wezterm.font("HackGen35")
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"
config.keys = {
    { key = "a", mods = "CMD|SHIFT", action = act.ActivateCommandPalette },

    -- Tab
    { key = "c", mods = "LEADER", action = act { SpawnTab = "CurrentPaneDomain" } },
    { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1)  },
    { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
    { key = '1', mods = 'LEADER', action = act.ActivateTab(0) },
    { key = '2', mods = 'LEADER', action = act.ActivateTab(1) },
    { key = '3', mods = 'LEADER', action = act.ActivateTab(2) },
    { key = '4', mods = 'LEADER', action = act.ActivateTab(3) },
    { key = '5', mods = 'LEADER', action = act.ActivateTab(4) },
    { key = '6', mods = 'LEADER', action = act.ActivateTab(5) },
    { key = '7', mods = 'LEADER', action = act.ActivateTab(6) },
    { key = '8', mods = 'LEADER', action = act.ActivateTab(7) },
    { key = '9', mods = 'LEADER', action = act.ActivateTab(8) },

    -- Pane
    { key = "s", mods = "LEADER", action = act { SplitVertical = { domain  = "CurrentPaneDomain" } } },
    { key = "v", mods = "LEADER", action = act { SplitHorizontal = { domain  = "CurrentPaneDomain" } } },
    { key = "h", mods = "LEADER", action = act { ActivatePaneDirection = "Left" } },
    { key = "j", mods = "LEADER", action = act { ActivatePaneDirection = "Down" } },
    { key = "k", mods = "LEADER", action = act { ActivatePaneDirection = "Up" } },
    { key = "l", mods = "LEADER", action = act { ActivatePaneDirection = "Right" } },
    { key = "H", mods = "LEADER|SHIFT", action = act { AdjustPaneSize = { "Left", 5 } } },
    { key = "J", mods = "LEADER|SHIFT", action = act { AdjustPaneSize = { "Down", 5 } } },
    { key = "K", mods = "LEADER|SHIFT", action = act { AdjustPaneSize = { "Up", 5 } } },
    { key = "L", mods = "LEADER|SHIFT", action = act { AdjustPaneSize = { "Right", 5 } } },
    { key = "x", mods = "LEADER", action = act { CloseCurrentPane = { confirm = true } } },
    { key = "{", mods = "LEADER", action = act.RotatePanes 'Clockwise' },
    { key = "}", mods = "LEADER", action = act.RotatePanes 'CounterClockwise' },

    -- Copy Mode
    { key = "/", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
    {
        key = "[",
        mods = "LEADER",
        action = act.Multiple {
            act.CopyMode("ClearSelectionMode"),
            act.ActivateCopyMode,
            act.ClearSelection
        }
    },
}

config.key_tables = {
    copy_mode = {
        { key = '$', mods = 'NONE', action = act.CopyMode('MoveToEndOfLineContent') },
        { key = '$', mods = 'SHIFT', action = act.CopyMode('MoveToEndOfLineContent') },
        { key = ',', mods = 'NONE', action = act.CopyMode('JumpReverse') },
        { key = '0', mods = 'NONE', action = act.CopyMode('MoveToStartOfLine') },
        { key = ';', mods = 'NONE', action = act.CopyMode('JumpAgain') },
        { key = 'F', mods = 'NONE', action = act.CopyMode { JumpBackward = { prev_char = false } } },
        { key = 'F', mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = false } } },
        { key = 'G', mods = 'NONE', action = act.CopyMode('MoveToScrollbackBottom') },
        { key = 'G', mods = 'SHIFT', action = act.CopyMode('MoveToScrollbackBottom') },
        { key = 'H', mods = 'NONE', action = act.CopyMode('MoveToViewportTop') },
        { key = 'H', mods = 'SHIFT', action = act.CopyMode('MoveToViewportTop') },
        { key = 'L', mods = 'NONE', action = act.CopyMode('MoveToViewportBottom') },
        { key = 'L', mods = 'SHIFT', action = act.CopyMode('MoveToViewportBottom') },
        { key = 'M', mods = 'NONE', action = act.CopyMode('MoveToViewportMiddle') },
        { key = 'M', mods = 'SHIFT', action = act.CopyMode('MoveToViewportMiddle') },
        { key = 'O', mods = 'NONE', action = act.CopyMode('MoveToSelectionOtherEndHoriz') },
        { key = 'O', mods = 'SHIFT', action = act.CopyMode('MoveToSelectionOtherEndHoriz') },
        { key = 'T', mods = 'NONE', action = act.CopyMode { JumpBackward = { prev_char = true } } },
        { key = 'T', mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = true } } },
        { key = 'V', mods = 'NONE', action = act.CopyMode { SetSelectionMode =  'Line' } },
        { key = 'V', mods = 'SHIFT', action = act.CopyMode { SetSelectionMode =  'Line' } },
        { key = '^', mods = 'NONE', action = act.CopyMode('MoveToStartOfLineContent') },
        { key = '^', mods = 'SHIFT', action = act.CopyMode('MoveToStartOfLineContent') },
        { key = 'b', mods = 'NONE', action = act.CopyMode('MoveBackwardWord') },
        { key = 'b', mods = 'ALT', action = act.CopyMode('MoveBackwardWord') },
        { key = 'b', mods = 'CTRL', action = act.CopyMode('PageUp') },
        { key = 'c', mods = 'CTRL', action = act.CopyMode('Close') },
        { key = 'd', mods = 'CTRL', action = act.CopyMode { MoveByPage = (0.5) } },
        { key = 'e', mods = 'NONE', action = act.CopyMode('MoveForwardWordEnd') },
        { key = 'f', mods = 'NONE', action = act.CopyMode { JumpForward = { prev_char = false } } },
        { key = 'f', mods = 'ALT', action = act.CopyMode('MoveForwardWord') },
        { key = 'f', mods = 'CTRL', action = act.CopyMode('PageDown') },
        { key = 'g', mods = 'NONE', action = act.CopyMode('MoveToScrollbackTop') },
        { key = 'g', mods = 'CTRL', action = act.CopyMode('Close') },
        { key = 'h', mods = 'NONE', action = act.CopyMode('MoveLeft') },
        { key = 'j', mods = 'NONE', action = act.CopyMode('MoveDown') },
        { key = 'k', mods = 'NONE', action = act.CopyMode('MoveUp') },
        { key = 'l', mods = 'NONE', action = act.CopyMode('MoveRight') },
        { key = 'm', mods = 'ALT', action = act.CopyMode('MoveToStartOfLineContent') },
        { key = 'o', mods = 'NONE', action = act.CopyMode('MoveToSelectionOtherEnd') },
        { key = 'q', mods = 'NONE', action = act.CopyMode('Close') },
        { key = 't', mods = 'NONE', action = act.CopyMode { JumpForward = { prev_char = true } } },
        { key = 'u', mods = 'CTRL', action = act.CopyMode { MoveByPage = (-0.5) } },
        { key = 'v', mods = 'NONE', action = act.CopyMode { SetSelectionMode =  'Cell' } },
        { key = 'v', mods = 'CTRL', action = act.CopyMode { SetSelectionMode =  'Block' } },
        { key = 'w', mods = 'NONE', action = act.CopyMode('MoveForwardWord') },
        { key = 'y', mods = 'NONE', action = act.Multiple { { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
        { key = 'PageUp', mods = 'NONE', action = act.CopyMode('PageUp') },
        { key = 'PageDown', mods = 'NONE', action = act.CopyMode('PageDown') },
        { key = 'End', mods = 'NONE', action = act.CopyMode('MoveToEndOfLineContent') },
        { key = 'Home', mods = 'NONE', action = act.CopyMode('MoveToStartOfLine') },
        { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode('MoveLeft') },
        { key = 'LeftArrow', mods = 'ALT', action = act.CopyMode('MoveBackwardWord') },
        { key = 'RightArrow', mods = 'NONE', action = act.CopyMode('MoveRight') },
        { key = 'RightArrow', mods = 'ALT', action = act.CopyMode('MoveForwardWord') },
        { key = 'UpArrow', mods = 'NONE', action = act.CopyMode('MoveUp') },
        { key = 'DownArrow', mods = 'NONE', action = act.CopyMode('MoveDown') },
        {
            key = "Escape",
            mods = "NONE",
            action = act.Multiple {
                act.ClearSelection,
                act.CopyMode("ClearPattern"),
                act.CopyMode("Close"),
            },
        },
        {
            key = "[",
            mods = "CTRL",
            action = act.Multiple {
                act.ClearSelection,
                act.CopyMode("ClearPattern"),
                act.CopyMode("Close"),
            },
        },
	 	{ key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
	 	{
	 		key = "n",
	 		mods = "NONE",
	 		action = act.Multiple {
	 			act.CopyMode("NextMatch"),
	 			act.CopyMode("ClearSelectionMode"),
	 		},
	 	},
	 	{
	 		key = "N",
	 		mods = "SHIFT",
	 		action = act.Multiple {
	 			act.CopyMode("PriorMatch"),
	 			act.CopyMode("ClearSelectionMode"),
	 		},
	 	},
	 	{
	 		key = "Enter",
	 		mods = "NONE",
	 		action = act.CopyMode("ClearSelectionMode"),
	 	},
    },

    search_mode = {
		{
			key = "Enter",
			mods = "NONE",
			action = act.Multiple {
				act.CopyMode("ClearSelectionMode"),
				act.ActivateCopyMode,
			},
		},
        { key = 'Escape', mods = 'NONE', action = act.CopyMode('Close') },
        { key = 'c', mods = 'CTRL', action = act.CopyMode('Close') },
        { key = '[', mods = 'CTRL', action = act.CopyMode('Close') },
        { key = 'n', mods = 'CTRL', action = act.CopyMode('NextMatch') },
        { key = 'p', mods = 'CTRL', action = act.CopyMode('PriorMatch') },
        { key = 'r', mods = 'CTRL', action = act.CopyMode('CycleMatchType') },
        { key = 'u', mods = 'CTRL', action = act.CopyMode('ClearPattern') },
        { key = 'PageUp', mods = 'NONE', action = act.CopyMode('PriorMatchPage') },
        { key = 'PageDown', mods = 'NONE', action = act.CopyMode('NextMatchPage') },
        { key = 'UpArrow', mods = 'NONE', action = act.CopyMode('PriorMatch') },
        { key = 'DownArrow', mods = 'NONE', action = act.CopyMode('NextMatch') },
    }
}
return config
