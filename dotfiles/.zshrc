# ─── .zshrc ──────────────────────────────────────────────────────────────

# options
setopt AUTO_CD            # Naviguer sans 'cd'
setopt HIST_IGNORE_DUPS   # Ignore les doublons dans l'historique
setopt HIST_FIND_NO_DUPS  # Ignore les doublons lors de la recherche
setopt HIST_IGNORE_SPACE  # Ignore les commandes précédées d'un espace
setopt SHARE_HISTORY      # Partage l'historique entre les sessions

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.local/share/zsh/history"

# prompt
PROMPT='%B%(?.%F{cyan}.%F{red})❱ %F{blue}%~ $ %f%b'

# homebrew
if [[ -z $HOMEBREW_PREFIX ]] && [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
fi

if [[ -n $HOMEBREW_PREFIX ]]; then
  FPATH="$HOMEBREW_PREFIX/share/zsh-completions:$FPATH"

  # zsh-autosuggestions
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
fi

# completion
[[ -d "$HOME/.local/share/zsh" ]] || mkdir -p "$HOME/.local/share/zsh"
autoload -Uz compinit && compinit -d "$HOME/.local/share/zsh/zcompdump"
zstyle ':completion:*' cache-path "$HOME/.local/share/zsh/zcompcache"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# ls colors
export CLICOLOR=1
export LSCOLORS=ExfxbxdxCxegedabagacad

# completion colors
export LS_COLORS="di=1;38;2;137;180;250:ln=38;2;203;166;247:ex=1;38;2;166;227;161"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# keybindings
bindkey -e
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[3~" delete-char

# aliases
[[ -f ~/.zsh_aliases ]] && source "$HOME/.zsh_aliases"

# zsh-syntax-highlighting
if [[ -n $HOMEBREW_PREFIX ]] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null; then
  source "$HOME/.config/zsh/catppuccin.zsh"
  ZSH_HIGHLIGHT_STYLES[path]=none
  ZSH_HIGHLIGHT_STYLES[path_pathseparator]=none
  ZSH_HIGHLIGHT_STYLES[path_prefix]=none
  ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=none
  ZSH_HIGHLIGHT_STYLES[precommand]=none
fi
