scriptencoding utf-8

"---------------------------------------------------------------------------
" .gvimrc
"---------------------------------------------------------------------------

" カラースキームの設定
colorscheme desert256s

" 背景色の傾向(カラースキームがそれに併せて色の明暗を変えてくれる)
"set background=light

if has("mac")
"  opacity
"  set transparency=30
  set guifont=Inconsolata:h14
  set columns=160
  set lines=100
elseif has('win32') || has('win64')
  "半角文字のフォント設定
  set guifont=Consolas:h10
  "全角文字のフォント設定
  "encoding=utf-8 かつ guifontset が空または Invalid の時のみ有効
  set guifontwide=MeiryoKe_Console:h10,MS_Gothic:h10
  set renderoptions=type:directx
  set columns=120
  set lines=100
elseif has('unix')
endif
set nomousefocus    " マウス移動によるフォーカス切り替えを無効
set guioptions-=T   " Hide toolbar
