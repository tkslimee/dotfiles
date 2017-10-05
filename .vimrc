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

if (has("win32unix") || has("mac") || has("unix"))
set listchars=tab:»-,extends:»,precedes:«,nbsp:%,eol:↲
endif

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

" 開いているファイルのパスに自動的に移動
set autochdir

"クリップボードにコピー
set clipboard=unnamed,autoselect

"bash on windows用設定
"nnoremap <silent> <Space>y :.w !wrun win32yank.exe -i<CR><CR>
"vnoremap <silent> <Space>y :w !wrun win32yank.exe -i<CR><CR>
"nnoremap <silent> <Space>p :r !wrun win32yank.exe -o<CR>
"vnoremap <silent> <Space>p :r !wrun win32yank.exe -o<CR>

"mintty用
"let &t_ti.="\e[1 q"
"let &t_SI.="\e[5 q"
"let &t_EI.="\e[1 q"
"let &t_te.="\e[0 q"

"文字コード変更"
set encoding=utf-8

"ウィンドウ移動
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
"タブ移動
noremap <S-l> gt
noremap <S-h> gT

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

"""
" Dein TOML
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~\.cache\dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '\repos\github.com\Shougo\dein.vim'
" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    "execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
    execute 'set runtimepath^=' . s:dein_repo_dir
endif
" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vimfiles/rc')      "ここも .vim → vimfiles に変えた
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  " 設定終了
  call dein#end()
  call dein#save_state()
endif
" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

"" markdown設定
" .mdのファイルもfiletypeがmarkdownとなるようにする
au BufRead,BufNewFile *.md set filetype=markdown
" markdownの折りたたみなし
let g:vim_markdown_folding_disabled=1

"" vim-template
""<+CURSOR+> にカーソルを移動する
autocmd User plugin-template-loaded
\    if search('<+CURSOR+>')
\  |   execute 'normal! "_da>'
\  | endif

""vimfiler用設定
set modifiable
set write
nnoremap <silent> ,f :<C-u>VimFiler<CR>
nnoremap <silent> ,fa :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> ,fb :<C-u>Unite bookmark<CR>
"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0
"現在開いているバッファのディレクトリを開く
nnoremap <silent> ,fe :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <silent> ,fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
"自動でカレントディレクトリを変更
let g:vimfiler_enable_auto_cd = 1
"eで新規タブで開く(winのみ)
if (has("win64"))
let g:vimfiler_edit_action = 'tabopen'
endif

""unite用設定
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep検索
nnoremap <silent> ,gc :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
" grep検索結果の再呼出
nnoremap <silent> ,gr  :<C-u>UniteResume search-buffer<CR>

" uniteからブックマークで移動するときにvimfilerで開くようにする
autocmd FileType vimfiler call unite#custom_default_action('directory', 'lcd')

""color
set t_Co=256
syntax enable
set background=dark
colorscheme solarized
"colorscheme hybrid

""unファイルを一箇所にまとめる
set undodir=~/.vim_undo
