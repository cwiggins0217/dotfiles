local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end
config.color_scheme = 'Builtin Solarized Dark'
config.font = wezterm.font_with_fallback({
  { family = "0xProto Nerd Font", scale = 1.33 },
  { family = "JoyPixels", scale = 1.33 },
  { family = "Font Awesome 6 Free", scale = 1.33 },
})

config.window_padding = {
  left = 5,
  top = 5,
}

config.default_prog = { 'bash', '-c', 'tmux -q has-session && exec tmux attach-session || tmux new-session -n $USER -s$USER@$HOSTNAME' }
config.window_background_opacity = 1.00
config.enable_wayland = false
config.window_decorations = "RESIZE | TITLE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "Home"
config.hide_tab_bar_if_only_one_tab = true
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 144
config.term = "xterm-256color"

return config
