set encoding=utf-8
execute pathogen#infect()

" Enable syntax highlighting
syntax on

" set t_Co=256
set background=dark
colorscheme base16-railscasts

highlight clear Search
highlight Search cterm=reverse
highlight IncSearch ctermfg=black
highlight CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
highlight CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

let go_vim = $GOROOT . '/misc/vim'
if isdirectory(go_vim)
  " Clear filetype flags before changing runtimepath to force Vim to reload them.
  filetype off
  filetype plugin indent off
  set runtimepath+=$GOROOT/misc/vim
endif

" Enable filetype-specific indenting and plugins
filetype plugin indent on

" ruby: autoindent with two spaces, always expand tabs
autocmd FileType ruby,eruby,yaml set sw=2 sts=2 et
" recognize special ruby files
autocmd BufRead,BufNewFile Capfile set filetype=ruby
" recognize .md as markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd FileType markdown setl wrap linebreak nolist
autocmd FileType text setl wrap linebreak nolist
" modify keyword pattern in SASS documents
autocmd FileType sass setl iskeyword+=-
" format go files on save
autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd FileType go set sw=4 ts=4 noet
" protos
autocmd BufRead,BufNewFile *.proto set filetype=protobuf
autocmd FileType protobuf setl sw=4 ts=4 noet

let mapleader = "\<Space>"
nnoremap ; :

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
set omnifunc=syntaxcomplete#Complete " Enable omnicompletion
set ttimeoutlen=0 " Shorter key code delay to speed up entering normal mode with ESC
set modelines=1 " Use modlines at the end of the file

" Ignore various files in open
" Images
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.ico,*.psd,*.pdf
" Other binaries
set wildignore+=*.sqlite3,*.ipa
" Xcode stuff
set wildignore+=*.xcodeproj/*,*.xib,*.cer,*.icns
" Misc temp stuff
set wildignore+=*.pid,*/tmp/*
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
set winheight=20
set winminheight=20
set winheight=999

" grep settings for Greplace, etc
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

"""" SPECIAL KEYS

" SELECTION KEYS
" highlight last inserted text
nnoremap gV `[v`]

" CONTROL KEYS
" control-w to write file in insert mode
inoremap <C-w> <C-o>:w<CR>
" close window
nnoremap <C-x> <C-w>q
" Type C-A after some math to calculate the result
ino <C-A> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" LEADER KEYS
" leader-w to write file
nnoremap <leader>w :w<CR>
" leader-s to toggle highlighting on/off, and show current value.
nnoremap <leader>s :set hlsearch! hlsearch?<CR>
" leader-c to toggle cursor line
nnoremap <leader>c :set cursorcolumn! cursorline!<CR>
" Switch between the last two files
nnoremap <leader><leader> <c-^>
" Open new vertical split
nnoremap <leader>v <C-w>v<C-w>l

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>t :call SelectaCommand("find * -type f", "", ":e")<cr>

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

" Command-mode expansion for directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
" :Q to quit all open buffers
nnoremap :Q :qall

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" airline config
let g:airline_powerline_fonts = 1

function LocalSettings()
  let localconfig = $HOME . '/.vimrc.local'
  if filereadable(localconfig)
    so `=localconfig`
  endif
endfunction
call LocalSettings()
