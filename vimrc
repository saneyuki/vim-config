scriptencoding utf-8

"---------------------------------------------------------------------------
" .vimrc
"---------------------------------------------------------------------------

" vim
set nocompatible

"---------------------------------------------------------------------------
" Common
"

" カラースキームの設定
" 256色出せる端末を使っている環境だけ有効にする
if has('mac')
  colorscheme desert256s
endif

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

" undoファイルを作らない
set noundofile

" バックアップを取らない
set nobackup

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
" Assist Input
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

" 対応する括弧の表示に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" insert modeもhjklでカーソル移動できるようにremap
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>


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

" 自動で折り返しする1行あたりのテキスト量 (0で無効化)
" ( ref. http://vim-users.jp/2011/05/hack217/ )
"set textwidth=0
" n列目にラインを表示
"set colorcolumn=80

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

" 挿入モード時にステータスラインの色を変更する
let s:hi_insert = 'highlight StatusLine gui=None guifg=Black guibg=Yellow cterm=None ctermfg=Black ctermbg=Yellow'
let s:slhlcmd = ''

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:statusLine('Enter')
    autocmd InsertLeave * call s:statusLine('Leave')
    autocmd ColorScheme * call s:initHighlight()
  augroup END
endif

function! s:statusLine(mode)
  if a:mode == 'Enter'
    silent exec s:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:initHighlight()
  silent! let s:slhlcmd = 'highlight ' . s:getHighlight('StatusLine')
endfunction

function! s:getHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" get initial color scheme.
call s:initHighlight()


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


"---------------------------------------------------------------------------
" Plugins
"

let s:use_dein = 1
if s:use_dein && v:version >= 704

  let s:canUseLua = has('lua')
  let s:isWin = has('win32') || has('win64')
  let s:rc_dir = s:isWin ?
    \ expand('~/vimfiles') :
    \ expand('~/.vim')

  "----------------
  " dein.vim
  "

  filetype off

  let s:dein_dir = expand(s:rc_dir . '/dein')

  " dein source file
  let s:dein_repo_dir = expand(s:dein_dir . '/repos/github.com/Shougo/dein.vim')

  if has('vim_starting')
    " If there are no dein, download from github.
    if &runtimepath !~# '/dein.vim'
      if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
      endif
      execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
    endif
  endif

  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    call dein#add('Shougo/dein.vim')
    call dein#add('editorconfig/editorconfig-vim')

    if s:canUseLua && !has('nvim')
      call dein#add('Shougo/neocomplete.vim', {
        \ 'on_event': ['InsertEnter'],
        \ 'lazy': 1})
    endif

    if has('nvim')
      call dein#add('Shougo/deoplete.nvim', {
        \ 'on_event': ['InsertEnter'],
        \ 'lazy': 1})
    endif

    call dein#add('othree/html5.vim', {
      \ 'on_ft': ['html', 'xhtml'],
      \ 'lazy': 1})
    call dein#add('mattn/emmet-vim', {
      \ 'on_ft': ['html', 'xhtml'],
      \ 'lazy': 1})
    call dein#add('hail2u/vim-css3-syntax', {
      \ 'on_ft': ['css', 'scss'],
      \ 'lazy': 1})
    call dein#add('leafgarland/typescript-vim', {
      \ 'on_ft': ['typescript'],
      \ 'lazy': 1})
    call dein#add('fatih/vim-go', {
      \ 'on_ft': ['go'],
      \ 'lazy': 1})
    call dein#add('rust-lang/rust.vim', {
      \ 'on_ft': ['rust'],
      \ 'lazy': 1})
    call dein#add('racer-rust/vim-racer', {
      \ 'on_ft': ['rust'],
      \ 'lazy': 1})

    call dein#end()
    call dein#save_state()
  endif

  " If there are some packages which has not installed yet,
  " try to install
  if dein#check_install()
    call dein#install()
  endif

  filetype plugin indent on

  "----------------
  " EditorConfig

  if s:isWin
    let g:EditorConfig_exec_path = $HOME . '/bin/EditorConfig/bin/editorconfig.exe'
  endif


  "----------------
  " zencoding.vim
  "

  " インデントの調節
  let g:user_emmet_settings = { 'indentation':'  ' }


  "----------------
  " neocomplete
  "

  if s:canUseLua
    " neocomplete を起動時に有効化する
    "let g:neocomplete#enable_at_startup = 1

    " smartcase 機能を有効化する
    let g:neocomplete#enable_smart_case = 1
  endif

  "----------------
  " rust.vim
  "

  " Enable rustfmt on save.
  "let g:rustfmt_autosave = 1


  "----------------
  " Racer (Rust)
  "
  let g:racer_cmd = expand($RUST_RACER_PATH . '/target/release/racer')

  " 指定しない場合, pluginに指定されたpathから探す
  let $RUST_SRC_PATH = $RUST_SRC_PATH


  "----------------
  " vim-go
  "

  " syntax highlighting
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_interfaces = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
endif
