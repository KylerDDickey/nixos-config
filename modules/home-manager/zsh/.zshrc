### --- PROMPT

# Start shell prompt. This is technically an integration, but in order for the
# prompt to render correctly, this needs to be as close to the top as possible.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
eval "$(oh-my-posh init zsh --config ~/theme.omp.json)"

### --- ZINIT (PLUGINS)

# Define the home directory for zinit and clone the source from git been cloned
# to the aforementioned home directory. Then load zinit.
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting # Self-explanitory
zinit light zsh-users/zsh-completions # Auto-completes commands
zinit light zsh-users/zsh-autosuggestions # History-based completions
zinit light Aloxaf/fzf-tab

### --- KEYBINDINGS

bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

### --- HISTORY

HISTSIZE=2500
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

### --- COMPLETIONS

autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

### --- ALIASES

alias c='clear'
alias ls='ls --color'

### --- INTEGRATIONS

eval "$(direnv hook zsh)"
eval "$(fzf --zsh)"
