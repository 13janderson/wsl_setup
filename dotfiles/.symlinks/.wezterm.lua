local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
config.default_domain = 'WSL:Ubuntu'

-- This is where you actually apply your config choices.
-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 20

config.window_close_confirmation = "NeverPrompt"

-- Stop showing warnings about missing glyphs in font 
config.warn_about_missing_glyphs = false

-- Zooming does not adjust the size of the actual window anymore
config.adjust_window_size_when_changing_font_size = false

config.automatically_reload_config = true

config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = false
-- config.integrated_title_buttons = { 'Close' }
config.window_decorations = "TITLE | RESIZE"

-- Ctrl+V for paste
config.keys = {
  {
    key = "v",
    mods = "CTRL",
    action = wezterm.action.PasteFrom("Clipboard")
  },
}

-- or, changing the font size and color scheme.
config.font_size = 10

-- You can specify some parameters to influence the font selection;
-- for example, this selects a Bold, Italic font variant.
config.font = wezterm.font('JetBrains Mono', { weight = 600, italic = false})
config.color_scheme = "Adventure"

-- Finally, return the configuration to wezterm:
return config
