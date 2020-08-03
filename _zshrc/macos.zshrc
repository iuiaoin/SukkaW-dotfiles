# For Performance Debug purpose
# Use "zprof" to see the result
# zmodload zsh/zprof

# =================================================== #
#   _____       _    _            ______              #
#  / ____|     | |  | |          |  ____|             #
# | (___  _   _| | _| | ____ _   | |__   ______   __  #
#  \___ \| | | | |/ / |/ / _\`|  |  __| |  _ \ \ / /  #
#  ____) | |_| |   <|   < (_| |  | |____| | | \ V /   #
# |_____/ \__,_|_|\_\_|\_\__,_|  |______|_| |_|\_/    #
#                                                     #
# =================================================== #

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

#ZSH_THEME="sukka"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=12

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Enable insecure directories and files from custom plugins
ZSH_DISABLE_COMPFIX="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Cache Freq Use Variables
## Homebrew prefix
__SUKKA_HOMWBREW__PREFIX="/usr/local"
## Box Name used for my zsh-theme
__SUKKA_BOX_NAME=${HOST/.local/}
# Homebrew zsh completion path
__SUKKA_HOMEBREW_ZSH_COMPLETION="${__SUKKA_HOMWBREW__PREFIX}/share/zsh/site-functions"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
    # osx
    # openload
    zsh-autosuggestions
    # git
    # zsh-syntax-highlighting
    fast-syntax-highlighting
    zsh-gitcd
    zsh-completions
    zsh_reload
    zsh-z
)

# ZSH completions
# For homebrew, is must be added before oh-my-zsh is called.
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/github/README.md#homebrew-installation-note
# Add a check avoiding duplicated fpath
if (( ! $FPATH[(I)${__SUKKA_HOMEBREW_ZSH_COMPLETION}] && $+commands[brew] )) &>/dev/null; then
    FPATH=${__SUKKA_HOMWBREW__PREFIX}/share/zsh/site-functions:$FPATH
fi

# Requested by Homebrew & zsh-completions
autoload -Uz compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nano'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set tj/n Path
export N_PREFIX="$HOME/.n"
export N_PRESERVE_NPM=1

# Set NPM Global Path
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
# Create .npm-global folder if not exists
[[ ! -d "$HOME/.npm-global" ]] && mkdir -p $HOME/.npm-global

export PATH="/usr/local/opt/curl/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$N_PREFIX/bin:$HOME/.yarn/bin:$HOME/.npm-global/bin:$PATH:/usr/local/go/bin:$HOME/go/bin:$HOME/bin"

export GOPATH="$HOME/go"

export LDFLAGS="-L/usr/local/opt/curl/lib"
export CPPFLAGS="-I/usr/local/opt/curl/include"
export PKG_CONFIG_PATH="/usr/local/opt/curl/lib/pkgconfig"

# Lazyload Function

## Setup a mock function for lazyload
## Usage:
## 1. Define function "_sukka_lazyload_command_[command name]" that will init the command
## 2. sukka_lazyload_add_command [command name]
sukka_lazyload_add_command() {
    eval "$1() { \
        unfunction $1; \
        _sukka_lazyload_command_$1; \
        $1 \$@; \
    }"
}
## Setup autocompletion for lazyload
## Usage:
## 1. Define function "_sukka_lazyload_completion_[command name]" that will init the autocompletion
## 2. sukka_lazyload_add_comp [command name]
sukka_lazyload_add_completion() {
    local comp_name="_sukka_lazyload__compfunc_$1"
    eval "${comp_name}() { \
        compdef -d $1; \
        unfunction $1; \
        _sukka_lazyload_completion_$1; \
    }"
    compdef $comp_name $1
}

alias rezsh="src"

alias rmrf="rm -rf"
alias gitcm="git commit -m"
alias gitp="git push"
alias gita="git add -a"
alias gitall="git add ."
alias lg="lazygit"

alias ping="nali-ping"
alias dig="nali-dig"
alias traceroute="nali-traceroute"
alias tracepath="nali-tracepath"
alias nslookup="nali-nslookup"

hash -d desktop="$HOME/Desktop"
hash -d music="$HOME/Music"
hash -d pictures="$HOME/Pictures"
hash -d picture="$HOME/Pictures"
hash -d downloads="$HOME/Downloads"
hash -d download="$HOME/Downloads"
hash -d documents="$HOME/Documents"
hash -d document="$HOME/Documents"
hash -d dropbox="$HOME/Dropbox"
hash -d services="$HOME/Services"
hash -d projects="$HOME/Projects"
hash -d project="$HOME/Projects"
hash -d applications="/Applications"
hash -d application="/Applications"

