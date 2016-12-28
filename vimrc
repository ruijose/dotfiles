set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/Vundle.vim'

Bundle 'kien/ctrlp.vim'
Bundle 'junegunn/goyo.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'janko-m/vim-test'
Bundle 'kchmck/vim-coffee-script'
Bundle 'altercation/vim-colors-solarized'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-vinegar'
Bundle 'thoughtbot/vim-rspec'
Bundle 'vim-ruby/vim-ruby'

call vundle#end()
filetype plugin indent on

syntax on

set showmode
set relativenumber
set ruler
set tabstop=2
set shiftwidth=2
set expandtab
set incsearch
set smartcase
set ignorecase
set hlsearch
set visualbell
set nobackup
set nowritebackup
set noswapfile
set list
set encoding=utf-8
set listchars=tab:›\.,trail:.,extends:#,nbsp:.
set autoindent
set wildmenu
set autoread
set splitright
set splitbelow

set notimeout
set ttimeout
set ttimeoutlen=10

let mapleader=','
set background=dark
colorscheme gruvbox

imap jk <ESC>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

nnoremap <leader>w  :w<cr>
nnoremap <leader>q  :wq<cr>
nnoremap <leader>fq :q!<cr>

" insert pry breakpoint
map ,p <CR>irequire 'pry-byebug'; binding.pry<CR><ESC>

nnoremap <leader><leader> : :nohlsearch<cr>

nnoremap <leader>ve :vsp $MYVIMRC<CR>
nnoremap <leader>vr :source ~/.vimrc<CR>

" Running tests
nnoremap <silent> <leader>t :TestFile<CR>
nnoremap <silent> <leader>a :TestSuite<CR>
nnoremap <silent> <leader>l :TestLast<CR>
nnoremap <silent> <leader>g :TestVisit<CR>

setlocal spell spelllang=en_us
autocmd BufRead,BufNewFile *.tex setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell

" Search and replace on current file
nnoremap <Leader>ss :%s/\<<C-r><C-w>\>//g<Left><Left>

" Open schema.rb (rails)
nnoremap <Leader>sc :sp db/schema.rb<cr>

" List rails app controllers
nnoremap <leader>co :vsp app/controllers<cr>

" Open rails routes.rb
nnoremap <leader>ro :vsp config/routes.rb<cr>

" Search all files
nnoremap <Leader>fina :!git grep<space>

" Search current file
nnoremap <Leader>fin :!git grep   %<left><left><left>

nnoremap <C-f> /
nnoremap <C-h> B
nnoremap <C-l> W

" long lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap Y y$
nnoremap ºº $
nnoremap qq  _

" format an entire file
nnoremap <leader>fef ggVG=

" Do not show that stupid window
map q: :q
map ? *

" Remove all whitespaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

map <leader>dw :tabnext<cr>

" Open current split as a new tab
map <leader>er <C-W>T<cr>

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let g:ctrlp_working_path_mode = '0'

" go configs
autocmd FileType go set nolist

autocmd Filetype java setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype go setlocal ts=4 sw=4 sts=0 expandtab
au BufRead,BufNewFile *.go set filetype=go

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class
set wildignore+=*.DS_Store                        " OSX bullshit
set wildignore+=*.pyc                             " Python byte code
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg    " Images
set wildignore+=.hg,.git,.svn                     " Version control stuff
set wildignore+=go/pkg                            " Go static files
set wildignore+=go/bin                            " Go bin files

" Merge a tab into a split in the previous window (thanks Ben Orenstein)
function! MergeTabs()
  if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif
  split
  execute "buffer " . bufferName
endfunction

nmap <leader>mm :call MergeTabs()<CR>

" Rename current file (thanks Gary Bernhardt)
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

map <Leader>ren :call RenameFile()<cr>
