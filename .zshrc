# Important things
source $HOME/.oh-my-zsh/oh-my-zsh.sh
export ZSH="$HOME/.oh-my-zsh"
CASE_SENSITIVE="false"
plugins=(
    git
    colored-man-pages
)

autoload -U colors && colors
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ps1_user="%{$fg[green]%}%n"
ps1_host="%{$fg[blue]%}%m"
ps1_path="%{$fg[cyan]%}[%~]"
ps1_git='$(git_prompt_info)'
ps1_suffix="%(?.%{$fg[green]%}.%{$fg[red]%})$%{$reset_color%}"
PROMPT="%B${ps1_user} ${ps1_host} ${ps1_path}%b ${ps1_git}${ps1_suffix} "

#Aliases
alias v="nvim"
#alias vim="nvim"
alias lg="lazygit"
alias python="python3"
alias py="python3"
alias ex="exit"
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'
alias lal='ls -al'
alias lt='ls -lt'
alias ltr='ls -ltr'
alias lltr='l -ltr'
alias bat='batcat'
alias ff='fastfetch'
alias cljrepl="clj -Sdeps '{:deps {nrepl/nrepl {:mvn/version \"1.0.0\"} cider/cider-nrepl {:mvn/version \"0.42.1\"}}}' -M -m nrepl.cmdline --middleware '[\"cider.nrepl/cider-middleware\"]' --interactive";

# Binds
bindkey "^H"      backward-kill-word  # Ctrl + <backspace>
bindkey "^[^?"    backward-kill-word  # Alt + <backspace>
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line

# Exports
export TERM="xterm-256color"
export PATH="/usr/local/bin:$PATH"
export EDITOR=/usr/bin/nvim
export BROWSER=firefox
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$HOME/.local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
#

export PATH=$PATH:/home/ryurt/.spicetify
