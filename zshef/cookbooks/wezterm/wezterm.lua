local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on("update-right-status", function(window, pane)
    local local_date = wezterm.strftime("%F %H:%M:%S")
    local utc_date = wezterm.strftime_utc("%F %H:%M UTC")
    window:set_right_status(wezterm.format({
        { Foreground = { Color = "grey" } },
        { Text = '(' .. utc_date .. ') ' },
        'ResetAttributes',
        { Text = local_date .. '    ' },
    }))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local cwd = tab.active_pane.current_working_dir.path
    local basename = string.gsub(cwd, "(.*/)(.*/)(.*)", "%2%3")
    return tab.tab_index + 1 .. ': ' .. basename
end)

local function active_copy_mode()
    return wezterm.action_callback(function(window, pane, _)
        window:perform_action(act.ActivateCopyMode, pane)
        wezterm.sleep_ms(100)
        window:perform_action(act.CopyMode("ClearSelectionMode"), pane)
        window:perform_action(act.ClearSelection, pane)
    end)
end

config.window_padding = {
    left = 2,
    top = 0,
    right = 2,
    bottom = 0,
}
config.color_scheme = 'Solarized Dark - Patched'
config.colors = {
    selection_fg = '#ffffff',
    selection_bg = 'rgba(114,84,179,0.75)',
    copy_mode_active_highlight_fg = { Color = '#ffffff' },
    copy_mode_active_highlight_bg = { Color = 'rgba(114,84,179,0.75)' },
    copy_mode_inactive_highlight_fg = { Color = 'rgba(128,128,128,1)' },
    copy_mode_inactive_highlight_bg = { Color = 'rgba(114,84,179,0.5)' },
}
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
    { key = "x", mods = "LEADER", action = act { CloseCurrentPane = { confirm = true } } },
    { key = "{", mods = "LEADER", action = act.RotatePanes 'Clockwise' },
    { key = "}", mods = "LEADER", action = act.RotatePanes 'CounterClockwise' },
    {
        key = 'h',
        mods = 'LEADER',
        action = act.Multiple {
            act { ActivatePaneDirection = "Left" },
            act.ActivateKeyTable { name = 'activate_pane_left', one_shot = false, timeout_milliseconds = 400, until_unknown = true }
        },
    },
    {
        key = 'j',
        mods = 'LEADER',
        action = act.Multiple {
            act { ActivatePaneDirection = "Down" },
            act.ActivateKeyTable { name = 'activate_pane_down', one_shot = false, timeout_milliseconds = 400, until_unknown = true }
        },
    },
    {
        key = 'k',
        mods = 'LEADER',
        action = act.Multiple {
            act { ActivatePaneDirection = "Up" },
            act.ActivateKeyTable { name = 'activate_pane_up', one_shot = false, timeout_milliseconds = 400, until_unknown = true }
        },
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = act.Multiple {
            act { ActivatePaneDirection = "Right" },
            act.ActivateKeyTable { name = 'activate_pane_right', one_shot = false, timeout_milliseconds = 400, until_unknown = true }
        },
    },
    {
        key = 'h',
        mods = 'LEADER|SHIFT',
        action = act.Multiple {
            act { AdjustPaneSize = { "Left", 1 } },
            act.ActivateKeyTable { name = 'resize_pane_left', one_shot = false, timeout_milliseconds = 400 },
        }
    },
    {
        key = 'j',
        mods = 'LEADER|SHIFT',
        action = act.Multiple {
            act { AdjustPaneSize = { "Down", 1 } },
            act.ActivateKeyTable { name = 'resize_pane_down', one_shot = false, timeout_milliseconds = 400 },
        }
    },
    {
        key = 'k',
        mods = 'LEADER|SHIFT',
        action = act.Multiple {
            act { AdjustPaneSize = { "Up", 1 } },
            act.ActivateKeyTable { name = 'resize_pane_up', one_shot = false, timeout_milliseconds = 400 },
        },
    },
    {
        key = 'l',
        mods = 'LEADER|SHIFT',
        action = act.Multiple {
            act { AdjustPaneSize = { "Right", 1 } },
            act.ActivateKeyTable { name = 'resize_pane_right', one_shot = false, timeout_milliseconds = 400 },
        }
    },

    -- Copy Mode
    { key = "/", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
    {
        key = "[",
        mods = "LEADER",
        action = active_copy_mode()
    },
}

active_pane_actions = {
    { key = "h", action = act { ActivatePaneDirection = "Left" } },
    { key = "j", action = act { ActivatePaneDirection = "Down" } },
    { key = "k", action = act { ActivatePaneDirection = "Up" } },
    { key = "l", action = act { ActivatePaneDirection = "Right" } },
}

config.key_tables = {
    activate_pane_left = active_pane_actions,
    activate_pane_down = active_pane_actions,
    activate_pane_up = active_pane_actions,
    activate_pane_right = active_pane_actions,

    resize_pane_left = {
        { key = "h", mods = "SHIFT", action = act { AdjustPaneSize = { "Left", 2 } } },
    },
    resize_pane_down = {
        { key = "j", mods = "SHIFT", action = act { AdjustPaneSize = { "Down", 2 } } },
    },
    resize_pane_up = {
        { key = "k", mods = "SHIFT", action = act { AdjustPaneSize = { "Up", 2 } } },
    },
    resize_pane_right = {
        { key = "l", mods = "SHIFT", action = act { AdjustPaneSize = { "Right", 2 } } },
    },

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
        { key = 'h', mods = 'CTRL', action = act.SendKey { key = 'Backspace' } },
        { key = 'w', mods = 'CTRL', action = act.CopyMode('ClearPattern') },
    }
}

config.mouse_bindings = {
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.Nop,
  },

  -- and make CTRL-Click open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SUPER',
    action = act.OpenLinkAtMouseCursor,
  }
}

return config
