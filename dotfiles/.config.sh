#!/bin/bash
# Add branch specific configurations here

# Launch Windows chrome as browser
export BROWSER="chrome-wsl.sh"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
# Add bun to path
export PATH="$PATH:$HOME/.bun/bin"

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "$(fnm env)"
fi

. "/home/jackanderson/.deno/env"
