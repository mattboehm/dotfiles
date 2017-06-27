alias ll='ls -alF'

alias tn='tmux -2 new -s '
alias ta='tmux -2 attach -t '
alias tl='tmux ls'

export PS1="}}}\n\t \w [\j] {{{"
export EDITOR="vim"
export WORKON_HOME=~/envs

function tabcol {
    case $1 in
    red)
    echo -en "\033]6;1;bg;red;brightness;209\a"
    echo -en "\033]6;1;bg;green;brightness;17\a"
    echo -en "\033]6;1;bg;blue;brightness;65\a"
    ;;
    orange)
    echo -en "\033]6;1;bg;red;brightness;243\a"
    echo -en "\033]6;1;bg;green;brightness;119\a"
    echo -en "\033]6;1;bg;blue;brightness;53\a"
    ;;
    yellow)
    echo -en "\033]6;1;bg;red;brightness;255\a"
    echo -en "\033]6;1;bg;green;brightness;196\a"
    echo -en "\033]6;1;bg;blue;brightness;37\a"
    ;;
    green)
    echo -en "\033]6;1;bg;red;brightness;0\a"
    echo -en "\033]6;1;bg;green;brightness;177\a"
    echo -en "\033]6;1;bg;blue;brightness;89\a"
    ;;
    teal)
    echo -en "\033]6;1;bg;red;brightness;0\a"
    echo -en "\033]6;1;bg;green;brightness;171\a"
    echo -en "\033]6;1;bg;blue;brightness;169\a"
    ;;
    blue)
    echo -en "\033]6;1;bg;red;brightness;0\a"
    echo -en "\033]6;1;bg;green;brightness;174\a"
    echo -en "\033]6;1;bg;blue;brightness;219\a"
    ;;
    purple)
    echo -en "\033]6;1;bg;red;brightness;162\a"
    echo -en "\033]6;1;bg;green;brightness;0\a"
    echo -en "\033]6;1;bg;blue;brightness;255\a"
    ;;
    esac
 }
#source the local bashrc file if it exists
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
