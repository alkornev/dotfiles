## vim:ft=bash:
__ZPROFILE=1


if [[ -d /opt/homebrew ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

if [[ -d /opt/homebrew ]]; then
  ## mac only
  # use GNU coreutils by their default names (e.g. dircolors)
  # break `ls` compatibility
  if [[ -d /opt/homebrew/opt/coreutils/libexec/gnubin ]]; then
    PATH=/opt/homebrew/opt/coreutils/libexec/gnubin:"$PATH"
  fi
fi


PATH=/usr/local/sbin:"$PATH"
PATH=/usr/local/bin:"$PATH"

PATH="$HOME"/miniconda/condabin:"$PATH"
PATH="$HOME"/.local/bin:"$PATH"
PATH="$HOME"/bin:"$PATH"

autoload -Uz compinit
compinit

export PATH
