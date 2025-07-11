# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.config.show_banner = false
$env.PROMPT_COMMAND = { $"(pwd)\n" }
$env.PROMPT_COMMAND_RIGHT = { "" }
$env.config.buffer_editor = "code"

alias ar = php artisan
alias n = nvy
alias hx = D:\Helix\hx.exe
alias vcvars = `D:\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat` x64

alias zipdiff = tar -acf $"(pwd | path basename).zip" ...(git diff --name-only | lines)
alias zipstaged = tar -acf $"(pwd | path basename).zip" ...(git diff --name-only --staged | lines)
