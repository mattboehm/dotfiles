alias ll='ls -alF'

alias tn='tmux -2 new -s '
alias ta='tmux -2 attach -t '
alias tl='tmux ls'

export PS1="}}}\n\t \w [\j] {{{\n"

#source the local bashrc file if it exists
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
