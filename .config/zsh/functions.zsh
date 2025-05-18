# .config/zsh/functions.zsh
# @author nate zhou
# @since 2025
# zsh specific functions

function osc7-pwd() { # new footclient in current working directory for zsh
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}
function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

function zle-keymap-select () { # vi indicator cursor
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
