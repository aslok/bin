# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac



# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [[ -f ~/.bash_functions ]]
then
    . ~/.bash_functions
fi


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

PROMPT_COMMAND='history -a'
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-256color) color_prompt=yes;;
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    set_prompt () {
        Last_Command=$? # Must come first!
        FancyX='\342\234\227'
        Checkmark='\342\234\223'

        # Add a bright white exit status for the last command
        PS1="\[$BWhite\]\$? "
        # If it was successful, print a green check mark. Otherwise, print
        # a red X.
        if [[ $Last_Command == 0 ]]; then
            PS1+="\[$BGreen\]$Checkmark "
        else
            PS1+="\[$BRed\]$FancyX "
        fi
        
    if [ "$USER" = root ]; then
        user_color=$IRed
        prompt_color=$BRed
    else
        user_color=$IGreen
        prompt_color=$BGreen
    fi
    PS1+="\n"
        PS1+=$(date "+\[$Cyan\]%a\[$IBlue\], \[$Purple\]%d %b\[$IBlue\], \[$IYellow\]%H\[$IBlue\]:\[$IYellow\]%M\[$IBlue\]:\[$Yellow\]%S")
    PS1+=" \[$user_color\]\u\[$IYellow\]@\[$IRed\]\h \[$ICyan\]\w \[$prompt_color\]\\$\[\e[m\]\[$Color_Off\] "
    unset user_color prompt_color
    }
    PROMPT_COMMAND='set_prompt'
else
    PS1='\[\e]0;\u@\h: \w\a\]\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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

# Colorize prompts
for i in {1..4}; do
    PSi="PS$i"
    export $PSi="\[\e[1;37m\]${!PSi}\[\e[0m\]"
done
unset PSi
unset i

source /usr/share/git/completion/git-prompt.sh

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

source /usr/share/doc/pkgfile/command-not-found.bash

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

shopt -s autocd
shopt -s cdspell
shopt -s cmdhist
shopt -s no_empty_cmd_completion
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
complete -cf sudo

export PATH="~/bin:$PATH"
export TERM=xterm-256color

export LANG=uk_UA.UTF-8
export EDITOR="/usr/bin/mcedit"
export VISUAL="/usr/bin/mcedit"
