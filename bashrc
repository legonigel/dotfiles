## This file is sourced by all *interactive* bash shells on startup.  This
## file *should generate no output* or it will break the scp and rcp commands.
############################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ -e /etc/bashrc ] ; then
  . /etc/bashrc
fi

############################################################
## PATH
############################################################

function conditionally_prefix_path {
  local dir=$1
  if [ -d $dir ]; then
    case ":$PATH:" in
      *":$dir:"*) :;;
      *) PATH="$dir:$PATH";;
    esac
  fi
}

conditionally_prefix_path $HOME/android/platform-tools
conditionally_prefix_path /usr/lib/ccache
conditionally_prefix_path /opt/gcc-arm-none-eabi-4_9-2015q3/bin

conditionally_prefix_path $HOME/anaconda2/bin

conditionally_prefix_path $HOME/go/bin
conditionally_prefix_path $HOME/.cargo/bin


PATH=.:./bin:${PATH}

############################################################
## MANPATH
############################################################

function conditionally_prefix_manpath {
  local dir=$1
  if [ -d $dir ]; then
    MANPATH="$dir:${MANPATH}"
  fi
}

conditionally_prefix_manpath /usr/local/man
conditionally_prefix_manpath ~/man

############################################################
## Other paths
############################################################

function conditionally_prefix_cdpath {
  local dir=$1
  if [ -d $dir ]; then
    CDPATH="$dir:${CDPATH}"
  fi
}

conditionally_prefix_cdpath ~/work
conditionally_prefix_cdpath ~/work/oss

CDPATH=.:${CDPATH}

# Set INFOPATH so it includes users' private info if it exists
# if [ -d ~/info ]; then
#   INFOPATH="~/info:${INFOPATH}"
# fi

############################################################
## General development configurations
###########################################################

if [ `which rbenv 2> /dev/null` ]; then
  eval "$(rbenv init -)"
fi

if [ -f ~/.nvm/nvm.sh ]; then
  . ~/.nvm/nvm.sh
fi

export RBXOPT=-X19

############################################################
## Terminal behavior
############################################################

# Change the window title of X terminals
case $TERM in
  xterm*|rxvt|Eterm|eterm)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    ;;
esac

# Show the git branch and dirty state in the prompt.
# Borrowed from: http://henrik.nyh.se/2008/12/git-dirty-prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

if [ `which git 2> /dev/null` ]; then
  function git_prompt {
    parse_git_branch
  }
else
  function git_prompt {
    echo ""
  }
fi

if [ `which rbenv 2> /dev/null` ]; then
  function ruby_prompt {
    echo $(rbenv version-name)
  }
elif [ `which ruby 2> /dev/null` ]; then
  function ruby_prompt {
    echo $(ruby --version | cut -d' ' -f2)
  }
else
  function ruby_prompt {
    echo ""
  }
fi

if [ `which rbenv-gemset 2> /dev/null` ]; then
  function gemset_prompt {
    local gemset=$(rbenv gemset active 2> /dev/null)
    if [ $gemset ]; then
      echo " ${gemset}"
    fi
  }
else
  function gemset_prompt {
    echo ""
  }
fi

normal_color=$'\033[00m'
red_color=$'\033[41m'
exit_color=$normal_color

exit_color() {
    exit_code=$?
    if [ "$exit_code" != 0 ]; then
        echo "$red_color"
    else
        echo "$normal_color"
    fi
    return "$exit_code"
}

if [ -n "$BASH" ]; then
  export PS1='\[$normal_color\]\n\[$(exit_color)\][$?]\[$normal_color\]\[\033[32m\][\s: \w] $(git_prompt)\n\[\033[31m\][\u@\h]\$ \[\033[00m\]'
fi

# Fuzzy completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

############################################################
## Optional shell behavior
############################################################

shopt -s cdspell
shopt -s extglob
shopt -s checkwinsize

export PAGER="less"
export EDITOR="emacsclient -t"

############################################################
## History
############################################################

# When you exit a shell, the history from that session is appended to
# ~/.bash_history.  Without this, you might very well lose the history of entire
# sessions (weird that this is not enabled by default).
shopt -s histappend

export HISTIGNORE="&:pwd:ls:ll:lal:[bf]g:exit:rm*:sudo rm*"
# don't remove duplicates from the history (when a new item is added)
export HISTCONTROL=
# increase the default size from only 1,000 items
export HISTSIZE=-1
export HISTFILESIZE=-1

############################################################
## Aliases
############################################################

if [ -e ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

############################################################
## Bash Completion, if available
############################################################

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
elif  [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif  [ -f /etc/profile.d/bash_completion ]; then
  . /etc/profile.d/bash_completion
elif [ -e ~/.bash_completion ]; then
  # Fallback. This should be sourced by the above scripts.
  . ~/.bash_completion
fi

complete -C /home/nigelarmstrong/bin/vault vault

############################################################
## Other
############################################################

if [[ "$USER" == '' ]]; then
  # mainly for cygwin terminals. set USER env var if not already set
  USER=$USERNAME
fi

############################################################
## Ruby Performance Boost (see https://gist.github.com/1688857)
############################################################

export RUBY_GC_MALLOC_LIMIT=60000000
# export RUBY_FREE_MIN=200000 # Ruby <= 2.0
export RUBY_GC_HEAP_FREE_SLOTS=200000 # Ruby >= 2.1

############################################################
## Django bash completions
############################################################

source $HOME/.django_bash_completion

############################################################
## Java and Android
############################################################

export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre/"
export ANDROID_HOME="$HOME/Android/Sdk"
