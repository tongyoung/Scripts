# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions
alias ppt="push_puppet_test"
alias gca="git commit --amend"
alias pg="pushgerrit-ops"

function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED="\[\033[0;31m\]"
PINK="\[\033[0;35m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOR="\[\033[0m\]"

export PS1="\$$GREEN\u@\h:$YELLOW\W =>$NO_COLOR "

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
if type __git_ps1 &>/dev/null ; then
   export PS1="\$$GREEN\u@\h:$YELLOW\W$RED"' $(__git_ps1 "(%s)") =>'"$NO_COLOR "
fi
# With git-1.8, the completion and prompt bits were split.  The allows lazy
# autoloading of the completion commands.  But it means we have to source a
# different file to get __git_ps1().
git_prompt=/usr/share/git-core/contrib/completion/git-prompt.sh
if ! type __git_ps1 &>/dev/null && [[ -f $git_prompt ]]; then
   source $git_prompt
   export PS1="\$$GREEN\u@\h:$YELLOW\W$RED"' $(__git_ps1 "(%s)") =>'"$NO_COLOR "
fi
unset git_prompt
if [ -f ~/.git-completion.bash ] ; then
   source ~/.git-completion.bash
