" call plug#begin('~/.vim/plugged')
" 
" Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'ryanoasis/vim-devicons'
" "Plug 'KabbAmine/yowish.vim'
" "Plug 'sheerun/vim-polyglot'
" "Plug 'dikiaap/minimalist'
" "Plug 'vim-airline/vim-airline'
" "Plug 'powerline/powerline-fonts'
" call plug#end()

set t_Co=256
set encoding=UTF-8
syntax on
colorscheme torte

set shiftwidth=2	" size of indents in spaces
set softtabstop=2	" simulate tabs with this many spaces

" FileType specific tab overrides
filetype plugin indent on " Enable filetype detection and <filetype>.vim loading

" Line numbers and mouse
set number relativenumber  " enable line numbiers
set nu rnu
set mouse=a                " enable mouse in auto mode
set expandtab
set hlsearch
set incsearch

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
nnoremap <C-n> :NERDTreeToggle<CR>
