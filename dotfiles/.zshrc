
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# -------------------------
# Powerlevel10k
# -------------------------
#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Run Powerlevel10k config wizard on first launch
#[[ ! -f ~/.p10k.zsh ]] && p10k configure


source ~/.zsh/spaceship/spaceship.zsh
fpath=(~/.zsh/zsh-completions/src $fpath)
autoload -Uz compinit && compinit
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# -------------------------
# Basic Options
# -------------------------
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt PROMPT_SUBST
setopt AUTO_CD
setopt CORRECT


# History
HISTSIZE=1000
SAVEHIST=2000
HISTFILE=~/.zsh_history


# -------------------------
# Paths
# -------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/coursier/bin"

# -------------------------
# NVM
# -------------------------
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"




# -------------------------
# Yazi integration
# -------------------------
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# -------------------------
# Fuzzy cd
# -------------------------
function fcd() {
  local dir=$(find . -type d | fzf)
  [[ -n "$dir" ]] && cd "$dir"
}


# -------------------------
# SDKMAN
# -------------------------
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# -------------------------
# Aliases (converted)
# -------------------------

# GIT 
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gb='git branch'

# DOCKER
alias dcup='docker compose up -d'
alias dcdown='docker compose down'
alias dclogs='docker compose logs -f'
alias dps='docker ps'
alias ldc='lazydocker'

# CONFIGS
alias nv='nvim .'
alias nvimc='nvim ~/.config/nvim'
alias zshrc='nvim ~/.zshrc && source ~/.zshrc'

# MOTIONS
alias ..='cd ..'
alias ...='cd ../..'
alias home='cd ~'
alias proj='cd ~/projects'
alias sf='cd ~/projects/StockFlow'
alias hypr='nvim ~/.config/hypr/hyprland.conf'
alias hexit='hyprctl dispatch exit' 
alias waybarc='nvim ~/.config/waybar/config.jsonc'
alias atext='cd ~/Estudos/AcademicTexts'
alias ttt="Themer-TUI"
alias countlines= "xargs -I {} cat {} | wc -l"
#To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# VENV Python

alias vpip='~/.local/share/nvim/neovim-venv/bin/pip'

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Inicializa o Starship
#eval "$(starship init zsh)"
#

# -------------------------
# Pyenv
# -------------------------

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# -------------------------
# Ziglang
# -------------------------
export PATH="$HOME/.zig/zig-x86_64-linux-0.16.0-dev.2193+fc517bd01:$PATH"
#export PATH="$HOME/.zig/zig-x86_64-linux-0.15.2:$PATH"
#
#
# -------------------------
# Themer
# -------------------------
#
# Add to ~/.bashrc or ~/.zshrc
if [ -d "$HOME/projects/Themer/zig-out/bin" ]; then
    export PATH="$HOME/projects/Themer/zig-out/bin:$PATH"
fi

# -------------------------
# Golang
# -------------------------
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"

# bun completions
[ -s "/home/tori/.bun/_bun" ] && source "/home/tori/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
alias tmc='/home/tori/.local/bin/tmc'
export TMC_LANGS_CONFIG_DIR='/home/tori/tmc-config'
fpath=(/home/tori/.local/share/tmc-autocomplete/_tmc  $fpath)
compdef _tmc tmc

