# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

case "$(uname -s)" in
  Linux*)
    if grep -qi microsoft /proc/version 2>/dev/null; then
      OS="WSL"
      HOME_DIR="/mnt/c/Users/banseok"
      REPO_DIR="/mnt/d/Repos"
    else
      OS="Linux"
      HOME_DIR="/home/jakepark"
      REPO_DIR="/home/jakepark/Repos"
    fi
    ;;
  Darwin*)
    OS="macOS"
    HOME_DIR="/Users/jakepark"
    REPO_DIR="/Users/jakepark/Repos"
    ;;
  *)
    OS="Unknown"
    HOME_DIR="/home/jakepark"
    REPO_DIR="/home/jakepark/Repos"
    ;;
esac

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="ys"
# ZSH_THEME="headline"
# ZSH_THEME="random"
# ZSH_THEME="powerlevel10k/powerlevel10k"

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
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

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
plugins=(
  git
  zsh-syntax-highlighting
  fast-syntax-highlighting
  zsh-autosuggestions
  zsh-interactive-cd
  fzf-tab
  alias-tips
  colored-man-pages
  # starship
)

source $ZSH/oh-my-zsh.sh
set -o vi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# personal function
# docker compose up && logs -f [Service1 ...]
dcul() {
  if [ $# -eq 0 ]; then
    echo "🛠️ Usage: dcup Service1 [Service2 ...]"
    return 1
  fi

  docker compose up -d "$@" && docker compose logs -f "$@"
}

zrank() {
  zoxide query -l | grep "$(pwd)" | awk '{print $1}'
}

zjump() {
  local dir
  dir=$(zoxide query -l | fzf --tac) && cd "$dir"
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run $(alias).
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias c=clear
alias so=source
alias vz='vi ~/.zshrc'
alias sz='source ~/.zshrc'
alias vv='vi ~/.config/nvim/init.lua'
alias vt='vi ~/.tmux.conf'
alias ls='eza --icons --git'
alias sl=ls
alias ll='eza -lh --icons --git'
alias la='eza -a --icons --git'
alias lstr="eza -la --icons --git --sort=modified"
alias tree='ls --tree'
alias vi=nvim
alias view="nvim -R"
alias vim=nvim
alias dc=cd
alias zz='zjump'
alias fk="fuck"
alias y=yazi
alias dco="docker-compose"
alias k="kubectl"
alias mk="minikube"
alias va="vi $HOME_DIR/.config/alacritty/alacritty.toml"
alias vw="vi $HOME_DIR/.wezterm.lua"
alias vs="vi $HOME_DIR/.config/starship.toml"
alias cwrt="$REPO_DIR/ShellScripts/change_wezterm_random_theme.sh"
alias cwt="$REPO_DIR/ShellScripts/change_wezterm_theme.sh"
alias cwf="$REPO_DIR/ShellScripts/change_wezterm_font.sh"
alias cart="$REPO_DIR/ShellScripts/change_alacritty_random_theme.sh"
alias ct="$REPO_DIR/ShellScripts/change_alacritty_theme.sh"
alias ctrt="$REPO_DIR/ShellScripts/change_tmux_powerline_random_theme.sh"
alias cst="$REPO_DIR/ShellScripts/change_starship_theme.sh"
alias clrt="$REPO_DIR/ShellScripts/change_nvim_lualine_random_theme.sh"
alias clt="$REPO_DIR/ShellScripts/change_nvim_lualine_theme.sh"
alias ctt="$REPO_DIR/ShellScripts/change_tmux_powerline_theme.sh"
alias ctrt="$REPO_DIR/ShellScripts/change_tmux_powerline_random_theme.sh"
alias s="py $REPO_DIR/Utils/python/webSearch.py"
alias os="python3 $REPO_DIR/Utils/python/openSlackChannelDM.py"
alias py=python3

alias va="vi $HOME_DIR/.config/alacritty/alacritty.toml"
alias vs="vi $HOME_DIR/.config/starship.toml"
alias vw="vi $HOME_DIR/.wezterm.lua"
alias cwrt="$REPO_DIR/ShellScripts/change_wezterm_random_theme.sh"
alias cwt="$REPO_DIR/ShellScripts/change_wezterm_theme.sh"
alias cwrf="$REPO_DIR/ShellScripts/change_wezterm_random_font.sh"
alias cwf="$REPO_DIR/ShellScripts/change_wezterm_font.sh"
alias cart="$REPO_DIR/ShellScripts/change_alacritty_random_theme.sh"
alias ct="$REPO_DIR/ShellScripts/change_alacritty_theme.sh"
alias ctrt="$REPO_DIR/ShellScripts/change_tmux_powerline_random_theme.sh"
alias cst="$REPO_DIR/ShellScripts/change_starship_theme.sh"
alias clrt="$REPO_DIR/ShellScripts/change_nvim_lualine_random_theme.sh"
alias clt="$REPO_DIR/ShellScripts/change_nvim_lualine_theme.sh"
alias ctt="$REPO_DIR/ShellScripts/change_tmux_powerline_theme.sh"
alias ctrt="$REPO_DIR/ShellScripts/change_tmux_powerline_random_theme.sh"
alias s="py $REPO_DIR/Utils/python/webSearch.py"
alias os="py $REPO_DIR/Utils/python/openSlackChannelDM.py"
alias py=python3

case "$OS" in
  "Linux")
    alias py=python3
    ;;
  "macOS")
    alias s="$REPO_DIR/Utils/rust/web_search/target/release/web_search"
    # source ~/venv/bin/activate
    ;;
  "WSL")
    alias down="cd /mnt/d/WinDirs/Downloads"
    alias doc="cd /mnt/d/WinDirs/Documents"
    alias desk="cd /mnt/d/WinDirs/Desktop"
    alias c:="cd /mnt/c"
    alias d:="cd /mnt/d"
    alias work="cd /mnt/d/Works"
    alias site="cd /mnt/d/Works/Site"
    alias money="cd /mnt/d/Works/money"
    alias open="explorer.exe"
    alias cmd=cmd.exe
    alias pwsh="/mnt/c/Program\ Files/PowerShell/7/pwsh.exe"
    alias alacritty=alacritty.exe
    alias wezterm=wezterm.exe
    alias pandoc=pandoc.exe
    alias py=py.exe
    alias gitui=gitui.exe
    alias zed=zed.exe
    alias cat=bat
    alias duhs="du -hs * | sort -h"
    alias brew=scoop
    alias s="/mnt/d/Repos/Utils/exe/webSearch.exe"
    alias os="py.exe D:/Repos/Utils/python/openSlackChannelDM.py"
    ;;
