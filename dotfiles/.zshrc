# Load custom colors
eval "$(dircolors -b ~/.dircolors)" 

export VISUAL=vim
export EDITOR="$VISUAL"

# Aliases
# dd is the directory for dev_setup stuff
alias dd="cd ~/dev_setup"
# alias sdd='sed -i -E "s|(dd=\"cd )[^\"]*(\")|\1$(pwd)\2|" ~/.zshrc; source ~/.zshrc'

# pd = project directory
# spd is then a simple way to bookmark the curent project directory; pd then changes to that directory
# alias pd="cd /home/jackanderson/projects/CVS"
# alias spd='sed -i -E "s|(pd=\"cd )[^\"]*(\")|\1$(pwd)\2|" ~/.zshrc; source ~/.zshrc'

# wd = working directorty
# alias wd="cd /home/jackanderson/projects/CVS/cvs-nop"
# alias swd='sed -i -E "s|(wd=\"cd )[^\"]*(\")|\1$(pwd)\2|" ~/.zshrc; source ~/.zshrc'

# Add new project to tmux sesionizer path
alias pad='sed -i -E "s|paths=\((.*)\)|paths=(\1 $(pwd))|" ~/.local/bin/scripts/tmux-sessionizer.sh'

# Dot file sync
alias dfu='
# ls -ARp ~/dev_setup/dotfiles/ | grep -v / | sed -r "/^[\s,\.:]*$/d" | while IFS= read -r df; do
find ~/dev_setup/dotfiles/.* -type f | while IFS= read -r df; do
  # Copy all dotfiles from system root directory to here
  # We only want to copy  files that are actually in our dotfiles
  # basename is not sufficient because we want to preserve the file dir structure
  # within the dotfiles
  rootdf=$(echo "$df" | sed -e "s|$HOME/dev_setup/dotfiles/||")
  cp ~/$rootdf $df
done
cd ~/dev_setup/dotfiles/
git commit -am "dotfile sync $(date)"
git push
cd -

'
alias dfd='
cp -r ~/dev_setup/dotfiles/. ~
# Additionally source .zshrc here as well 
source ~/.zshrc
'

alias nv='nvim'
alias vi='nvim'

# VimBeGood
alias vbg="docker run -it --rm brandoncc/vim-be-good:stable"

set_fzf_defaults() {
  # fzf default options, opens vs code if a file is picked and the command is not aborted
  # export FZF_DEFAULT_OPTS="--bind='enter:(nvim {})' --preview 'batcat -n --color=always {}'"
  export FZF_DEFAULT_OPTS="--preview 'batcat -n --color=always {}'"
}
set_fzf_defaults

unset_fzf_defaults(){
  unset FZF_DEFAULT_OPTS
}

alias cht="unset_fzf_defaults; ~/.local/bin/scripts/chtfzf.sh; set_fzf_defaults"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# GOPATH and binaries
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH:$GOPATH/bin"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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


# Non blinking terminal cursor
echo -e "\e[?12l"

# Bind ctrl backspace to delete a word
bindkey '^H' backward-kill-word


export PATH="$PATH:$HOME/.local/bin/scripts/"
# Add C-F outside of tmux to go into tmux sessionizer
bindkey -s ^f "tmux-sessionizer.sh\n;"

. "/home/jackanderson/.deno/env"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"


# Launch Windows chrome as browser
export BROWSER="chrome-wsl.sh"

# bun completions
[ -s "/home/jackanderson/.bun/_bun" ] && source "/home/jackanderson/.bun/_bun"
# Add bun to path
export PATH="$PATH:~/.bun/bin/bun"
