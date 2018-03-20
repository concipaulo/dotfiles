# 
# Some aliases to bash 
alias c='clear'
alias lla='ll -a'
alias lal=lla
#alias cd..='cd ..'
alias ..='cd ..'
alias e='exit'
alias vim='vim --servername vim'
alias gt='vim ~/Articles/graduate_thesis/gradthesis.tex'

function apt-history(){
    case "$1" in
      install)
            cat /var/log/dpkg.log | grep 'install '
            ;;
      upgrade|remove)
            cat /var/log/dpkg.log | grep $1
            ;;
      rollback)
            cat /var/log/dpkg.log | grep upgrade | \
                grep "$2" -A10000000 | \
                grep "$3" -B10000000 | \
                awk '{print $4"="$5}'
            ;;
      *)
            cat /var/log/dpkg.log
            ;;
    esac
}
