call pathogen#infect()
call pathogen#helptags()
syntax on " Enable syntax highlighting
if &term == 'xterm-256color'
  set background=light
  colorscheme solarized
endif
filetype plugin indent on " Enable filetype-specific indenting and plugins

" ruby: autoindent with two spaces, always expand tabs
autocmd FileType ruby,eruby,yaml set sw=2 sts=2 et

let mapleader = ","

set nocompatible
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500 " keep 500 lines of command line history
set autoindent
set ruler
set nowrap
set noswapfile
set nobackup
set guioptions-=T
set et " expand tabs
set sw=2
set smarttab
set incsearch " highlight search term incrementally
set ignorecase smartcase
set laststatus=2 " Always show status line.
set number 
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set hidden " allow hidden unsaved buffers
set grepprg=ack " Use Ack instead of grep
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set shellcmdflag=-ic " Use interactive shell within vim (enables zsh aliases and functions)

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" refresh command-t cache when files are written or when vim gains focus
augroup CommandTExtension
  autocmd!
  autocmd FocusGained * CommandTFlush
  autocmd BufWritePost * CommandTFlush
augroup END

" Type C-A after some math to calculate the result
ino <C-A> <C-O>yiW<End>=<C-R>=<C-R>0<CR>
