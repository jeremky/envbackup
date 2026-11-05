# ─── .zshrc ──────────────────────────────────────────────────────────────

# shellcheck disable=all

# non-interactive shells
[[ -o interactive ]] || return

# options
setopt HIST_IGNORE_DUPS   # ignore duplicates in history
setopt HIST_FIND_NO_DUPS  # ignore duplicates when searching
setopt HIST_IGNORE_SPACE  # ignore commands starting with a space
setopt HIST_REDUCE_BLANKS # remove parasite spaces
setopt SHARE_HISTORY      # share history between sessions
setopt EXTENDED_HISTORY   # save each command date

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.local/share/zsh/history"

# zsh folder
[[ -d ${HISTFILE:h} ]] || mkdir -p "${HISTFILE:h}"

# prompt
if [[ "$OSTYPE" == darwin* ]]; then
  PROMPT='%B%(?.%F{#89dceb}.%F{#f38ba8})❱ %F{#89b4fa}%~ $ %f%b'
else
  PROMPT='%F{#74c7ec}%n%F{#7f849c}@%F{#cba6f7}%m %F{#7f849c}%~ %F{#74c7ec}%(!.#.$) %f'
fi

# autosuggestions
if [[ -d "$HOMEBREW_PREFIX" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [[ -f "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# completion
autoload -Uz compinit && compinit -d "$HOME/.local/share/zsh/zcompdump"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.local/share/zsh/zcompcache"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# ls colors
export CLICOLOR=1
export LSCOLORS=ExfxbxdxCxegedabagacad
unset LS_COLORS
command -v dircolors &>/dev/null && eval "$(dircolors -b)"

# completion colors
export LS_COLORS="${LS_COLORS:+$LS_COLORS:}di=1;38;2;137;180;250:ln=38;2;203;166;247:ex=1;38;2;166;227;161"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# envman
[[ -s "$HOME/.config/envman/load.sh" ]] && source "$HOME/.config/envman/load.sh"

# aliases
[[ -f $HOME/.zsh_aliases ]] && source "$HOME/.zsh_aliases"

# ─── keybinding ──────────────────────────────────────────────────────────

if [[ -o interactive ]]; then
  bindkey -e
  bindkey "\e[H" beginning-of-line
  bindkey "\e[F" end-of-line
  bindkey "\e[3~" delete-char
  bindkey '^[[1;5C' forward-word
  bindkey '^[[1;5D' backward-word
  bindkey "\e[5~" history-beginning-search-backward
  bindkey "\e[6~" history-beginning-search-forward
fi
