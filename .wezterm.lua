local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then config = wezterm.config_builder() end
config.font = wezterm.font_with_fallback({
  { family = "0xProto Nerd Font", scale = 1.25 },
--{ family = "JoyPixels", scale = 1.33 },
--  { family = "Font Awesome 6 Free", scale = 1.33 },
})

-- Color scheme name
config.color_scheme = "Hermetic Alchemy"

-- Define the Hermetic Alchemy theme
config.color_schemes = {
  ["Hermetic Alchemy"] = {
    foreground = "#e0e0e0", -- Albedo
    background = "#1c1c1c", -- Nigredo
    cursor_bg = "#ff6b6b",  -- Citrinitas
    cursor_fg = "#1c1c1c",
    cursor_border = "#f6c700",
    selection_fg = "#e0e0e0",
    selection_bg = "#888888", -- Salt

    ansi = {
      "#1c1c1c", -- black (nigredo)
      "#a34a35", -- red (rubedo)
      "#789262", -- green (green lion)
      "#e5c07b", -- yellow (citrinitas)
      "#5ab0d6", -- blue (mercury)
      "#9370db", -- magenta (aether)
      "#999688", -- cyan (salt)
      "#e8e6dc", -- white (albedo)
    },

    brights = {
      "#2e2e2e", -- bright black
      "#c06b54", -- bright red (sulphur)
      "#92b06f", -- bright green (vegetation)
      "#f8d57d", -- bright yellow (illumination)
      "#74c6eb", -- bright blue (refined mercury)
      "#b29ae3", -- bright magenta (crowned spirit)
      "#bcb5a5", -- bright cyan (refined salt)
      "#f6f1e7", -- bright white (transcendent albedo)
    },
  },
}

config.window_padding = {
  left = 20,
  right = 0,
  top = 20,
  bottom = 0,
}

config.default_prog = { 'bash', '-c', 'tmux -q has-session && exec tmux attach-session || tmux new-session -n $USER -s$USER@$HOSTNAME' }
config.window_background_opacity =  1.00
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
