#!/usr/bin/env sh

APP_NAME="vim-in"

# BACKUP_DATE=`cat $HOME/.vim-in.bak`

msg() {
    printf '%b\n' "$1" >&2
}

variable_set() {
    if [ -z "$1" ]; then
        error "You must have your HOME environmental variable set to continue."
    fi
}


success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}


do_restore() {
        msg "Attempting to restore your original vim configuration."
        local today=`cat $HOME/.vim-in.bak`
        for i in "$1" "$2" "$3"; do
            mv -v "$i.$today" "$i";
        done
        local ret='0'
        success "Your original vim configuration has been restored."
        rm "$HOME/.vim-in.bak"
}

uninstall_all() {
    rm -rf $HOME/.vim;
    rm -rf $HOME/.vimrc;
}

# Main

variable_set "$HOME"

msg "Uninstalling $APP_NAME"

uninstall_all

do_restore      "$HOME/.vim" \
                "$HOME/.vimrc" \
                "$HOME/.gvimrc"

msg             "\nThanks for using $APP_NAME."
msg             "$APP_NAME uninstalled successfully."
