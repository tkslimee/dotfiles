set ignorecase
set smartcase
set incsearch
set hlsearch

set shiftround
set infercase
set virtualedit=all
set hidden
set switchbuf=useopen
set showmatch
set matchtime=3

set backspace=indent,eol,start
set nowritebackup
set nobackup
set noswapfile

set number
set list
set wrap
set textwidth=0

set autoindent
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set formatoptions-=ro

noremap <C-l> gt
noremap <C-h> gT

nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

noremap <cr> o<esc>

noremap : ;
noremap ; :

imap <C-j> <esc>

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

noremap <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
noremap <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
noremap <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
noremap <silent> [Tag]p :tabprevious<CR>

set nocompatible " be iMproved
filetype off

if has('vim_starting')
set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
""originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/nerdtree'
""You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
NeoBundle 'plasticboy/vim-markdown'
call neobundle#end()

""NeoBundle 'https://bitbucket.org/kovisoft/slimv'
filetype plugin indent on " required!
filetype indent on

""color
set t_Co=256
syntax enable
""set background=dark
colorscheme hybrid
