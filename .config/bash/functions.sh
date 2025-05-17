# bash/functions.sh
# @author nate zhou
# @since 2025

# cd into parent
Cd() {
    cd "$(dirname $1)"
}

# read help with a pager
help() {
    help_output=$(command help "$@")
    [ "$?" -eq 0 ] && echo "$help_output" | /usr/bin/less -i
}

# avoid nested lf
lf() {
    [ -z "$LF_LEVEL" ] && /usr/bin/lf "$@" || exit &>/dev/null
}

# print the 16 terminal colors
colors() {
    for i in {0..15}; do
        printf "\e[48;5;${i}m  \e[0m"
        [ $((($i + 1) % 8)) -eq 0 ] && printf "\n"
    done
}

# offline dictionary with wordnet
dict() {
    /usr/bin/dict -d wn "$@" | /usr/bin/less -i -F
}

# package management
## list binaries
plb() {
    pacman -Ql "$@" | grep -E '/usr/bin/.+$'
}
## list licenses
pll() {
    pacman -Qi "$@" | grep '^Licenses' | cut -d' ' -f10-
}

# new footclient in current working directory
osc7_cwd() {
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+${PROMPT_COMMAND%;}; }osc7_cwd

lfcd() {
    cd "$(command lf -print-last-dir "$@")"
}
bind '"\C-o":"lfcd\C-m"'
