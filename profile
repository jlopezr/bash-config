#Detect OS
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
    enable_gnu_ls="yes"
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='macosx'
    # Check if 'coreutils' package is installed 
    if [ -f "/opt/local/libexec/gnubin/dircolors" ]; then
	PATH=/opt/local/libexec/gnubin:$PATH
	enable_gnu_ls="yes"
    else
	enable_bsd_ls="yes"
    fi
fi

# MacPorts 
if [[ "$platform" == "macosx" ]]; then
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:$MANPATH
fi

# Enable color for BSD ls
if [[ "$enable_bsd_ls" == "yes" ]]; then
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
    export LS_OPTIONS='-G'
fi

# Enable color for GNU ls
if [[ "$enable_gnu_ls" == "yes" ]]; then
    if [ "$TERM" != "dumb" ]; then
        export LS_OPTIONS='--color=auto'
        eval `dircolors ~/.dir_colors`
    fi
fi

# Prompt
function prompt() {
   if [[ "$1" == "" ]]; then
	echo "Available prompts are:"
	dir $HOME/.bash-config/prompt
   else
        if [[ -f "$HOME/.bash-config/prompt/$1" ]]; then
	     source ~/.bash-config/prompt/$1
        else
             echo "prompt $1 not found."
        fi 
   fi
}
prompt classic

# Useful aliases
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lhF'
alias l='ls $LS_OPTIONS -lAhF'
alias cd..="cd .."
alias c="clear"
alias e="exit"
alias ssh="ssh -X"
alias ..="cd .."

# TERM
declare -x TERM=xterm-256color

# Local profile
if [[ -r ~/.profile_local ]]; then
    . ~/.profile_local
fi
