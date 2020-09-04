scriptencoding utf-8

let s:use_vim_plug = 1
let s:is_neo_vim = has('nvim')
let s:is_windows = has('win32') || has('win64')
let s:is_macos = has('mac')


"---------------------------------------------------------------------------
" .vimrc
"---------------------------------------------------------------------------

" vim
if !s:is_neo_vim
  if v:version < 800
    set nocompatible " This is used for ~v7.
  else
    source $VIMRUNTIME/defaults.vim " defaults.vim call `set nocompatible`.
  endif
endif

"---------------------------------------------------------------------------
" Common
"

" カラースキームの設定
if !s:use_vim_plug
  set background=dark
  colorscheme gruvbox_fallback
endif

" Enable mouse support.
set mouse=a

" This option is set on neovim by default
" set history=10000

" Enabled by default on neovim https://neovim.io/doc/user/vim_diff.html
set belloff=all
set tabpagemax=50


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

  " Don't create ~/.viminfo
" This is deprecated on neovim https://neovim.io/doc/user/deprecated.html
if !s:is_neo_vim
  "set viminfo=
endif

" Enabled by default on neovim https://neovim.io/doc/user/vim_diff.html
syntax enable

" ファイルブラウザの初期ディレクトリ
set browsedir=buffer

" モードラインを有効にする
set modeline

" Disabled by default on neovim https://neovim.io/doc/user/vim_diff.html
if !s:is_neo_vim
  set nofsync
endif

" Enabled by default on neovim https://neovim.io/doc/user/vim_diff.html
set shortmess=filnxtToOF
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize


"---------------------------------------------------------------------------
" Indent
"

" Tab文字を画面上で展開する文字数
set tabstop=4

" Tabキー入力時に挿入される空白の量，0の場合はtabstopと同じ
set softtabstop=0

" 自動インデントに使われる空白の幅
set shiftwidth=4

" 入力したTab文字を半角スペースとして入力する
set expandtab

" 自動でインデント
" Enabled by default with neovim https://neovim.io/doc/user/vim_diff.html
set autoindent

" '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set shiftround

" 新しい行のインデントを現在行と同じ量に
set smartindent

" Enabled by default with neovim https://neovim.io/doc/user/vim_diff.html
set smarttab


"---------------------------------------------------------------------------
" Assist Input
"

" バックスペースで特殊記号も削除可能に
set backspace=indent,eol,start

" Sort with neovim default
set formatoptions=tcqj
set nrformats=bin,hex


" 行をまたいでカーソルを移動できるようにする
set whichwrap=b,s,h,s,<,>,[,]

" 無名レジスタに入るデータを, クリップボードレジスタに入れる
set clipboard& " see `help set-default`
set clipboard^=unnamed,unnamedplus

" 挿入モードでの単語補完時に大文字小文字を無視する
"set infercase

" 対応する括弧の表示に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" insert modeもhjklでカーソル移動できるようにremap
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Enabled by default on neovim https://neovim.io/doc/user/vim_diff.html
set nolangremap
set fillchars=


"---------------------------------------------------------------------------
" Complement Command
"

" コマンド補完を強化
" Enabled by default with neovim https://neovim.io/doc/user/vim_diff.html
set wildmenu

" コマンド補完モードの設定
set wildmode=longest:full

" Enabled by default on neovim https://neovim.io/doc/user/vim_diff.html
set tags=./tags;,tags
set complete=.,w,b,u,t


"---------------------------------------------------------------------------
" Terminal
"

" if s:is_neo_vim || v:version >= 801
" endif

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
" Enabled by default with neovim https://neovim.io/doc/user/vim_diff.html
set incsearch

" 検索文字をハイライト
" Enabled by default with neovim https://neovim.io/doc/user/vim_diff.html
set hlsearch

if s:is_neo_vim
  set inccommand=split
endif

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

set ruler

" 画面幅で折り返さない
set nowrap

" 折り返した分もインデントする
set breakindent

" 自動で折り返しする1行あたりのテキスト量 (0で無効化)
" ( ref. http://vim-users.jp/2011/05/hack217/ )
"set textwidth=0
" n列目にラインを表示
"set colorcolumn=80

" 不可視文字表示
set list

" 不可視文字の表示方法
set listchars=tab:>\ ,trail:-,nbsp:+

