# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------------
# Powerlevel10k
# -------------------------
source ~/.powerlevel10k/powerlevel10k.zsh-theme

# Run Powerlevel10k config wizard on first launch
[[ ! -f ~/.p10k.zsh ]] && p10k configure


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
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/coursier/bin"


# -------------------------
# Pyenv
# -------------------------
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


# -------------------------
# NVM
# -------------------------
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"


# -------------------------
# FZF
# -------------------------
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
fi
if [[ -f /usr/share/doc/fzf/examples/completion.zsh ]]; then
    source /usr/share/doc/fzf/examples/completion.zsh
fi

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always {} | head -500'"


# -------------------------
# Yazi integration
# -------------------------
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [[ -n "$cwd" ]] && [[ "$cwd" != "$PWD" ]] && cd "$cwd"
  rm -f "$tmp"
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
alias weztermc='nvim /mnt/c/Users/crist/.wezterm.lua'

# MOTIONS
alias ..='cd ..'
alias ...='cd ../..'
alias home='cd ~'
alias proj='cd ~/projects'
alias sf='cd ~/projects/StockFlow'
alias vbap='cd /mnt/c/Users/crist/OneDrive/Documentos/Gian/Estudos/VBA'
alias atext='nvim /mnt/c/Users/crist/OneDrive/Documentos/Gian/Estudos/AcademicTexts'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
