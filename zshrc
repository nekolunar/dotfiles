# lang
export LANG=en_US.UTF-8

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# enable color
autoload -Uz colors; colors

# prompt
PROMPT="%{${fg[red]}%}[%n@%m]%{${reset_color}%} %~
%# "

# word-delimiter
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# completion
autoload -U compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"

# path
typeset -U path cdpath fpath manpath
export GOPATH=$HOME/.go
export GOROOT=$(go env GOROOT)
export XDG_CONFIG_HOME=$HOME/.config

path=(
    $HOME(N-/)
    $GOPATH/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $path
)

# aliases
alias la='ls -a'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"
alias tree='tree -NC'
alias vim='nvim'

# keybinds
bindkey -e
function cdup() {
    echo
    cd ..
    zle reset-prompt
}
zle -N cdup
bindkey '^K' cdup
bindkey "^R" history-incremental-search-backward
function chpwd() { ls -1 }

# options
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt magic_equal_subst
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt auto_menu
setopt extended_glob
setopt correct
setopt prompt_subst
setopt ignoreeof
setopt no_tify

# OS compat
if which pbcopy >/dev/null 2>&1 ; then
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    alias -g C='| putclip'
fi

case ${OSTYPE} in
    darwin*)
        export CLICOLOR=1
        export LSCOLORS=GxFxCxDxBxegedabagaced
        alias ls='ls -G -F'
        ;;
    linux*)
        ;;
esac

# The next line updates PATH for the Google Cloud SDK.
if [ -e ~/google-cloud-sdk ]; then
    source ~/google-cloud-sdk/path.zsh.inc
    source ~/google-cloud-sdk/completion.zsh.inc
fi
