local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

config.default_prog = { 'powershell.exe' }

config.color_scheme = 'Darcula (base16)'
config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", scale = 0.90 }, -- adjust scale as needed
})

config.keys = {
	{
		key = '%',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
	},
	{
		key = '"',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
	},
	{
		key = 'h',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ActivatePaneDirection 'Left',
	},
	{
		key = 'l',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ActivatePaneDirection 'Right',
	},
	{
		key = 'k',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ActivatePaneDirection 'Up',
	},
	{
		key = 'j',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ActivatePaneDirection 'Down',
	},
	{
		key = 'f',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.ToggleFullScreen,
	},

config.window_background_opacity = 1.00
config.enable_wayland = true  			-- sometimes use xorg/xlibre so adjust as needed
config.window_decorations = "RESIZE | TITLE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "Home"
config.hide_tab_bar_if_only_one_tab = true
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 60                        -- also adjust to screen refresh rate as needed

return config
