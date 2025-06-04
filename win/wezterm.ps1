winget install wez.wezterm
Get-Content -Path ./.wezterm.lua | Set-Content -Path $env:HOMEPATH/.wezterm.lua
