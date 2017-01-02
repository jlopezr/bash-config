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
    # bash-completion
    if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
            . /opt/local/etc/profile.d/bash_completion.sh
    fi
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:$MANPATH
fi

# Add user scripts
PATH=$PATH:$HOME/.bash-config/bin

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
#alias ssh="ssh -X"
alias ..="cd .."
alias php-cgi="php -r '"'parse_str(implode("&", array_slice($argv, 2)), $_GET); include($argv[1]);'"' --"

# TERM
declare -x TERM=xterm-256color

# Git visual log displays commit tree view with who did what when and in which branch
git config --global alias.vlog 'log --graph --date-order --date=relative --pretty=format:"%C(cyan)%h: %Cblue - %an - %Cgreen %C(cyan)%ar:%Creset%n%s%n" --color'

# Local profile
if [[ -r ~/.profile_local ]]; then
    . ~/.profile_local
fi
