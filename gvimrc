scriptencoding utf-8

let s:use_vim_plug = 1

"---------------------------------------------------------------------------
" .gvimrc
"---------------------------------------------------------------------------
set background=dark

if has("mac")
"  opacity
"  set transparency=30
  set guifont=Inconsolata:h14
  set columns=160
  set lines=100
elseif has('win32') || has('win64')
  if s:use_vim_plug
    colorscheme gruvbox
  else
    colorscheme desert256s
  endif

  "半角文字のフォント設定
  set guifont=Consolas:h10
  "全角文字のフォント設定
  "encoding=utf-8 かつ guifontset が空または Invalid の時のみ有効
  set guifontwide=MeiryoKe_Console:h10,MS_Gothic:h10
  " Avoid to slow move cursor
  "set renderoptions=type:directx
  set columns=120
  set lines=100
elseif has('unix')
endif
set nomousefocus    " マウス移動によるフォーカス切り替えを無効
set guioptions-=T   " Hide toolbar
