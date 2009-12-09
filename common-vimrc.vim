:set guifont=Monaco:h12
:set guioptions-=T
let mapleader=","

set autoindent
set bs=2
set clipboard=unnamed
set expandtab
set grepformat=%f:%l:%m
set grepprg=ack
set hidden
set ignorecase
set incsearch
set nocompatible
set nohlsearch
set nowrap
set number
set ruler
set shiftwidth=2
set smartcase
set smartindent
set smarttab
set softtabstop=2
set tabstop=2
set wildmenu
set wildmode=longest,list,full

colorscheme vividchalk
syntax on
filetype on
filetype plugin on
compiler ruby

" Fix typos
cabbr W w
cabbr Q q
map <F1> <Esc>
imap <F1> <Esc>

" close the current buffer, doesn't close the window
noremap <leader>w :Bclose<cr>
" close the current window, doesn't close the buffer
noremap <leader>q :bd<cr>
noremap <leader>Q :close<cr>

" Find in cwd/"project"
noremap <leader>f :AckWithIgnore ''<Left>
noremap <leader>F :AckWithIgnore 

" Run the current file. Uses .vim/ruby/run_file.rb
noremap <leader>r :RunFile<cr>
noremap <leader>R :RunFileAtLine<cr>

" Textmate CMD-t emulation
map <leader>t :FufTaggedFile<CR>
map <leader>T :FufTag<CR>
map <leader><C-t> :RegenTags<CR>:FufRenewCache<CR>

" bring up buffer list. ,,<CR> switches to last used buffer
map <leader>, :FufBuffer<CR>

" like browse to a file with a convenient ,t-like interface
map <leader>e :FufFile<CR>

" comment out a line
map <leader>/ :TComment<Return>

" used to set the clipboard buffer to system clipboard. example use: ,cp to
" paste from clipboard
map <leader>c "*

" autocmd FileType ruby,eruby set omnifunc=rubycomplete ai sw=2 sts=2 et
if has("autocmd")
  filetype indent on
endif

" global variables that can be overridden or appended to in .vim in the cwd to
" customize stuff

" folders that should be ignored
let g:vim_ignore = ["vendor", "log"]
" extensions that should be included in tag files
let g:taggable_extensions = ['rb', 'feature', 'js', 'java', 'haml', 'erb']

" load .vim in the current directory if it exists
if filereadable(".vim")
  source .vim
endif

if exists('g:vim_ignore')
  if !exists('g:fuzzy_ignore')
    let g:fuzzy_ignore=join(map(copy(g:vim_ignore), 'v:val . "/**"'), ",")
  endif

  if !exists('g:ack_ignore')
    let g:ack_ignore=copy(g:vim_ignore)
  endif
endif

