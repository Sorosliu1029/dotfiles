" auto-reload .vimrc immediately
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" be iMproved, required
set nocompatible
" define <Leader>
let mapleader=";"
" configuration for native vim
syntax enable
syntax on
set mouse=a
set encoding=utf-8
" edit related
set backspace=indent,eol,start
" appearance related
set background=dark
set number
set laststatus=2
set ruler
set cursorline
set cursorcolumn
set nowrap
set shortmess-=S
" indent related
set autoindent
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=4
" search related
set showmatch
set hlsearch
set incsearch
set ignorecase

set history=1000
set autoread
" fold code based on indent or syntax
"set foldmethod=indent
set foldmethod=syntax
set nofoldenable
" to show invisible characters
set listchars=trail:■
set list
" auto-complete vim's commands
set wildmenu

"---------------- configuration required by Vundle ---------------
" see https://github.com/VundleVim/Vundle.vim for details
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" color theme: solarized
Plugin 'altercation/vim-colors-solarized'
" utility plugin for statusline
Plugin 'vim-airline/vim-airline'
" git wrapper
Plugin 'tpope/vim-fugitive'
" visually display indent levels
Plugin 'nathanaelkane/vim-indent-guides'
" file management
Plugin 'scrooloose/nerdtree'
" auto-complete
" Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ----------------- configurations for vim plugins ----------------
" configuration for colors
colorscheme solarized

" configuration for airline
let g:airline_powerline_fonts=1

" configuration for nerdtree
map <C-n> :NERDTreeToggle<CR>

" configuration for vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
