## vim:ft=bash:
__ZPROFILE=1

# linux
if [[ -d /home/linuxbrew/.linuxbrew ]]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# intel mac
if [[ -d /usr/local/Homebrew/ ]]; then
  eval $(/usr/local/Homebrew/bin/brew shellenv)
fi

if [[ -d /usr/local/Homebrew/ ]]; then
  ## mac only
  # use GNU coreutils by their default names (e.g. dircolors)
  # break `ls` compatibility
  if [[ -d /usr/local/opt/coreutils/libexec/gnubin ]]; then
    PATH=/usr/local/opt/coreutils/libexec/gnubin:"$PATH"
  fi
fi

# apple silicon mac
if [[ -d /opt/homebrew/ ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

if [[ -d /opt/homebrew/ ]]; then
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


export PATH
