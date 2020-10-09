#!/usr/bin/env sh

APP_NAME="vim-in"

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

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

do_restore() {
    if [ -e "$1" ] || [ -e "$2" ] || [ -e "$3" ]; then
        msg "Attempting to restore your original vim configuration."
        today=`cat $HOME/.vim-in.bak`
        for i in "$1" "$2" "$3"; do
            [ -e "$i.$today" ] && [ ! -L "$i.$today" ] && mv -v "$i.$today" "$i";
        done
        ret="$?"
        success "Your original vim configuration has been restored."
        debug
   fi
}

uninstall_all() {
    rm -rf $HOME/.vim;
    rm -rf $HOME/.vimrc;
    debug
}

# Main

variable_set "$HOME"

msg "Uninstalling $APP_NAME"

uninstall_all

do_restore       "$HOME/.vim" \
                "$HOME/.vimrc" \
                "$HOME/.gvimrc"

ret = "$?"

if [ "$ret" -eq '1' ] && [ "$ret" -gt '1' ]; then
    msg "An error occurred."
    exit 0
fi

msg             "\nThanks for using $APP_NAME."
msg             "$APP_NAME uninstalled successfully."
