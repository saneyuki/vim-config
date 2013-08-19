"---------------------------------------------------------------------------
" .vimrc
"---------------------------------------------------------------------------

" vim
set nocompatible

"---------------------------------------------------------------------------
" Common
"

" set runtime path for windows.
if has('win32') || has('win64')
  set runtimepath+=$HOME/.vim,$HOME/.vim/after
endif

" カラースキームの設定
"colorscheme straight

" 背景色の傾向(カラースキームがそれに併せて色の明暗を変えてくれる)
"set background=light

" Enable mouse support.
set mouse=a

"---------------------------------------------------------------------------
" File
"

" 更新時自動再読込みしない
set noautoread

" 編集中でも他のファイルを開けるようにする
set hidden

" スワップファイルを作らない
set noswapfile

" バックアップを取らない
set nobackup

" 保存時に行末の空白を除去する
"autocmd BufWritePre * :%s/\s\+$//ge

" シンタックスカラーリングオン
syntax enable

" ファイルブラウザの初期ディレクトリ
set browsedir=buffer

" モードラインを有効にする
set modeline


"---------------------------------------------------------------------------
" Indent
"

" Tab文字を画面上で展開する文字数
set tabstop=2

" Tabキー入力時に挿入される空白の量，0の場合はtabstopと同じ
set softtabstop=0

" 自動インデントに使われる空白の幅
set shiftwidth=2

" 入力したTab文字を半角スペースとして入力する
set expandtab

" 自動でインデント
set autoindent

" '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set shiftround

" 新しい行のインデントを現在行と同じ量に
set smartindent


"---------------------------------------------------------------------------
" Assist imputting
"

" バックスペースで特殊記号も削除可能に
set backspace=indent,eol,start

" 整形オプション，マルチバイト系を追加
"set formatoptions=lmoq

" 行をまたいでカーソルを移動できるようにする
set whichwrap=b,s,h,s,<,>,[,]

" 無名レジスタに入るデータを, *レジスタにも入れる (OSのクリップボードも利用)
set clipboard+=unnamed

" 挿入モードでの単語補完時に大文字小文字を無視する
"set infercase

" カーソルを表示行で移動する。物理行移動は<C-n>,<C-p>
"nnoremap j gj
"nnoremap k gk
"nnoremap <Down> gj
"nnoremap <Up>   gk


"---------------------------------------------------------------------------
" Complement Command
"

" コマンド補完を強化
set wildmenu

" コマンド補完モードの設定
set wildmode=longest:full


"---------------------------------------------------------------------------
" Search
"

" 最後まで検索したら先頭へ戻る
set wrapscan

" 大文字小文字無視
set ignorecase

" 大文字ではじめたら大文字小文字無視しない
set smartcase

" インクリメンタルサーチ
set incsearch

" 検索文字をハイライト
set hlsearch

" 正規表現のメタ文字の扱いを常に'very magic'にする
" （メタ文字を常にエスケープ不要にする）
"nnoremap / /\v

"---------------------------------------------------------------------------
" View
"

" 括弧の対応をハイライト
set showmatch

" 入力中のコマンドを表示
set showcmd

" 現在のモードを表示
set showmode

" 行番号表示
set number

" 画面幅で折り返さない
set nowrap

" 不可視文字表示
set list

" 不可視文字の表示方法
set listchars=tab:>\ ,trail:-

" タイトル書き換えない
"set notitle

" 行送り
set scrolloff=5

" 印字不可能文字を16進数で表示
"set display=uhex

" カーソル行をハイライト
set cursorline

" カーソル列をハイライト
"set cursorcolumn

" カレントウィンドウのみカーソル行をハイライト
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" 矩形選択で自由に移動する
set virtualedit=block


"---------------------------------------------------------------------------
" StatusLine
"
" ステータスラインを常に表示
set laststatus=2

set statusline=%<%f\ #%n%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P


"---------------------------------------------------------------------------
" Charset, Line ending
"

"端末への出力に使用されるエンコーディング
if has('win32') || has('win64')
  set termencoding=cp932
else
  set termencoding=utf-8
endif

" Vimが内部で使用するエンコーディング
" fileencodings がすべて失敗した場合のデフォルト
set encoding=utf-8

" Vim がファイルを開く際に先頭から適用する
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp

" 改行文字: LF, CRLF, CR
set ffs=unix,dos,mac

set ambiwidth=double

" 挿入モード時にステータスラインの色を変更する
let g:hi_insert = 'hi StatusLine gui=None guifg=Black guibg=Yellow cterm=None ctermfg=Black ctermbg=Yellow'
if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction
function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction



"---------------------------------------------------------------------------
" Plugins
"
let s:canUseLua = has('lua')

"----------------
" neobundle.vim
"
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle/neobundle.vim

  call neobundle#rc(expand('~/.vim/neobundle'))
endif

NeoBundleFetch 'https://github.com/Shougo/neobundle.vim.git'
if s:canUseLua
  NeoBundle 'https://github.com/Shougo/neocomplete.vim.git'
endif

NeoBundleLazy 'https://github.com/mattn/emmet-vim.git', {
  \ "autoload": {"filetypes": ['html', 'xhtml']}}
NeoBundleLazy 'https://github.com/othree/html5.vim.git', {
  \ "autoload": {"filetypes": ['html', 'xhtml']}}

filetype plugin on
filetype indent on


"----------------
" zencoding.vim
"

" インデントの調節
let g:user_emmet_settings = { 'indentation':'  ' }


"----------------
" neocomplcache
"

if s:canUseLua
  " neocomplete を起動時に有効化する
  let g:neocomplete#enable_at_startup = 1

  " smartcase 機能を有効化する
  let g:neocomplete#enable_smart_case = 1
endif
