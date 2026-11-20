# brew loading
eval "$(/opt/homebrew/bin/brew shellenv)"

# user binaries
typeset -U path
path=("$HOME/.local/bin" $path)
