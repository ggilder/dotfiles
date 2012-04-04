call pathogen#infect()
call pathogen#helptags()
syntax on " Enable syntax highlighting
colorscheme tutticolori
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
set linebreak " if wrap is turned on, break lines at whitespace
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
" Disabled for now because it seems to suspend vim with some commands
" set shellcmdflag=-ic " Use interactive shell within vim (enables zsh aliases and functions)
set whichwrap+=<,>,h,l,[,] " let cursor keys wrap around lines
set hlsearch " highlight search matches
set mouse=a " use mouse if enabled

" Minimum window sizes
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

" Press Space to toggle highlighting on/off, and show current value.
nnoremap <Space> :set hlsearch! hlsearch?<CR>

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%
map <leader>s :split %%

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Windows and splits
" Open new vertical split
nnoremap <leader>w <C-w>v<C-w>l
" navigate splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" close window
nnoremap <C-x> <C-w>q

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
