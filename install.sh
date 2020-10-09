#!/usr/bin/env sh

APP_NAME="vim-in"


msg() {
    printf '%b\n' "$1" >&2
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

program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

program_must_exist() {
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        error "You must have '$1' installed to continue."
    fi
}

variable_set() {
    if [ -z "$1" ]; then
        error "You must have your HOME environmental variable set to continue."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

do_backup() {
    if [ -e "$1" ] || [ -e "$2" ] || [ -e "$3" ]; then
        msg "Attempting to back up your original vim configuration."
        today=`date +%Y%m%d_%s`
        for i in "$1" "$2" "$3"; do
            [ -e "$i" ] && [ ! -L "$i" ] && mv -v "$i" "$i.$today"; echo "$today" > $HOME/.vim-in.bak ;
        done
        ret="$?"
        success "Your original vim configuration has been backed up."
        debug
   fi
}

install_vim() {
    cp .vimrc "$1"
    cp -rf .vim "$HOME"
    ret="$?"
    debug
}

install_plugins() {

    vim \
        "+PlugInstall" \
        "+PlugClean" \
        "+CocInstall coc-html coc-css coc-json coc-prettier coc-tsserver"\
        "+CocUpdateSync"\
        "+qall"


    success "Now installing plugins using Vim Plug"
    debug
}

# Main

variable_set "$HOME"
program_must_exist "vim"
program_must_exist "git"
program_must_exist "yarn"

do_backup       "$HOME/.vim" \
                "$HOME/.vimrc" \
                "$HOME/.gvimrc"

install_vim "$HOME/.vimrc" 

install_plugins


msg             "\nThanks for installing $APP_NAME."
msg             "© `date +%Y` Injamul Mohammad Mollah"
