"
" Licensed under MIT
" copyright © 2020 Injamul Mohammad Mollah <mrinjamul@gmail.com>
"

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')

" Window chooser
" Ref-https://github.com/t9md/vim-choosewin
Plug 't9md/vim-choosewin'

" file browser
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" FZF plugin for file browsing inside coding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'

"JS Plugin
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" HTML Plugin
Plug 'mattn/emmet-vim'

" Syntax Checker
Plug 'scrooloose/syntastic'

" code snippets
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
Plug 'marcweber/vim-addon-mw-utils'


" Git tool
Plug 'tpope/vim-fugitive'

" fuzzy file finder
" Plug 'ctrlpvim/ctrlp.vim'

" vim-rainbow brackets highlighter
Plug 'frazrepo/vim-rainbow'

" find in a file 
Plug 'mileszs/ack.vim'

" Git diff modified added and removed
if has('nvim') || has('patch-8.0.902')
      Plug 'mhinz/vim-signify'
  else
        Plug 'mhinz/vim-signify', { 'branch': 'legacy'  }
    endif

" Tag Lists
" Plug 'vim-scripts/taglist.vim'

" Plug 'prettier/vim-prettier', {
"  \ 'do': 'yarn install --frozen-lockfile',
"  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

"Ruby On Rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" Java Autocomplete
Plug 'artur-shaik/vim-javacomplete2'

"neocomplete plugin
Plug 'Shougo/neocomplete.vim'

" For GoLang

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Key Mapper
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

" Airline Start ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
let g:coc_disable_startup_warning = 1
" Fancy Symbols!!
let fancy_symbols_enabled=0

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
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'
else
    let g:webdevicons_enable = 0
endif
" Airline end----------------------------------

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" show line numbers
set nu

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

set wildmode=list:longest

" clear search results
nnoremap <silent> // :noh<CR>

" remap envoke key FZF
nnoremap <silent> <C-x> :FZF<CR>

" Java
autocmd FileType java setlocal omnifunc=javacomplete#Complete


" Configuration for GoLang

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

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

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

" Coc Prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" coc.nvim extensions
let g:coc_global_extensions = ['coc-html', 'coc-css', 'coc-json', 'coc-prettier', 'coc-tsserver']