" タイトル書き換えない
"set notitle

" 行送り
set scrolloff=5

" 印字不可能文字を16進数で表示
if s:is_neo_vim
  " the default value of neovim
  set display=lastline,msgsep,uhex
else
  " vim 8 does not support `msgsep`
  set display=lastline,uhex
endif

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

" Disable 'add eol if there is no eol'.
set nofixeol

" Enabled by default on neovim https://neovim.io/doc/user/vim_diff.html
set sidescroll=1


"---------------------------------------------------------------------------
" StatusLine
"
" ステータスラインを常に表示
" Enabled by default with neovim https://neovim.io/doc/user/vim_diff.html
set laststatus=2

set statusline=%<%f\ #%n%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P

"---------------------------------------------------------------------------
" Charset, Line ending
"

"端末への出力に使用されるエンコーディング
if s:is_windows
  set termencoding=cp932
else
  set termencoding=utf-8
endif

" Vimが内部で使用するエンコーディング
" fileencodings がすべて失敗した場合のデフォルト
if !s:is_neo_vim
  " This option is always utf-8 on neovim
  set encoding=utf-8
endif

" Vim がファイルを開く際に先頭から適用する
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp

" 改行文字: LF, CRLF, CR
set ffs=unix,dos,mac

set ambiwidth=double


"---------------------------------------------------------------------------
" Plugins
"
if s:use_vim_plug && v:version >= 800
  let s:can_use_lua = has('lua')
  let s:has_python_3 = has('python3')

  if s:is_neo_vim
    " https://neovim.io/doc/user/starting.html#xdg
    let s:config_dir = stdpath('config')
    let s:data_dir = stdpath('data')
  else
    let s:rc_dir = s:is_windows ?
      \ expand('~/vimfiles') :
      \ expand('~/.vim')
  endif

  "----------------
  " [vim-plug](https://github.com/junegunn/vim-plug)
  "
  let s:vim_plug_dir = s:is_neo_vim ?
    \ expand(s:data_dir . '/plugged') :
    \ expand(s:rc_dir . '/plugged')
  call plug#begin(s:vim_plug_dir)
    " Color Scheme
    Plug 'morhetz/gruvbox'

    Plug 'editorconfig/editorconfig-vim'

"    Plug 'othree/html5.vim', { 'for': ['html', 'xhtml'] }
"    Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
    Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
"    Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
    Plug 'bfrg/vim-cpp-modern', { 'for': ['c', 'cpp'] }
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'cespare/vim-toml', { 'for': 'toml' }

"    Plug 'kshenoy/vim-signature'

    " https://github.com/machakann/vim-highlightedyank
    Plug 'machakann/vim-highlightedyank'

    " https://github.com/junegunn/vim-peekaboo
    " Plug 'junegunn/vim-peekaboo'

    " https://github.com/mbbill/undotree
    " Plug 'mbbill/undotree'

    " TODO:
    " if (v:version >= 801) || s:is_neo_vim
    " https://github.com/neoclide/coc.nvim
    " Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install()} }
    " endif

    " TODO: https://github.com/Valloric/YouCompleteMe

    " https://github.com/junegunn/fzf.vim
    let s:use_fzf_vim = 1
    if !s:is_windows && s:use_fzf_vim && isdirectory('/usr/local/opt/fzf')
      " For installing fzf via homebrew
      Plug '/usr/local/opt/fzf'
      Plug 'junegunn/fzf.vim'
    endif

  call plug#end()


  "----------------
  " gruvbox
  "
  " Enabled by default with neovim https://neovim.io/doc/user/vim_diff.html
  set background=dark
  colorscheme gruvbox


  "----------------
  " EditorConfig

  "----------------
  " rust.vim
  "

  " Enable rustfmt on save.
  "let g:rustfmt_autosave = 1


  "----------------
  " vim-go
  "

  " syntax highlighting
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_generate_tags = 1


  "---------------
  " vim-cpp-modern

  let g:cpp_no_function_highlight = 1
  "let g:cpp_simple_highlight = 1
  let g:cpp_named_requirements_highlight = 1


  "---------------
  " fzf

  " Customize fzf colors to match your color scheme
  let g:fzf_colors =
        \ {
        \ 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment']
        \ }
endif
