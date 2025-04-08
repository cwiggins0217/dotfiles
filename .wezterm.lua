local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end
config.color_scheme = "Papercolor Dark (Gogh)"
config.font = wezterm.font_with_fallback({
  { family = "OverpassM Nerd Font Mono", scale = 1.50 },
  { family = "Font Awesome 6 Free", scale = 1.50 },
})

config.window_padding = {
  left = 20,
  right = 0,
  top = 20,
  bottom = 0,
}

-- toggle fullscreen
config.keys = {
  {
    key = 'f',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}

config.default_prog = { 'bash', '-c', 'tmux -q has-session && exec tmux attach-session || tmux new-session -n $USER -s$USER@$HOSTNAME' }

config.window_background_opacity = 1.0
config.enable_wayland = true
config.window_decorations = "RESIZE | TITLE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "Home"
config.hide_tab_bar_if_only_one_tab = true
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 165
config.term = "xterm-256color"

return config
