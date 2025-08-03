#!/bin/bash

# Add branch specific configurations here

# Ensure Docker is running on WSL 2. This expects you've installed Docker and
# Docker Compose directly within your WSL distro instead of Docker Desktop, such as:
#   - https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
#   - https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user
#   - https://docs.docker.com/compose/install/linux/
if grep -q "microsoft" /proc/version > /dev/null 2>&1; then
    if service docker status 2>&1 | grep -q "is not running"; then
        wsl.exe --distribution "${WSL_DISTRO_NAME}" --user root \
            --exec /usr/sbin/service docker start > /dev/null 2>&1
    fi
fi


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
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

. "/home/jackanderson/.deno/env"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/bin/scripts"
export PATH="$PATH:$HOME/.local/bin/scripts/sh_tools/"


# Aliases
# dd is the directory for dev_setup stuff
alias dd="cd ~/dev_setup"
# alias sdd='sed -i -E "s|(dd=\"cd )[^\"]*(\")|\1$(pwd)\2|" ~/.zshrc; source ~/.zshrc'

# pd = project directory
# spd is then a simple way to bookmark the curent project directory; pd then changes to that directory
# alias pd="cd $HOME/projects/CVS"
# alias spd='sed -i -E "s|(pd=\"cd )[^\"]*(\")|\1$(pwd)\2|" ~/.zshrc; source ~/.zshrc'

# wd = working directorty
# alias wd="cd $HOME/projects/CVS/cvs-nop"
# alias swd='sed -i -E "s|(wd=\"cd )[^\"]*(\")|\1$(pwd)\2|" ~/.zshrc; source ~/.zshrc'

# Add new project to tmux sesionizer path
alias pad='sed -i -E "s|paths=\((.*)\)|paths=(\1 $(pwd))|" ~/.local/bin/scripts/tmux-sessionizer.sh'

# Handy script aliases
alias dfu='zsh $HOME/.local/bin/scripts/dfu.sh'
alias dfd='zsh $HOME/.local/bin/scripts/dfd.sh'

