let optional = []
let optional += ["nerdtree"]
let optional += ["autoclose"]
let optional += ["vim-endwise"]
let optional += ["tabular"]
call OptionalBundles#Include(optional)

if v:version >= 703
  set nonumber
  " set relativenumber
  " set undofile
endif
set autoread
set nu
set directory=~/tmp

:set guifont=Menlo:h14

" Status line. mostly stolen from A Byte of Vim
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%{fugitive#statusline()}     " git branch
set statusline+=%=                           " right align remainder
" set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position

set encoding=utf-8
"set scrolloff
" let g:solarized_termcolors=16
" colorscheme solarized

" Run the current file. Uses .vim/ruby/run_file_in_terminal.rb
noremap <leader>r :RunFileInTerminal<cr>
noremap <leader>R :RunFileAtLineInTerminal<cr>
map <leader><C-r> :let g:vim_terminal="/dev/ttys000"
noremap <leader>rr :ReRunLastFileCommand<cr>

set visualbell

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Get the 's' key back
xmap <Leader>s <Plug>Vsurround

" ~/snip is a junk file; call it a customized clipboard
" Write to snip.  Either uses current visual selection, or entire buffer
noremap  \ws :w! ~/snip<cr>
" Read contents of snip into current buffer
noremap  \rs :r ~/snip<cr>
" Edit the snip file
noremap  \es :e ~/snip<cr>
" Append to the snip file
noremap  \as :w! >> ~/snip<cr>

" Camel-hump case boundary detection - Change up to next boundary
map ,w cv/[a-z][A-Z^\n^ ^\t^(^[^.^_]<CR>

" nnoremap / /\v
" vnoremap / /\v
set incsearch
set showmatch
" set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %


" Show invisibles same as TextMate
set list
set listchars=tab:▸\ ,trail:·
" set listchars=tab:▸\ ,eol:¬,trail:·


nnoremap j gj
nnoremap k gk

" Save when focus is lost
au FocusLost * :wa

" inoremap jj <ESC>

nnoremap <leader>n :NERDTreeToggle<cr>

autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=model()

let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}' }
let g:AutoCloseProtectedRegions = ["Character", "Comment"]

" F12 removes trailing whitespace
nnoremap <silent> <F12> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>

" Cucumber table formatting
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
