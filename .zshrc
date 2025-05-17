# zshrc
# @author nate zhou
# @since 2025

autoload -U colors && colors
source $HOME/.profile

# enable programmable completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
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
HISTFILE="$HOME/.local/state/zsh/history"
setopt inc_append_history

setopt autocd		# Automatically cd into typed directory.

[ -f "$HOME/.config/dircolors" ] && source <(dircolors "$HOME/.config/dircolors")

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

if [ ! $UID -eq 0 ]; then
    if [ -n "$SSH_CONNECTION" ]; then
        PS1="%{$bg[yellow]%}%n@%M%{$reset_color%} %B%{$bg[black]%}%~%{$reset_color%}%b $ "
    else
        PS1="%{$bg[blue]%}%n@%M%{$reset_color%} %B%{$bg[black]%}%~%{$reset_color%}%b $ "
    fi
else
        PS1="%{$bg[red]%}%n@%M%{$reset_color%} %B%{$bg[black]%}%~%{$reset_color%}%b $ "
fi

# gpg with pinentry-curses and pinentry-tty
export GPG_TTY=$(tty)
