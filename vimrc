
execute pathogen#infect()

syntax enable
syntax sync fromstart
set hlsearch

filetype plugin indent on

set background=dark
if has('gui_running')
  "let g:solarized_contrast="high"
  colorscheme solarized
else
  colorscheme koehler
end

set cursorline

"let loaded_matchparen=1 " Do not show matching parens

set nocompatible        " Use Vim defaults (much better!)
set bs=2                " Allow backspacing over everything in insert mode

set showmatch
set shiftwidth=2
set tabstop=2
set expandtab

set laststatus=2

set foldmethod=indent   " Set folding method
set foldlevelstart=99   " Do not fold by default
set wildignore=*.fasl,*.o,*.class,*.hi,*.pyc

set formatoptions=tcroq " Formatting options
set nobackup            " Do not keep a backup file
set viminfo='20,<500,"500   " read/write a .viminfo file -- limit regs to 500 lines
set history=50          " keep 50 lines of command history
set ruler               " Show the cursor position all the time
set guioptions=ri

" Don't use Ex mode, use Q for formatting
map Q gq

set t_ti=
set t_te=

let mapleader='-'

set grepprg=sgrep\ -n
nnoremap <leader>* "zyiw:exe "grep ".@z<CR>
nnoremap } }zz
nnoremap { {zz

