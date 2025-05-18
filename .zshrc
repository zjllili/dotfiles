# zshrc
# @author nate zhou
# @since 2025

autoload -U compinit # enable programmable completion
zstyle ':completion:*' menu select # arrow-key driven
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitive
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # dircolors
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompdump
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump
_comp_options+=(globdots)

autoload -U colors && colors
[ -f "$HOME/.config/dircolors" ] && source <(dircolors "$HOME/.config/dircolors")

SHELL_CONFIG="$HOME/.config/shell" # general shell configs
[ -f "$SHELL_CONFIG/aliases.sh" ] && . "$SHELL_CONFIG/aliases.sh"
[ -f "$SHELL_CONFIG/teleport.sh" ] && . "$SHELL_CONFIG/teleport.sh"
[ -f "$SHELL_CONFIG/functions.sh" ] && . "$SHELL_CONFIG/functions.sh"

ZSH_CONFIG="$HOME/.config/zsh" # zsh specifc configs
[ -f "$ZSH_CONFIG/aliases.zsh" ] && . "$ZSH_CONFIG/aliases.zsh"
[ -f "$ZSH_CONFIG/functions.zsh" ] && . "$ZSH_CONFIG/functions.zsh"

set -o vi
source <(fzf --zsh)

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey -s '^o' 'lfcd\n'  # .config/shell/functions.sh

HISTSIZE=2000
SAVEHIST=40000
setopt inc_append_history

setopt autocd		# auto cd by typing path

setopt PROMPT_SUBST

[ -f "/usr/share/git/completion/git-prompt.sh" ] && . /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1        # + for staged, * if unstaged
GIT_PS1_SHOWSTASHSTATE=1        # $ if something is stashed.
GIT_PS1_SHOWUNTRACKEDFILES=1    # % if there are untracked files
GIT_PS1_SHOWUPSTREAM=1 	        # <, >, <> behind, ahead, or diverged from upstream.
GIT_PS1_STATESEPARATOR=" " 	    # separator between branch name and state symbols
GIT_PS1_DESCRIBE_STYLE=1 	    # show commit relative to tag or branch, when detached HEAD
GIT_PS1_SHOWCOLORHINTS=1        # display in color

if [ ! $UID -eq 0 ]; then
    if [ -n "$SSH_CONNECTION" ]; then
        PS1='%{$(tput setab 11 setaf 0)%}%n@%m%{$reset_color%} %B%{$bg[black]%}%1~$(__git_ps1 " %s")%{$reset_color%} \$ '
    else
        PS1='%{$()$(tput setab 12)%}%n@%m%{$reset_color%} %B%{$bg[black]%}%1~$(__git_ps1 " %s")%b%{$reset_color%} \$ '
    fi
else
        PS1='%{$(tput setab 9 setaf 0)%}%n@%m%{$reset_color%} %B%{$bg[black]%}%1~$(__git_ps1 " %s")%b%{$reset_color%} \$ '
fi

export GPG_TTY=$(tty) # TUI pinentry, need be set for each pts

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
ZSH_HIGHLIGHT_STYLES[arg0]=fg=white,bold # like echo
#ZSH_HIGHLIGHT_STYLES[precommand]=fg=yellow # like sudo
#ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=white,underline
#ZSH_HIGHLIGHT_STYLES[path]=fg=white,underline # filenames

#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
#bindkey '^l' autosuggest-accept
#bindkey '^l' autosuggest-accept
#bindkey '^w' forward-word
#bindkey '^b' backward-word
#fpath=(path/to/zsh-completions/src $fpath)
