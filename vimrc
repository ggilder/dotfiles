set encoding=utf-8

call plug#begin('~/.vim/bundle')
Plug 'AndrewRadev/splitjoin.vim'
Plug 'benekastah/neomake'
Plug 'benmills/vimux'
Plug 'bling/vim-airline'
Plug 'bogado/file-line'
Plug 'briancollins/vim-jst'
Plug 'bronson/vim-trailing-whitespace'
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekwyatt/vim-scala'
Plug 'elixir-lang/vim-elixir'
Plug 'fatih/vim-go'
Plug 'ggilder/localvimrc'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'lmeijvogel/vim-yaml-helper'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nono/vim-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'ruanyl/vim-gh-line'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'sebdah/vim-delve'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'uarun/vim-protobuf'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/VimClojure'
Plug 'vim-scripts/greplace.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'github/copilot.vim'
Plug 'djoshea/vim-autoread'
call plug#end()

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
" go file formatting
autocmd FileType go setl sw=4 ts=4 noet nolist
" auto fix go imports on save
let g:go_imports_autosave = 1
" php file formatting
autocmd FileType php setl sw=4 ts=4 et nolist

" protos
autocmd FileType proto setl sw=4 ts=4 noet
" yaml, coffee folding
autocmd FileType yaml,coffee setl foldmethod=expr foldexpr=(getline(v:lnum)=~'^$')?-1:((indent(v:lnum)<indent(v:lnum+1))?('>'.indent(v:lnum+1)):indent(v:lnum))
autocmd FileType yaml,coffee normal zR
" json folding - this is quite slow with files above a few hundred kb though
autocmd FileType json setl foldmethod=syntax
autocmd FileType json normal zR

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
set nowrapscan " do not wrap around when hitting n / N
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
set nojoinspaces " Don't put 2 spaces after periods when joining lines with J or gq
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

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

set wildmenu

" show tabs and nbsp
set list listchars=tab:» ,nbsp:•
highlight SpecialKey ctermfg=grey guifg=grey

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen ctermfg=grey guifg=grey
match ExtraWhitespace /\s\+$/

" Minimum window sizes
set winwidth=84

" grep settings for Greplace, etc
set grepprg=rg\ --vimgrep
let g:ackprg='rg --vimgrep'

vnoremap < <gv
vnoremap > >gv

"""" SPECIAL KEYS

" don't yank existing selection when pasting in visual mode
vnoremap p "_dP

" SELECTION KEYS
" highlight last inserted text
nnoremap gV `[v`]

" CONTROL KEYS
" control-s to write file in insert mode
inoremap <C-s> <C-o>:w<CR>
" close window
nnoremap <C-x> <C-w>q
" Type C-A after some math to calculate the result
ino <C-A> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" LEADER KEYS
" leader-s to write file
nnoremap <leader>s :w<CR>
" leader-a to toggle highlighting on/off, and show current value.
nnoremap <leader>a :set hlsearch! hlsearch?<CR>
" leader-c to toggle cursor line
nnoremap <leader>c :set cursorcolumn! cursorline!<CR>
" Switch between the last two files
nnoremap <leader><leader> <c-^>
" Open new vertical split
nnoremap <leader>v <C-w>v<C-w>l
" Toggle invisible characters
nnoremap <leader><tab> :set nolist!<CR>
" Navigate tabs
nnoremap <leader>h gT
nnoremap <leader>l gt

" Load FZF
set rtp+=/usr/local/opt/fzf
set rtp+=/opt/homebrew/opt/fzf
" Leader-t for FZF
nnoremap <leader>t :FZF<cr>
" Leader-d for FZF in same directory
nnoremap <leader>d :FZF <C-R>=expand('%:h').'/'<cr><cr>

" Open files from FZF in new tab by default
let g:fzf_action = { 'enter': 'tab split' }

" Search in project/directory
nnoremap <leader>/ :Ack!<Space>
" Search current word in project/directory
" With or without word boundaries
function SearchInProject()
  let word = expand("<cword>")
  let @/=word
  set hls
  exec "Ack! " . word
endfunction

function SearchWordInProject()
  let word = expand("<cword>")
  let @/='\<' . word . '\>'
  set hls
  exec "Ack! '\\b" . word . "\\b'"
endfunction

nnoremap <leader>f :call SearchInProject()<CR>
nnoremap <leader>F :call SearchWordInProject()<CR>

function CopyCurrentFileAndLine()
  call system('echo -n ' . expand('%') . ':' . line('.') . ' | pbcopy')
endfunction

function CopyCurrentFile()
  call system('echo -n ' . expand('%') . ' | pbcopy')
endfunction

nnoremap <leader>r :call CopyCurrentFile()<CR>
nnoremap <leader>R :call CopyCurrentFileAndLine()<CR>

" CoC config/shortcuts
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation
nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming
nnoremap <leader>rn <Plug>(coc-rename)
" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Command-mode expansion for directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
" :Q to quit all open buffers
nnoremap :Q :qall

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#show_coc_status = 1

" syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': ['java', 'sass', 'cucumber'] }

function LocalSettings()
  let localconfig = $HOME . '/.vimrc.local'
  if filereadable(localconfig)
    so `=localconfig`
  endif
endfunction
call LocalSettings()

" Go Settings
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" CamelCaseMotion
let g:camelcasemotion_key = '<leader>'
