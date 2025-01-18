set termguicolors

" Enable syntax highlighting
syntax enable

" Set file type detection and plugin loading
filetype plugin indent on

" Enable line numbers and relative line numbers
set number
set relativenumber

" Set tab width and indentation settings
set tabstop=2       " Number of spaces per tab
set shiftwidth=2    " Number of spaces for each indentation level
set expandtab       " Convert tabs to spaces

" Enable auto-indentation
set smartindent
set autoindent
set cindent

" Highlight current line
set cursorline

" Enable line wrapping and set text width
set nowrap
set textwidth=80

" Enable search highlighting and incremental search
set hlsearch
set incsearch

" Use system clipboard for copy and paste
set clipboard=unnamedplus

" Enable file search with path completion
set wildmenu

set ignorecase      " Ignore case in searches by default
set smartcase       " Override ignorecase if pattern contains uppercase

" Remap jk to Esc in Insert mode
inoremap jk <Esc>

" Plug automatic installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins with plug
call plug#begin()

" List your plugins here

Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }

call plug#end()

" colorsheme initialization file
colorscheme moonfly
let g:moonflyTransparent = v:true

" Ensure transparency settings are applied
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
