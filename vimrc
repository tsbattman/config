
syntax on
set hlsearch

filetype plugin indent on

colorscheme elflord

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
set wildignore=*.fasl,*.o,*.class,*.hi

set formatoptions=tcroq " Formatting options
set nobackup            " Do not keep a backup file
set viminfo='20,<500,"500   " read/write a .viminfo file -- limit regs to 500 lines
set history=50          " keep 50 lines of command history
set ruler               " Show the cursor position all the time

" Don't use Ex mode, use Q for formatting
map Q gq

set t_ti=
set t_te=

