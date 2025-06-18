# Important things
source $HOME/.oh-my-zsh/oh-my-zsh.sh
ZSH_THEME="robbyrussell"
#setopt PROMPT_SUBST
plugins=(git)

# Git prompt
parse_git_branch() {
    # Check if the directory is inside a git repository
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        # Get the current branch name
        branch=$(git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/\1/p')

        # Check for uncommitted changes
        if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
            echo "── %F{130}‹${branch}*›%f "  # Orange color for branch with uncommitted changes
        else
            echo "── %F{130}‹${branch}›%f "  # Orange color for branch without uncommitted changes
        fi
    fi
}

NEWLINE=$'\n'
# Left Prompt 

#PROMPT='%B%F{255}┌ %F{2}%B%n@%m%f%b %F{255}── %F{25}%B%~%f%b $(parse_git_branch)%f ${NEWLINE}%F{255}└──╼%f%b '
#PROMPT='%B%F{255}%F{2}%B%n@%m%f%b %F{255}── %F{25}%B%~%f%b $(parse_git_branch)%f%f%b'

# Path uses the system color of blue
#PROMPT='%B%F{green}%F{green}%B%n@%m%f%b %F{255}── %F{blue}%B%~%f%b $(parse_git_branch)%f%f%b'

#PROMPT='${debian_chroot:+($debian_chroot)}%B%F{green}%n@%m%f:%F{blue}%~%f\$%b '

# Right Prompt 
# Time and date
#RPROMPT="%F{241}%B%D{%A %d %b %H:%M}%f%b"

# Right Prompt - Empty
#RPROMPT=""

#Aliases
alias emacs="emacs -nw"
alias v="nvim"
alias python="python3"
alias py="python3"
alias ex="exit"
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'
alias lal='ls -al'
alias lt='ls -lt'
alias ltr='ls -ltr'
alias bat='batcat'

# Binds
bindkey "^H"      backward-kill-word  # Ctrl + <backspace>
bindkey "^[^?"    backward-kill-word  # Alt + <backspace>

# Exports
export TERM="xterm-256color"
export PATH="/usr/local/bin:$PATH"
export EDITOR=/usr/bin/nvim
#export BROWSER=firefox
export GOPATH=/usr/local/gopath
export PATH=$GOPATH/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"


