# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export PS1='\[\e[1;35m\]\u@\h \W$\[\e[m\]'

# User specific aliases and functions
alias tmux='tmux -2'
alias peco='~/peco_linux_amd64/peco'

function pcd {
  local dir="$( find . -type d -name .\[0-9a-zA-Z\]* -prune -or -type d -name venv -prune -or -type d -name RPC_CPP -prune -or -type d -name Desktop -prune -or -type d -name mnt -prune -or -not -name .\* -or -type d | sed -e 's;\./;;' | peco )"
  if [ ! -z "$dir" ] ; then
    echo "cd: $dir"
    cd "$dir"
  fi
}

function pvim {
  local file="$( find . -type d -name .\[0-9a-zA-Z\]* -prune -or -type d -name venv -prune -or -type d -name RPC_CPP -prune -or -type d -name Desktop -prune -or -type d -name mnt -prune -or -not -name .\* | sed -e 's;\./;;' | peco )"
  if [ ! -z "$file" ] ; then
    echo "vim: $file"
    vim "$file"
  fi
}

function agvim() {
  local file=$( ag $* | peco | awk -F: '{printf  $1 " +" $2}' | sed -e 's/\+$//' )
  if [ -n "$file" ] ; then
    echo "vim: $file"
    vim $file
  fi
}
