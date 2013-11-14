
let mapleader='-'

" Thirdparty stuff
let g:ctrlp_map='<leader>t'
let g:ctrlp_cmd='CtrlPMixed'
let g:neobundle#types#git#default_protocol='git'
" let g:unite_enable_start_insert = 1
" let g:unite_split_rule = "botright"
" let g:unite_force_overwrite_statusline = 0

set rtp+=~/.vim/bundle/neobundle.vim
call neobundle#rc(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kien/ctrlp.vim'

" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#filters#sorter_default#use(['sorter_rank'])
" nnoremap <leader>t :<C-u>Unite  -buffer-name=files -start-insert buffer file_rec<CR>

" Unused
"set rtp+=~/.vim/bundle/vundle
"call vundle#rc()
"Bundle 'gmarik/vundle'

""""" My stuff
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

"let loaded_matchparen=1 " Do not show matching parens

set nocompatible        " Use Vim defaults (much better!)
set bs=2                " Allow backspacing over everything in insert mode
set cursorline

set showmatch
set shiftwidth=2
set tabstop=2
set expandtab
set shiftround

set nowrap
set scrolloff=2
set sidescroll=1
set sidescrolloff=5
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
set autoread

" Don't use Ex mode, use Q for formatting
map Q gq

set t_ti=
set t_te=

set grepprg=sgrep\ -n
nnoremap <leader>* "zyiw:exe "grep '\\<".@z."\\>'"<CR>
nnoremap } }zz
nnoremap { {zz

