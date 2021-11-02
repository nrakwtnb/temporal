# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#user def'
export TRUSH=/home/noriaki/Trush/
function rm () {
	mv $1 $TRUSH
}
alias mv="mv -i"
alias lsa="ls -alh"

### export

export LOCAL_SYSTEM_PATH=/home/noriaki/system
export LOCAL_PATH=/home/noriaki/.local

export PIPENV_ENV_PATH=/home/noriaki/system/pipfiles/

#export PATH=/usr/local/bin:$PATH
#export PATH=/usr/local/bin:/home/noriaki/system/anaconda3/bin:$PATH
export PATH=$LOCAL_SYSTEM_PATH/flutter/bin:$LOCAL_SYSTEM_PATH/anaconda3/bin:$PATH
#export PATH=$PATH:$LOCAL_PATH:$LOCAL_SYSTEM_PATH/terraform/
export PATH=$LOCAL_PATH/bin:$LOCAL_SYSTEM_PATH/terraform/:$PATH

export PATH=$HOME/.cargo/bin:$PATH

# direnv
eval "$(direnv hook bash)"
export EDITOR=vim


#npm set prefix $LOCAL_PATH
npm config set prefix $LOCAL_PATH

### alias

#alias python="/usr/bin/python3"
#alias python="/usr/local/bin/python3.6"
#alias pip="/usr/local/bin/pip3.6"
alias logstart='script -af ~/system/log/noriaki_$(date "+%Y%m%d").log'
#alias logstart="script -af ~/system/log/noriaki_$(date "+%Y%m%d").log"
alias pbcopy="xsel --clipboard --input"
function clipcopy (){
	cat $1 | pbcopy
}
#alias ptags="ctags -R -f tags"
#alias ptags="ctags -R `find -name \*.py`"
alias ptags='ctags -R $(find -name \*.py)'
#export LANG=C.UTF-8
#export LC_ALL=C.UTF-8
#export LESSCHARSET=utf-8

alias chrome="/opt/google/chrome/google-chrome"
alias cd_pipfile_dir='cd $(cat $(pipenv --venv)".projects")'
#alias cd_pipfile_dir="cd $(cat $(pipenv --venv)'.projects')" not work !
complete -C /home/noriaki/.local/share/virtualenvs/AWS-ztPj0u59/bin/aws_completer aws


alias pwd_copy='echo -n `pwd` | clipcopy'

alias du_top='du -m ./ -d 1'


alias open='xdg-open'

# gcp
alias gsutil_du_buckets='gsutil ls | xargs -I{} gsutil du -sh {}'

#set -o vi

#export GOPATH=/home/noriaki/PL/Go/packages
#export GOROOT=/usr/local/go
#export GOPATH=$GOROOT/packages
#export GOBIN=/home/noriaki/PL/Go/bin
#export GOBIN=$GOROOT/bin
#export PATH=$PATH:$GOBIN

function backup (){
    cp $1{,.bk}
}
function diff_backup (){
    diff $1{,.bk}
}
function resolve_pwd (){
    cd $(readlink -f `pwd`)
}

function delete_container (){
    docker stop $1 && docker rm $1
}

alias ls-min='ls -lgG --time-style=+""'



resolve_pwd () {
    cd $(readlink -f `pwd`)
}

gpu () {
    interval=${1:-1}
    watch -n ${interval} nvidia-smi
}



nbconvert_outputs () {
    jupyter nbconvert $1 --to html --no-input
}




s3sync () {
    REL_PATH=$PWD
    aws s3 sync . $2/$REL_PATH --no-follow-symlinks
}

s3sync_exact () {
    REL_PATH=$PWD
    aws s3 sync . $2/$REL_PATH --delete --exact-timestamps --no-follow-symlinks
}

generate_class_dependency_graph () {
    pyreverse -o png -my .
}

generate_class_dependency_graph_all () {
    pyreverse -o png -p ALL -my -f ALL .
}

print_python_module_list () {
    cat <(grep -rh ^import | sort) <(grep -rh ^from | sort) | sed -e s///g | uniq
}

ipython_install () {
    ipython kernel install --user --name=$1 --display-name=$2
}

#source <(npm completion bash)
#source <(kubectl completion bash)
#source <(minikube completion bash)
#
## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/noriaki/system/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/noriaki/system/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/noriaki/system/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/noriaki/system/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
## <<< conda initialize <<<



#if [ -d $HOME/.anyenv ]
if [ -e "$HOME/.anyenv" ]
then
    export ANYENV_ROOT="$HOME/.anyenv"
    export PATH="$ANYENV_ROOT/bin:$PATH"
    # anyenv未導入の環境でもエラーを出さないため
    if command -v anyenv 1>/dev/null 2>&1
    then
        eval "$(anyenv init -)"
    fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
