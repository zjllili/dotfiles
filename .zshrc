# zshrc
# @author nate zhou
# @since 2025

autoload -U colors && colors

# bash like help
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

autoload -U compinit # enable programmable completion
zstyle ':completion:*' menu select # arrow-key driven
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitive
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump
_comp_options+=(globdots)

ZSH_CONFIG="$HOME/.config/bash"
[ -f "$ZSH_CONFIG/aliases.sh" ] && . "$ZSH_CONFIG/aliases.sh"
[ -f "$ZSH_CONFIG/teleport.sh" ] && . "$ZSH_CONFIG/teleport.sh"
[ -f "$ZSH_CONFIG/functions.sh" ] && . "$ZSH_CONFIG/functions.sh"

set -o vi
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

source <(fzf --zsh)

HISTSIZE=2000
SAVEHIST=40000
setopt inc_append_history
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompdump

setopt autocd		# Automatically cd into typed directory.

# vi indicator cursor
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[2 q';; # normal mode
        viins|main) echo -ne '\e[6 q';; # insert mode
    esac
}
zle -N zle-keymap-select

# initiate `vi insert` as keymap
zle-line-init() {
    zle -K viins
}
zle -N zle-line-init

echo -ne '\e[6 q' # insert mode cursor on start up
preexec() { echo -ne '\e[6 q' ;} # insert mode  cursor for new prompt

# line editor v in normal mode
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

[ -f "$HOME/.config/dircolors" ] && source <(dircolors "$HOME/.config/dircolors")

[ -f "/usr/share/git/completion/git-prompt.sh" ] && . /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1        # + for staged, * if unstaged
GIT_PS1_SHOWSTASHSTATE=1        # $ if something is stashed.
GIT_PS1_SHOWUNTRACKEDFILES=1    # % if there are untracked files
GIT_PS1_SHOWUPSTREAM=1 	        # <, >, <> behind, ahead, or diverged from upstream.
GIT_PS1_STATESEPARATOR=" " 	    # separator between branch name and state symbols
GIT_PS1_DESCRIBE_STYLE=1 	    # show commit relative to tag or branch, when detached HEAD
GIT_PS1_SHOWCOLORHINTS=1        # display in color
setopt PROMPT_SUBST
if [ ! $UID -eq 0 ]; then
    if [ -n "$SSH_CONNECTION" ]; then
        PS1='%{$bg[magenta]%}%n@%m%{$reset_color%} %B%{$bg[black]%}%~$(__git_ps1 " %s")%{$reset_color%} \$ '
    else
        PS1='%{$bg[blue]%}%n@%m%{$reset_color%} %B%{$bg[black]%}%~$(__git_ps1 " %s")%b%{$reset_color%} \$ '
    fi
else
        PS1='%{$bg[red]%}%n@%m%{$reset_color%} %B%{$bg[black]%}%~$(__git_ps1 " %s")%b%{$reset_color%} \$ '
fi

# gpg with pinentry-curses and pinentry-tty
export GPG_TTY=$(tty)
