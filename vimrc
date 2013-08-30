set encoding=utf-8
call pathogen#infect()
call pathogen#helptags()
syntax on " Enable syntax highlighting
colorscheme tutticolori
set t_Co=256
highlight clear Search
highlight Search cterm=reverse
highlight IncSearch ctermfg=black
filetype plugin indent on " Enable filetype-specific indenting and plugins

" ruby: autoindent with two spaces, always expand tabs
autocmd FileType ruby,eruby,yaml set sw=2 sts=2 et
" recognize special ruby files
autocmd BufRead,BufNewFile Capfile set filetype=ruby
" recognize .md as markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd FileType markdown setl wrap linebreak nolist
" modify keyword pattern in SASS documents
autocmd FileType sass setl iskeyword+=-

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
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
" Disabled for now because it seems to suspend vim with some commands
" set shellcmdflag=-ic " Use interactive shell within vim (enables zsh aliases and functions)
set whichwrap+=<,>,h,l,[,] " let cursor keys wrap around lines
set hlsearch " highlight search matches
set mouse=a " use mouse if enabled
set clipboard=unnamed " use Mac clipboard for yank/paste/etc.
set pumheight=15 " Limit completion popup menu height
set shell=bash " Seems to be necessary to get Rails.vim to use the correct version of Ruby

" Ignore various files in open
" Images
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.ico,*.psd,*.pdf
" Other binaries
set wildignore+=*.sqlite3,*.ipa
" Xcode stuff
set wildignore+=*.xcodeproj/*,*.xib,*.cer,*.icns
" Misc temp stuff
set wildignore+=*.pid,*/tmp/*
" vendor dir in Rails projects
set wildignore+=*/vendor/*
" node modules dir
set wildignore+=*/node_modules/*

" show tabs and nbsp
set list listchars=tab:» ,nbsp:•
highlight SpecialKey ctermfg=grey guifg=grey

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen ctermfg=grey guifg=grey
match ExtraWhitespace /\s\+$/

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

" Search in project/directory
nnoremap <leader>/ :Ag<Space>

" Search current word in project/directory
" With or without word boundaries
function SearchInProject()
  let word = expand("<cword>")
  let @/=word
  set hls
  exec "Ag " . word
endfunction

function SearchWordInProject()
  let word = expand("<cword>")
  let @/='\<' . word . '\>'
  set hls
  exec "Ag '\\b" . word . "\\b'"
endfunction

nnoremap <leader>f :call SearchInProject()<CR>
nnoremap <leader>F :call SearchWordInProject()<CR>

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

nnoremap :Q :qall

" refresh command-t cache every time
map <leader>t :CommandTFlush<cr>\|:CommandT<cr>
" Let ESC close command-t (and then remap arrows for navigation)
let g:CommandTCancelMap = ['<ESC>', '<C-c>']
let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<ESC>OB']
let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<ESC>OA']

" Type C-A after some math to calculate the result
ino <C-A> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" powerline config
let g:Powerline_symbols = 'fancy'

function LocalSettings()
  let localconfig = $HOME . '/.vimrc.local'
  if filereadable(localconfig)
    so `=localconfig`
  endif
endfunction
call LocalSettings()
