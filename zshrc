#!/bin/bash
# ^^^^^^^^^ fake shebang for editors

echo "Loading ~/.zshrc"
if [[ -z "$__ZPROFILE" ]]; then
  source "$HOME"/.zprofile
fi

export LANGUAGE=en_US.UTF-8

##############################
# history
##############################
HISTFILE_DIR="$HOME"/.cache/zsh
mkdir -p "$HISTFILE_DIR"
export HISTFILE="$HISTFILE_DIR"/zhistory
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY            # Don't execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing nonexistent history

ZSH_COMPLETIONS_DIR="$HOME"/.config/zsh-completions
 [[ ! -d $ZSH_COMPLETIONS_DIR ]] && mkdir -p $ZSH_COMPLETIONS_DIR
fpath+=$ZSH_COMPLETIONS_DIR

brew_completions="$(brew --prefix)/share/zsh/site-functions"
if [[ -d $brew_completions ]]; then
  fpath+=$brew_completions
fi

##############################
# antidote
##############################
ZDOTDIR="$HOME"/.config/antidote

if [[ ! -d "$ZDOTDIR" ]]; then
	git clone --depth=1 https://github.com/mattmc3/antidote.git "$ZDOTDIR"
fi


if [[ ! "$ZDOTDIR"/zsh_plugins.zsh -nt "$ZDOTDIR"/zsh_plugins.txt ]]; then
  (
    source "$ZDOTDIR"/antidote.zsh
    antidote bundle < "$ZDOTDIR"/zsh_plugins.txt > "$ZDOTDIR"/zsh_plugins.zsh
  )
fi
source "$ZDOTDIR"/zsh_plugins.zsh

plugins=(
	git
	docker
	docker-compose
	podman
)

# antigen bundles <<EOBUNDLES
    # Bundles from the default repo (robbyrussell's oh-my-zsh)
    # git

    # Syntax highlighting bundle.
    # zsh-users/zsh-syntax-highlighting

    # Fish-like auto suggestions
    # zsh-users/zsh-autosuggestions

    # Extra zsh completions

    # zsh-users/zsh-completions

	# docker
	# docker-compose
	# command-not-found
	# pip
	# thuandt/zsh-pipx
	# antigen bundle tmux
	# fd
	# fzf
	# ansible
	# kubernetes
	# kubectl
	# kubectl-autocomplete
	# macos
# EOBUNDLES


# settings for marlonrichert/zsh-autocomplete
# zstyle ':autocomplete:tab:*' insert-unambiguous no     # if `yes` make Tab first insert any common substring, before inserting full completion
# zstyle ':autocomplete:tab:*' widget-style menu-complete # circular Tab and Shift-Tab for completion
zstyle ':autocomplete:*' min-delay .3
# zstyle ':autocomplete:*' key-binding off

# Esc timeout for vi mode
export KEYTIMEOUT=1


##############################
# prompt
##############################
if [[ -x "$(which starship)" ]]; then
  eval "$(starship init zsh)"
fi
##############################
# Vim
##############################
alias vi=nvim
alias vim=nvim
export VISUAL=nvim
export EDITOR="$VISUAL"

##############################
# Pagers
##############################
# This affects every invocation of `less`.
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x#  tabs are # instead of 8
#   -j#  skip first # lines from the top of the screen then search
export LESS="-ij5RFXMx4 --mouse --wheel-lines=2"
# change hist file location
export LESSHISTFILE="$HOME"/.cache/lesshst
export PAGER='colorless'
export MANPAGER='colorless'
alias less='colorless'

##############################
# random settings
##############################
alias ':q'='exit'
# Turns on colors with default unix `ls` command:
export CLICOLOR=1

# ls colors could be generated here: https://geoff.greer.fm/lscolors/
# but seems like GNU dircolors with GNU ls is better
# setup LS_COLORS
eval "$(dircolors -b)"
export LSCOLORS="exfxcxdxBxegedabagacab"

export JQ_COLORS='0;31:0;39:0;39:0;39:0;32:1;39:1;39'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# TODO: refactor this
alias ls='ls --color=always -FCA'
export BAT_THEME=OneHalfDark
export ZSH_HIGHLIGHT_MAXLENGTH=200
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export ZSH_COMMAND_TIME_MIN_SECONDS=1

# time function format
# bash style time
export TIMEFMT=$'\n\nCPU\t%P\nuser\t%*U\nsys\t%*S\ntotal\t%*E'

# python
export IPYTHONDIR="$HOME"/.config/ipython
# python venv trick
venv () {
  local -a venv_cases
  venv_cases+=( ".venv/bin/activate" )
  venv_cases+=( "venv/bin/activate" )
  for v in $venv_cases; do
    if [[ -z "$VIRTUAL_ENV" ]] && [[ -f $v ]]; then
      . "$v"
      echo "activate $v"
    fi
  done
}

