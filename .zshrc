# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export LC_ALL="en_US.UTF-8"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-prompt)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
parse_git_branch() {
    # Check if the directory is inside a git repository
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        # Get the current branch name
        branch=$(git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/\1/p')

        # Check for uncommitted changes
        if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
            echo "── %F{130}‹${branch}*›%f"  # Orange color for branch with uncommitted changes
        else
            echo "── %F{130}‹${branch}›%f"  # Orange color for branch without uncommitted changes
        fi
    fi
}
setopt PROMPT_SUBST
# I used to have %F{31} for $PATH
# This prompt is designed by Benoit Baudry.
#PROMPT="%F{255}┌ %F{2}%B%n@%m%f%b %F{255}── %F{25}%B%~%f%b$(git_prompt_info)${NEWLINE}%F{255}└──╼%f "
#PROMPT='%F{255}┌ %F{2}%B%n@%m%f%b %F{255}── %F{25}%B%~%f%b $(parse_git_branch)%f ${NEWLINE}%F{255}└──╼%f '

NEWLINE=$'\n'
#Left Prompt
PROMPT='%B%F{255}┌ %F{2}%B%n@%m%f%b %F{255}── %F{25}%B%~%f%b $(parse_git_branch)%f ${NEWLINE}%F{255}└──╼%f%b '
#PROMPT='%B%F{255}%F{2}%B%n@%m%f%b %F{255}── %F{25}%B%~%f%b $(parse_git_branch)%f%f%b'

#Right Prompt
#RPROMPT="%F{241}%B%D{%A %d %b %H:%M}%f%b"
RPROMPT=""

#Aliases
alias emacs="emacs -nw"
alias v="nvim"
alias python="python3"
alias py="python3"
alias ex="exit"
alias cl="clear"
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -A'

# Binds
bindkey "^H" backward-kill-word

export TERM="xterm-256color"

export PATH=$PATH:/usr/local/nusmv/bin
export PATH="/usr/local/bin:$PATH"
