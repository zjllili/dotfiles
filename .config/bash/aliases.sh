# bash/aliases.sh
# @author nate zhou
# @since 2023,2024,2025

# think twice
alias rm="rm -I";
alias cp="cp -i";
alias mv="mv -i";

# colorize
if [ -x /usr/bin/dircolors ]; then
    [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto --group-directories-first'
fi
alias diff="diff --color=auto"
alias vdiff="nvim -d"
alias grep="grep --color=auto"
alias ip="ip -color=auto"

# output formating
alias ll="ls -lh --time-style=long-iso"
alias la="ls -A"
alias lla="ls -lhA --time-style=long-iso"
alias l.="ls -d .*"
alias ll.="ls -lh -d --time-style=long-iso .*"
alias lt="ls -lt --time-style=long-iso"

alias less="less -i -F"
alias bat="bat --style='plain,changes,rule,snip'"

alias whatis="whatis -l"
alias sync="~/.local/bin/sync-notify"

## GUI
alias wshowkeys="wshowkeys -a bottom -b '#11111188' -F 'SourceCodePro 28'"

## hardware
alias du="du -h -d 1"
alias dU="du -h -d 1 | sort -rh"
alias ncdu="ncdu -x --hide-hidden"
alias df="df -h -x tmpfs -x efivarfs -x devtmpfs"
alias lsblk="lsblk -o name,mountpoints,type,size"
alias free="free -h"
alias iostat="iostat -t 2"

## viewer
alias mpv="mpv --loop"

## fuzzy menu
alias wmenu="wmenu -f 'SourceCodePro Medium 13' -i -S 6f3f89 -s ffffff -M 6f3f89 -m ffffff"
alias fzf="/usr/bin/fzf --bind=ctrl-j:preview-down,ctrl-k:preview-up --reverse --color=16 --preview-window=65%:wrap:border-sharp: --preview 'bat --color=always --style=plain,changes {}'"
alias ,,="~/.local/bin/teleport-genesis-search"

### fzf text editor
alias fvi="fzf --bind='enter:execute(nvim {+}),ctrl-j:preview-down,ctrl-k:preview-up'"
### fzf image preview
alias fimg="find -type f \( -name "*.png" -o -name "*.jpeg" -o -name "*.jpg" -o -name "*.webp" \) | fzf --bind=ctrl-j:preview-down,ctrl-k:preview-up --preview 'catimg -w100 {}' --preview-window=90%:bottom: --bind='enter:execute(swayimg {})'"
### fzf directory preview
alias ftree="realpath * | fzf --bind=ctrl-j:preview-down,ctrl-k:preview-up --prompt='ftree: ' --reverse --preview 'tree -L1 {}'"
### fzf package info preview
alias fpinfo="pacman -Qq | fzf --bind=ctrl-j:preview-down,ctrl-k:preview-up --prompt='package info: ' --preview-window=70%:bottom: --preview 'pacman -Qi {}'"
### fzf package dependency preview
alias fptree="pacman -Qq | fzf --bind=ctrl-j:preview-down,ctrl-k:preview-up --prompt='reverse depends: ' --preview-window=70%:bottom: --preview 'pactree -rd2 {}'"
### fzf package cache preview
alias fpcache="pacman -Qq | fzf --bind=ctrl-j:preview-down,ctrl-k:preview-up --prompt='package cache: ' --preview-window=70%:bottom: --preview 'ls /var/cache/pacman/pkg/{}-[0-9]*.pkg.tar.zst'"
### fzf git previews
alias fgl="git log | grep '^commit ' | cut -d' ' -f2 | fzf --bind=ctrl-j:preview-down,ctrl-k:preview-up --preview 'git show {} | bat --color=always --style=plain,changes ' --preview-window=90% | wl-copy"
alias fglf=" fzf --bind=ctrl-j:preview-down,ctrl-k:preview-up --preview 'git log --follow -p {} | bat --color=always --style=plain,changes' "

# abbreviation
## directory
alias .r=". ~/.bash_profile && . ~/.bashrc"
alias ..="cd .."
alias ...="cd ../.."

alias ?="pwd"
alias ??="realpath"

alias Gi="cd /run/media/$USER/ && pwd"

## stow
alias heartstow='cd ~/doc/heart && stow --adopt -t ~ . && cd - &>/dev/null && echo "heart is stowed"'
alias heartunstow='cd ~/doc/heart && stow -D -t ~ . && cd - &>/dev/null && echo "heart is unstowed"'
alias heartrestow='cd ~/doc/heart && stow -R --adopt -t ~ . && cd - &>/dev/null && echo "heart is stowed"'

alias ollamastow='cd ~/pkg/ollama && stow --adopt -t ~ . && cd - &>/dev/null && echo "ollama is stowed"'
alias ollamarestow='cd ~/pkg/ollama && stow -R --adopt -t ~ . && cd - &>/dev/null && echo "ollama is stowed"'
alias ollamaunstow='cd ~/pkg/ollama && stow -D -t ~ . && cd - &>/dev/null && echo "ollama is unstowed"'

## power management
alias hibernate="systemctl hibernate"
alias poweroff="systemctl poweroff"
alias reboot="systemctl reboot"

## cli/tui
alias vim="nvim"
alias mutt="$HOME/.local/bin/mutt-i3blocks"

alias tsk="task";
alias twt="taskwarrior-tui"

alias yt-dlp="yt-dlp --embed-metadata --cookies-from-browser firefox"
alias id3v2="mid3v2"

alias epr="firejail --profile=$HOME/.config/firejail/epr.local epr"
alias epr-zh="firejail --profile=$HOME/.config/firejail/epr-zh.local epr-zh"

alias p="source $HOME/.local/sbin/prox"
alias P="getprox";

### tmux
alias tksv="tmux kill-server"
alias tlss="tmux list-session"
alias tkss="tmux kill-session -t"
alias tat="tmux attach"

### package management
alias cksv="sudo checkservices"
alias ckrb="checkrebuild"
alias ckud="$HOME/.local/bin/checkupdates-cron"
alias ckkn="$HOME/.local/bin/checkkernels"
alias lsud="$HOME/.local/bin/lsupdates"
alias rmcc="$HOME/.local/bin/rmcache"
alias rmop="$HOME/.local/bin/rmorphan"
alias pl="pacman -Ql"
alias po="pacman -Qo"
alias pd="pactree -d1"
alias pv="pactree -rd1"

## git
alias gs="git status -s 2>/dev/null"
alias gsh="git show"

alias gb="git branch"
alias gck="git checkout"
alias gcm="git checkout master"

alias ga="git add"
alias gac="git add . && git commit -m update"

alias gd="git diff"
alias gds="git diff --staged"
alias gdw="git diff --word-diff"
alias gdws="git diff --word-diff --staged"

alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gll="git log --graph --all"
alias gln="git log --graph --abbrev-commit --name-only"
alias glf="git log --follow -p"
alias glfa="git log --follow -p --graph --abbrev-commit --show-signature"
alias gls="git log --show-signature"
alias gla="git log --graph --all --name-only --abbrev-commit --show-signature"

### games
alias ttypers="ttyper -w 10 -l symbol"
alias ttyperb="ttyper -w 25 -l bash"
alias ttysolitaire="ttysolitaire -p 99 --no-background-color"

## gui
alias sw="sway --unsupported-gpu"
alias vm="virt-manager"

### viewer
alias swayimg="swayimg --class swayimgapp" # sway window border per app_id

# env
#alias Er="echo RANGER_LEVEL=$RANGER_LEVEL"

# legacy
#alias x="startx"
#alias ed="ed -p :"
#alias fim="fim -a --no-commandline --no-etc-rc-file --no-stat-push"
#alias mupdf="mupdf -I -C cccccc -r 140 -S13"
#alias transmission-cli="transmission-cli -w /data/tmp"
