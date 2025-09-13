if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

#-------------------OPTIONS-----------------------
# History size in memory and on disk
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# History options
setopt SHARE_HISTORY         # Share history between all sessions
setopt APPEND_HISTORY        # Append history instead of overwriting
setopt HIST_IGNORE_SPACE     # Ignore commands starting with space
setopt HIST_SAVE_NO_DUPS     # Don't save duplicates in history file
setopt HIST_IGNORE_ALL_DUPS  # Don't store a command if it's a duplicate of the previous one
setopt HIST_FIND_NO_DUPS     # Don't show duplicates during history search


# Make tab-completion case-insensitive (A = a, Z = z)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Make sure LS_COLORS is set
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Optional tweaks
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-flags --height=40% --layout=reverse --border
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' list-prompt '%S%p%s'
zstyle ':completion:*' menu yes select
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' group-colors $'\033[1;35m' $'\033[0;36m'

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

eval "$(fzf --zsh)"

#--------------------PLUGINS----------------------
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light Aloxaf/fzf-tab

# ----------------Aliases-------------------------

alias newenv='python3 -m venv .venv && source .venv/bin/activate'
alias t='tree'
alias vim='nvim'
alias nff='fastfetch'
alias htdocs='cd /opt/lampp/htdocs/'
alias lla='ls -la'
alias rezsh='source ~/.zshrc'
alias zshconfig='nvim ~/.zshrc'
alias xo='xdg-open'
alias clock='tty-clock -c -C 6'
alias logout="sudo systemctl restart sddm"
alias lock='hyprlock'
alias f="fzf"
alias pacman="sudo pacman"
alias oc="opencode"
alias c="clear"
alias cls='clear'
# Configure zoxide for direct navigation
eval "$(zoxide init zsh)"
alias j='z'
alias commit='goco'
alias pingg='ping google.com'
alias cat='bat'
# Replaced ls with eza
alias sl=ls
if command -v eza &>/dev/null; then
  alias l='ls -1'
  alias la='ls -a'
  alias lla='ll -a'
  alias ll='ls -l --git --git-repos --header'
  alias ls='eza --time-style=long-iso --icons --group-directories-first'

  alias ltree='eza --tree --level=2 --icons --group-directories-first'
  alias npm='pnpm'
  alias lg='lazygit'
fi

#-----------Env Variables ---------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"
PATH="/usr/sbin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
# opencode
export PATH=/home/onkar/.opencode/bin:$PATH
export PATH="$PATH:/usr/sbin"
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
#vim mode 
bindkey -v

# tmux-sessionizer keybinding (Ctrl+f)
bindkey -s ^f "tmux-sessionizer\n"

# Optional
# change cursor shape for visual feedback
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne "\e[1 q"  # block cursor
  else
    echo -ne "\e[5 q"  # beam cursor
  fi
}
zle -N zle-keymap-select

#load Zsh functions.
source ~/.zsh_functions

# pnpm
export PNPM_HOME="/home/onkar/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Disable Powerlevel10k configuration wizard
POWERLEVEL10K_DISABLE_CONFIGURATION_WIZARD=true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export GOCO_GEMINI_KEY="AIzaSyAClSROCCSNA0h7Bj4ZL7QQZdOOQuA7aqI"
