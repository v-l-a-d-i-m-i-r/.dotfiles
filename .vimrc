"call plug#begin('~/.vim/plugged')
"Plug 'junegunn/seoul256.vim'
"Plug 'KabbAmine/yowish.vim'
"Plug 'sheerun/vim-polyglot'
"Plug 'dikiaap/minimalist'
"Plug 'vim-airline/vim-airline'
"Plug 'powerline/powerline-fonts'
"call plug#end()


" delek desert elflord industry murphy pablo torte

set t_Co=256
syntax on
colorscheme torte

set shiftwidth=2	" size of indents in spaces
set softtabstop=2	" simulate tabs with this many spaces

" FileType specific tab overrides
filetype plugin indent on " Enable filetype detection and <filetype>.vim loading
"autocmd FileType html setlocal shiftwidth=2 tabstop=2
"autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
"autocmd FileType vue setlocal shiftwidth=2 tabstop=2
"autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2

" Line numbers and mouse
set number relativenumber  " enable line numbers
set nu rnu
set mouse=a                " enable mouse in auto mode

