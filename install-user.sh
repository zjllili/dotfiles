#!/usr/bin/env bash
# @author nate zhou
# @since 2025
# Setup user-space softwares
set +x

DOTFILES_REMOTE=("https://codeberg.org/unixchad/dotfiles" \
                 "https://github.com/gnuunixchad/dotfiles")
DOTFILES_LOCAL="${HOME}/doc/heart"

print_err() {
    local RED='\033[0;31m'
    local RESET='\033[0m'
    echo -e ${RED}${1}${RESET}
}

umask 027
mkdir -p ${HOME}/{dls,doc,mnt,mus,pic,pkg,smb,tmp,vid}
chmod 700 ${HOME}/{dls,mnt,tmp}
chmod 705 ${HOME}/pkg

mkdir -p ${HOME}/.{cache/mpd,config/'Code - OSS',local/{share,state}}

[ ! -d "$DOTFILES_LOCAL" ] && \
    git clone "${DOTFILES_REMOTE[1]}" $DOTFILES_LOCAL || \
    git clone "${DOTFILES_REMOTE[2]}" $DOTFILES_LOCAL

mv ${HOME}/.bash_profile{,~}
[ -L "${HOME}/.bashrc" ] || mv ${HOME}/.bashrc{,~}

cd "$DOTFILES_LOCAL" && stow -R -t $HOME . --adopt

[ -x /usr/bin/zsh ] && chsh -s /usr/bin/zsh

systemctl enable --now --user ssh-agent.service

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

SSHCONFIG="${HOME}/.ssh/config"
[ -f "$SSHCONFIG" ] || cp ${SSHCONFIG}.example $SSHCONFIG

BTOP="${HOME}/.config/btop/btop.conf"
[ -f "$BTOP" ] || cp ${BTOP}.example $BTOP

GIT="${HOME}/.config/git/config"
[ -f "$GIT" ] || cp ${GIT}.example $GIT

MUTT="${HOME}/.config/mutt/account"
[ -f "$MUTT" ] || cp ${MUTT}.example $MUTT

NEWSBOAT="${HOME}/.config/newsboat"
[ -f "${NEWSBOAT}/config" ] || cp ${NEWSBOAT}/config{.example,}
[ -f "${NEWSBOAT}/urls" ] || cp ${NEWSBOAT}/urls{.example,}

QUTEBROWSER="${HOME}/.config/qutebrowser/config.py"
[ -f "$QUTEBROWSER" ] || cp ${QUTEBROWSER}.example $QUTEBROWSER

ISYNC="${HOME}/.config/isyncrc"
[ -f "$ISYNC" ] || cp ${ISYNC}.example $ISYNC


GPGKEYS="${HOME}/doc/.gpg/gpg-keys"
[ -d "$GPGKEYS" ] && gpg --import $(realpath $(ls ${GPGKEYS}/*.pub | command fzf --prompt="[gpg]: public key to import"))
[ -d "$GPGKEYS" ] && gpg --import $(realpath $(ls ${GPGKEYS}/*.sec | command fzf --prompt="[gpg]: private key to import"))

CRONTAB="${HOME}/.config/crontab.backup"
[ -f "$CRONJOB" ] && crontab $CRONTAB || print_err "[crontab]: $CRONTAB doesn't exist"

CALCURSE="${HOME}/.config/calcurse/calendar.ical}"
[ -f "$CALCURSE" ] && calcurse -i $CALCURSE || print_err "[calcurse -i]: $CALCURSE doesn't exist"