alias finder_show="defaults write com.apple.finder AppleShowAllFiles YES"
alias finder_hide="defaults write com.apple.finder AppleShowAllFiles NO"

ci-edit-update() {
    (
        cd "$HOME/.ci_edit"
        git pull
    ) && sudo "$HOME/.ci_edit/install.sh"
}

git-config() {
    echo -n "
===================================
      * Git Configuration *
-----------------------------------
Please input Git Username: "

    read username

    echo -n "
-----------------------------------
Please input Git Email: "

    read email

    echo -n "
-----------------------------------
Done!
===================================
"

    git config --global user.name "${username}"
    git config --global user.email "${email}"
}

brew-fix() {
    sudo chown -R $(whoami) /usr/local/include /usr/local/lib /usr/local/lib/pkgconfig
    chmod u+w /usr/local/include /usr/local/lib /usr/local/lib/pkgconfig
}

brew-cask-upgrade() {
    red=$(tput setaf 1)
    # green=$(tput setaf 2)
    reset=$(tput sgr0)

    brew update

    for cask in $(brew cask outdated | awk '{print $1}'); do
        echo "${red}update ${cask} ...${reset}."

        brew cask install --force "$cask"
    done

    echo "* ${red}brew clean up ...${reset}"

    brew cleanup -s

    echo "* ${red}brew clean up done.${reset}"
}

extract() {
    if [[ -f $1 ]]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar e $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

gitpullall() {
    red=$(tput setaf 1)
    reset=$(tput sgr0)

    (
        cd $HOME/project
        find $(pwd) -type d -name ".git" | while read LINE; do
            echo "$red$LINE$reset"
            cd $(dirname $LINE)
            git pull
            git gc
        done
    ) && echo "${red}Done!${reset}"
}

upgrade_oh_my_zsh_custom_plugins() {
    red=$(tput setaf 1)
    blue=$(tput setaf 4)
    green=$(tput setaf 2)
    reset=$(tput sgr0)

    printf "${blue}%s${reset}\n" "Upgrading custom plugins"

    find "${ZSH_CUSTOM}" -type d -name ".git" | while read LINE; do
        p=$(dirname "$LINE")
        pushd -q "${p}"

        if git pull --rebase --stat origin master; then
            printf "${green}%s${reset}\n" "Hooray! $d has been updated and/or is at the current version."
        elif git pull --rebase --stat origin main; then
            printf "${green}%s${reset}\n" "Hooray! $d has been updated and/or is at the current version."
        else
            printf "${red}%s${reset}\n" 'There was an error updating. Try again later?'
        fi
        popd -q
    done
}

cfdns="@1.0.0.1 +tcp"

## Lazyload thefuck
if (( $+commands[thefuck] )) &>/dev/null; then
    _sukka_lazyload_command_fuck() {
        eval $(thefuck --alias)
    }

    sukka_lazyload_add_command fuck
fi

## Lazyload pyenv
export PYENV_ROOT="${PYENV_ROOT:=${HOME}/.pyenv}"

if (( $+commands[pyenv] )) &>/dev/null; then
    export PATH="${PYENV_ROOT}/shims:${PATH}"

    _sukka_lazyload_command_pyenv() {
        eval "$(command pyenv init -)"
        if [[ -n "${ZSH_PYENV_LAZY_VIRTUALENV}" ]]; then
            eval "$(command pyenv virtualenv-init -)"
        fi
    }

    _sukka_lazyload_completion_pyenv() {
        source "$(brew --prefix pyenv)/completions/pyenv.zsh"
    }

    sukka_lazyload_add_command pyenv
    sukka_lazyload_add_completion pyenv
fi

# Lazyload hexo completion
if (( $+commands[hexo] )) &>/dev/null; then
    _hexo_completion() {
        compls=$(hexo --console-list)
        completions=(${=compls})
        compadd -- $completions
    }

    _sukka_lazyload__compfunc_hexo() {
        unfunction _sukka_lazyload__compfunc_hexo
        compdef -d hexo
        compdef _hexo_completion hexo
    }

    compdef _sukka_lazyload__compfunc_hexo hexo
fi

# Lazyload pnpm completion
if (( $+commands[pnpm] )) &>/dev/null; then
  _pnpm_completion() {
    local reply
    local si=$IFS

    IFS=$'\n'
    reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" pnpm completion -- "${words[@]}"))
    IFS=$si

    _describe 'values' reply
  }

  _sukka_lazyload__compfunc_pnpm() {
    unfunction _sukka_lazyload__compfunc_pnpm
    compdef -d pnpm
    compdef _pnpm_completion pnpm
  }

  compdef _sukka_lazyload__compfunc_pnpm pnpm
fi

alias digshort="dig @1.0.0.1 +short "

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
