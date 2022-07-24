"
" Licensed under MIT
" copyright © 2020 Injamul Mohammad Mollah <mrinjamul@gmail.com>
" All rights reserved.
"
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
  autocmd VimEnter * PlugInstall | source $HOME/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    
    " File Explorer
    Plug 'scrooloose/NERDTree'
    Plug 'scrooloose/nerdcommenter'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    " Nord Theme for neovim
    Plug 'arcticicestudio/nord-vim'

    " Dracula Theme for vim
    Plug 'dracula/vim', { 'as': 'dracula' }

    " Window chooser
    " Ref-https://github.com/t9md/vim-choosewin
    Plug 't9md/vim-choosewin'
    
    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    
    " FZF plugin for file browsing inside coding
    " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    " Plug 'junegunn/fzf.vim'
    
    " This plugin shows icons in vim
    Plug 'ryanoasis/vim-devicons'

    " Rainbow brackets highlighter
    Plug 'frazrepo/vim-rainbow'

    " Find in a file
    Plug 'mileszs/ack.vim'

    " Git tools
    Plug 'tpope/vim-fugitive'

    " Blamer for vim " Fix the error in vim 8
    "Plug 'apzelos/blamer.nvim'
    " For VIM 8.2 or NeoVIM
    if v:version >= 802 || has('nvim')
        Plug 'APZelos/blamer.nvim'
    endif

    " Git diff modified added and removed
    if has('nvim') || has('patch-8.0.902')
        Plug 'mhinz/vim-signify'
    else
        Plug 'mhinz/vim-signify', { 'branch': 'legacy'  }
    endif

    " neocomplete completion framework
    " neocomplete is a completion framework for Vim below 8.2.
    "Plug 'Shougo/neocomplete.vim'
    " For neovim or vim 8.2+ use 'Shougo/deoplete.nvim' or 'Shougo/ddc.vim'
    "Plug 'Shougo/ddc.vim'
    "Plug 'vim-denops/denops.vim'
    
    " Vim language server
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }

    " Go support
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " Syntax Checker
    Plug 'scrooloose/syntastic'

    " Tag Lists
    " Plug 'vim-scripts/taglist.vim'

    " HTML Plugin for vim
    Plug 'mattn/emmet-vim'

    " Github Gist
    Plug 'mattn/webapi-vim'
    Plug 'mattn/gist-vim'

    " Minimap for vim
    Plug 'wfxr/minimap.vim'

    " Github Copilot
    Plug 'github/copilot.vim'
    "
call plug#end()

" UTF-8 encoding
set encoding=UTF-8

" Key Mapper
"
" Windows chooser configs
nmap - <Plug>(choosewin)
let g:choosewin_overlay_enable = 1

" NERDTree Show Hidden files (shift + i for toggle)
" let NERDTreeShowHidden=1

let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" autopairs configurations
let g:AutoPairsShortcutToggle = '<C-a>'

" Nord theme using 'arcticicestudio/nord-vim'
" colorscheme nord
" Dracula theme using 'dracula/vim'
colorscheme dracula
" Transparent background after using any theme
highlight Normal guibg=NONE ctermbg=NONE


" Airline Start ------------------------------

let g:airline_powerline_fonts = 0
" let g:airline_theme = 'bubblegum'
" let g:airline_theme = 'minimalist'
let g:airline_theme = 'dracula'
let g:airline#extensions#whitespace#enabled = 0
let g:coc_disable_startup_warning = 1
" Fancy Symbols!!
" Enable it if Nerd Font or any patched Nerd Font is installed
let fancy_symbols_enabled = 1

if fancy_symbols_enabled
    let g:webdevicons_enable = 1

    " custom airline symbols
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''

    " Not supported icons
    " let g:airline_symbols.branch = '⭠'
    " let g:airline_symbols.readonly = '⭤'
    " let g:airline_symbols.linenr = '⭡'

else
    let g:webdevicons_enable = 0
endif
" Airline end----------------------------------

" remap envoke key FZF
nnoremap <silent> <C-x> :FZF<CR>

" Active Rainbow

let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

" For coc.nvim configs
" Coc Prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" COC Configuration for GoLang
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"
" auto install coc.nvim extensions
" let g:coc_global_extensions = ['coc-html', 'coc-css', 'coc-json', 'coc-prettier', 'coc-tsserver']

" Syntastic
let g:syntastic_python_python_exec = 'python3'

" Github Gist
let g:gist_show_privates = 1
let g:gist_post_private = 1
let g:gist_api_url = 'https://api.github.com'

:set backspace=indent,eol,start
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
let g:blamer_relative_time = 1

" Minimap settings
let g:minimap_width = 10
" let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1

" Github Copilot configurations
let g:copilot_filetypes = {
            \ 'md': v:true,
            \ 'markdown': v:true,
            \ }

" END
