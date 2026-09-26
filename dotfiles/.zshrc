# ─── .zshrc ──────────────────────────────────────────────────────────────

# shellcheck disable=all

# options
setopt AUTO_CD            # Navigate without 'cd'
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
if [[ -o interactive ]]; then
  bindkey -e
  bindkey "\e[H" beginning-of-line
  bindkey "\e[F" end-of-line
  bindkey "\e[3~" delete-char
fi

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
