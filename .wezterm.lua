local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_prog = { 'cmd', '/K', 'D:\\bin\\initcmd.bat' }
config.default_cwd = 'E:\\'
config.color_scheme = 'OneDark (base16)'
config.font = wezterm.font 'Cascadia Mono'
config.use_fancy_tab_bar = false

return config