esac

source <(kubectl completion zsh)

alias tmb='tmux new-session -d && tmux split-window -h && tmux split-window -v && tmux select-pane -L && tmux split-window -v && tmux select-pane -U && tmux attach-session -d'
alias tms='tmux new-session -d && tmux split-window -v && tmux split-window -v && tmux select-pane -U && tmux select-pane -U && tmux split-window -v && tmux select-pane -U && tmux attach-session -d'
alias tm='tmux new-session -d && tmux split-window -h && tmux select-pane -L && tmux attach-session -d'
alias tmh='tmux new-session -d && tmux split-window -v && tmux select-pane -U && tmux attach-session -d'

function btail {
  tail -f "$@" | bat --style=numbers --paging=never -l log
}
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
export LD_LIBRARY_PATH=$JAVA_HOME/lib/server:$LD_LIBRARY_PATH

 function docker_remote_tag() {
   curl -s -S "https://registry.hub.docker.com/v2/repositories/library/$@/tags/" | jq '."results"[]["name"]' | sort
 }

# zoxide init
eval "$(zoxide init zsh)"
# mcfly settings
export MCFLY_KEY_SCHEME=vim
export MCFLY_INTERFACE_VIEW=TOP   # TOP | BOTTOM
# export MCFLY_RESULTS=30
eval "$(mcfly init zsh)"
# fuck
eval "$(thefuck --alias)"

# starship init zsh
# export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"
zle -N zle-keymap-select starship_zle-keymap-select

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
