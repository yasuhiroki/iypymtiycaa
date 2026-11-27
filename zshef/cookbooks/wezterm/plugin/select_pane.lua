local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

local DEFAULT_OPTS = {
  title = 'Select Pane',
  fuzzy = true,
  key = 'i',
  mods = 'LEADER',
  ai_state_var = 'AI_STATE',
  ai_agent_patterns = { 'copilot$', 'agy$' },
  ignored_titles = {
    [''] = true,
    ['Thanks for flying Vim'] = true,
  },
  colors = {
    index = '#2aa198',
    cwd = '#268bd2',
    title = '#93a1a1',
    ai_running = '#859900',
    ai_ask = '#cb4b16',
    ai_complete = '#b58900',
    ai_idle = '#586e75',
  },
}

local AI_BADGES = {
  running = { text = ' [AI: running]', color_key = 'ai_running', bold = true },
  ask = { text = ' [AI: ask]', color_key = 'ai_ask', bold = true },
  complete = { text = ' [AI: complete]', color_key = 'ai_complete', bold = true },
  idle = { text = ' [AI: idle]', color_key = 'ai_idle', bold = false },
}

local function merge_options(opts)
  local resolved = {}
  for k, v in pairs(DEFAULT_OPTS) do
    if k ~= 'colors' then
      resolved[k] = v
    end
  end

  resolved.colors = {}
  for k, v in pairs(DEFAULT_OPTS.colors) do
    resolved.colors[k] = v
  end

  if opts then
    for k, v in pairs(opts) do
      if k == 'colors' and type(v) == 'table' then
        for ck, cv in pairs(v) do
          resolved.colors[ck] = cv
        end
      else
        resolved[k] = v
      end
    end
  end

  return resolved
end

local function format_cwd(cwd_url, home_dir)
  if not cwd_url then
    return ''
  end

  local pwd = cwd_url.file_path or cwd_url.path or ''
  if pwd == '' then
    return ''
  end

  local normalized_home = home_dir or ''
  if #normalized_home > 1 then
    normalized_home = normalized_home:gsub('/+$', '')
  end

  if #pwd > 1 then
    pwd = pwd:gsub('/+$', '')
  end

  if normalized_home ~= '' and normalized_home ~= '/' then
    if pwd == normalized_home then
      pwd = '~'
    elseif pwd:sub(1, #normalized_home + 1) == normalized_home .. '/' then
      pwd = '~' .. pwd:sub(#normalized_home + 1)
    end
  end

  return pwd
end

local function resolve_display_title(pane, ignored_titles)
  local title = pane:get_title() or ''
  if not ignored_titles[title] then
    return title
  end

  -- Remote or exited panes can raise when querying foreground process info.
  local ok, proc_path = pcall(function()
    return pane:get_foreground_process_name()
  end)
  if ok and proc_path and proc_path ~= '' then
    return proc_path:match('([^/]+)$') or proc_path
  end

  return title
end

local function has_ai_agent_process(pane, patterns)
  if not patterns or #patterns == 0 then
    return false
  end

  -- Remote or exited panes can raise when querying foreground process info.
  local ok, process = pcall(function()
    return pane:get_foreground_process_info()
  end)
  if not ok or not process or not process.argv then
    return false
  end

  for _, arg in ipairs(process.argv) do
    for _, pattern in ipairs(patterns) do
      if arg:match(pattern) then
        return true
      end
    end
  end

  return false
end

local function resolve_ai_status(pane, opts)
  if not has_ai_agent_process(pane, opts.ai_agent_patterns) then
    return nil
  end

  local user_vars = pane:get_user_vars() or {}
  local ai_state = user_vars[opts.ai_state_var]
  if ai_state and AI_BADGES[ai_state] then
    return ai_state
  end

  return 'idle'
end

local function append_segment(items, text, color, bold)
  table.insert(items, { Foreground = { Color = color } })
  if bold then
    table.insert(items, { Attribute = { Intensity = 'Bold' } })
  end
  table.insert(items, { Text = text })
  table.insert(items, 'ResetAttributes')
end

local function format_choice_label(entry, colors)
  local items = {}
  append_segment(items, string.format('%d:%d ', entry.tab_idx, entry.pane_idx), colors.index, false)

  if entry.pwd ~= '' then
    append_segment(items, string.format('@%s ', entry.pwd), colors.cwd, false)
  end

  append_segment(items, entry.title, colors.title, true)

  local badge = entry.ai_status and AI_BADGES[entry.ai_status]
  if badge then
    append_segment(items, badge.text, colors[badge.color_key], badge.bold)
  end

  return wezterm.format(items)
end

local function collect_choices(window, opts)
  local choices = {}
  local mux_win = window:mux_window()
  if not mux_win then
    return choices
  end

  local home = wezterm.home_dir or ''
  local tabs = mux_win:tabs() or {}

  for tab_idx, tab in ipairs(tabs) do
    for pane_idx, target_pane in ipairs(tab:panes() or {}) do
      local entry = {
        tab_idx = tab_idx,
        pane_idx = pane_idx,
        pwd = format_cwd(target_pane:get_current_working_dir(), home),
        title = resolve_display_title(target_pane, opts.ignored_titles),
        ai_status = resolve_ai_status(target_pane, opts),
      }
      table.insert(choices, {
        id = tostring(target_pane:pane_id()),
        label = format_choice_label(entry, opts.colors),
      })
    end
  end

  return choices
end

local function activate_pane_by_id(id)
  local pane_id = tonumber(id)
  if not pane_id then
    return
  end

  local target = wezterm.mux.get_pane(pane_id)
  if target then
    target:activate()
  end
end

function M.action(opts)
  local resolved = merge_options(opts)

  return wezterm.action_callback(function(window, pane)
    local choices = collect_choices(window, resolved)
    window:perform_action(
      act.InputSelector {
        title = resolved.title,
        fuzzy = resolved.fuzzy,
        choices = choices,
        action = wezterm.action_callback(function(_, _, id, _)
          activate_pane_by_id(id)
        end),
      },
      pane
    )
  end)
end

function M.apply_to_config(config, opts)
  local resolved = merge_options(opts)
  config.keys = config.keys or {}
  table.insert(config.keys, {
    key = resolved.key,
    mods = resolved.mods,
    action = M.action(resolved),
  })
end

return M
