scriptencoding utf-8

let s:use_vim_plug = 1
let s:is_windows = has('win32') || has('win64')
let s:is_macos = has('mac')
let s:is_other_nix = has('unix')

"---------------------------------------------------------------------------
" .gvimrc
"---------------------------------------------------------------------------
set background=dark

if s:is_macos
  " opacity
"  set transparency=30
  set guifont=Cascadia_Mono:h13
  set columns=160
  set lines=100
elseif s:is_windows
  if s:use_vim_plug
    colorscheme gruvbox
  else
    colorscheme gruvbox_fallback
  endif

  " 半角文字のフォント設定
  set guifont=Consolas:h10

  " 全角文字のフォント設定
  " encoding=utf-8 かつ guifontset が空または Invalid の時のみ有効
  set guifontwide=MS_Gothic:h10

  " Avoid to slow move cursor
"  set renderoptions=type:directx

  set columns=120
  set lines=100
elseif s:is_other_nix
endif
set nomousefocus    " マウス移動によるフォーカス切り替えを無効
set guioptions-=T   " Hide toolbar
