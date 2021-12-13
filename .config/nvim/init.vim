"
" Licensed under MIT
" copyright © 2020 Injamul Mohammad Mollah <mrinjamul@gmail.com>
" All rights reserved.


source $HOME/.config/nvim/vim-plug/plugins.vim

" default features configuration for vim
"
" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

set wildmode=list:longest

" true gui color support
set termguicolors

" clear search results
nnoremap <silent> // :noh<CR>

" show line numbers
set nu

" Helps force plugins to load correctly when it is turned back on below
filetype on

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" END
