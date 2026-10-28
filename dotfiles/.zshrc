# ─── .zshrc ──────────────────────────────────────────────────────────────

# shellcheck disable=all

# options
setopt HIST_IGNORE_DUPS   # Ignore duplicates in history
setopt HIST_FIND_NO_DUPS  # Ignore duplicates when searching
setopt HIST_IGNORE_SPACE  # Ignore commands starting with a space
setopt SHARE_HISTORY      # Share history between sessions

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.local/share/zsh/history"

# prompt
PROMPT='%B%(?.%F{cyan}.%F{red})❱ %F{blue}%~ $ %f%b'

# homebrew
if [[ -n $HOMEBREW_PREFIX ]]; then
  FPATH="$HOMEBREW_PREFIX/share/zsh-completions:$FPATH"
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
fi

# completion
mkdir -p "$HOME/.local/share/zsh"
autoload -Uz compinit && compinit -d "$HOME/.local/share/zsh/zcompdump"
zstyle ':completion:*' use-cache on
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
if [[ -o interactive ]]; then
  bindkey -e
  bindkey "\e[H" beginning-of-line
  bindkey "\e[F" end-of-line
  bindkey "\e[3~" delete-char
fi

# aliases
[[ -f ~/.zsh_aliases ]] && source "$HOME/.zsh_aliases"

