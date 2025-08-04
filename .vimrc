" NetRW configuration
let g:netrw_liststyle=3

" statusline
set laststatus=3

" mouse
set mouse=""

" Line numbers
set relativenumber     " show relative line numbers
set number             " show absolute line number on cursor line

" Tabs & indentation
set tabstop=2          " 2 spaces for tabs
set shiftwidth=2       " 2 spaces for indent width
set expandtab          " expand tab to spaces
set autoindent         " copy indent from current line when starting new one

" Line wrapping
"set wrap               " disable line wrapping (fixed typo from 'risable')

" Search settings
set ignorecase         " ignore case when searching
set smartcase          " if you include mixed case in your search, assumes case-sensitive

" Cursor line
set cursorline         " highlight the current cursor line

" Appearance
set termguicolors      " enable true color support
set background=dark    " set dark background for colorschemes

" Sign column
"set signcolumn=yes     " show sign column to avoid text shifting

" Backspace behavior
set backspace=indent,eol,start  " allow backspace on indent, end of line, or insert mode start position

" Clipboard
set clipboard+=unnamedplus   " use system clipboard as default register

" Only run if we're under Wayland
if !empty($WAYLAND_DISPLAY)
  " Copy yanks and deletes to system clipboard
  autocmd TextYankPost * if (v:event.operator ==# 'y' || v:event.operator ==# 'd') |
        \ silent! call system('wl-copy', @") |
        \ endif

  " Remap 'p' to paste from system clipboard
  nnoremap p :let @"=substitute(system('wl-paste --no-newline'), '\r\|\n', '', 'g')<CR>p
endif


" Split windows
set splitright         " split vertical window to the right
set splitbelow         " split horizontal window to the bottom

" Turn off swapfile
set noswapfile

" colorscheme
colorscheme sorbet

" syntax
syntax on
