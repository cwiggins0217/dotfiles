local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end
--config.color_scheme = 'Tokyo Night Storm'
config.font = wezterm.font_with_fallback({
  { family = "0xProto Nerd Font Propo", scale = 1.25 },
  { family = "JoyPixels", scale = 1.33 },
  { family = "Font Awesome 6 Free", scale = 1.33 },
})

config.window_padding = {
  left = 5,
  right = 0,
  top = 5,
  bottom = 0,
}

config.color_schemes = {
  ['Solarized Osaka'] = {
    background = '#001419',
    foreground = '#a8a8a8',
    ansi = {
      '#001419', -- black
      '#b7211f', -- red
      '#596600', -- green
      '#b58900', -- yellow
      '#1b6497', -- blue
      '#b02669', -- magenta
      '#2aa198', -- cyan
      '#657b83', -- white
    },
    brights = {
      '#002b36', -- bright black
      '#dc322f', -- bright red
      '#859900', -- bright green
      '#ffc100', -- bright yellow
      '#268bd2', -- bright blue
      '#d33682', -- bright magenta
      '#29eedf', -- bright cyan
      '#a8a8a8', -- bright white
    },
  },
}
config.color_scheme = 'Solarized Osaka'
--config.color_scheme = 'Solarized (dark) (terminal.sexy)'

config.default_prog = { 'bash', '-c', 'tmux -q has-session && exec tmux attach-session || tmux new-session -n $USER -s$USER@$HOSTNAME' }
config.window_background_opacity = 0.90
config.enable_wayland = false
config.window_decorations = "RESIZE | TITLE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "Home"
config.hide_tab_bar_if_only_one_tab = true
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 165
config.term = "xterm-256color"

return config
