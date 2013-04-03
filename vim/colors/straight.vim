" Vim color file
" Maintainer: saneyuki_s
" forked from desert.vim

" references
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name="straight"



"---------------------------------------------------------------------------
" ステータスライン
"

" current windowのステータスライン
hi StatusLine   guibg=#c2bfa5 guifg=black gui=none cterm=bold,reverse
" 非current windowのステータスライン
hi StatusLineNC guibg=#c2bfa5 guifg=grey50 gui=none cterm=reverse
" ヒットエンタープロンプト|hit-enter|とyes/noクエスチョン
hi Question     guifg=springgreen ctermfg=green
" 'showmode' のメッセージ (例. "-- INSERT --")
hi ModeMsg      guifg=goldenrod cterm=NONE ctermfg=brown
" |more-prompt|
hi MoreMsg      guifg=SeaGreen ctermfg=darkgreen
" 警告メッセージ
hi WarningMsg   guifg=salmon ctermfg=1
" コマンドラインに現れるエラーメッセージ
hi ErrorMsg     cterm=bold ctermfg=7 ctermbg=1



"---------------------------------------------------------------------------
" ポップアップメニュー
"

" メニューアイテム
hi Pmenu      guibg=#ffa0a0 guifg=gray20
" 選択されたアイテム
hi PmenuSel   guibg=SkyBlue guifg=gray20
" スクロールバー
hi PmenuSbar  guibg=#ffa0a0 ctermbg=darkgray
" スクロールバーのツマミ
hi PmenuThumb guibg=#ff6666 ctermbg=lightgray



"-------------------------------------------------------------
" text color
"

" 通常のテキスト
hi Normal     guifg=White guibg=grey20
" 実際のテキストには存在しない文字
hi NonText    guifg=LightBlue guibg=grey30 cterm=bold ctermfg=darkblue
" コメント
hi Comment    guifg=SkyBlue ctermfg=darkcyan
" 定数値
hi Constant   guifg=#ffa0a0 ctermfg=brown
" 識別子
hi Identifier guifg=palegreen ctermfg=6
" 構文
hi Statement  guifg=khaki ctermfg=3
" プリプロセス命令
hi PreProc    guifg=indianred ctermfg=5
" 型名（クラス、構造体）
hi Type       guifg=darkkhaki ctermfg=2
" 特殊記号
hi Special    guifg=navajowhite ctermfg=5
" 目立つ文章, HTMLリンク
"hi Underlined cterm=underline ctermfg=5
" (見た目上)空白, 不可視
hi Ignore     guifg=grey40 cterm=bold ctermfg=darkgrey
" エラーなど、なんらかの誤った構造
"hi Error cterm=bold ctermfg=7 ctermbg=1
" ToDoキーワード
hi Todo       guifg=orangered guibg=yellow2

" ':map' でリストされるメタキーと特別なキー。テキスト中のunprintableな文字を表示するのにも使われる。
" 一般に: 実際とは異なる文字で表示されるテキスト
hi SpecialKey guifg=yellowgreen ctermfg=darkgreen



"-------------------------------------------------------------
" text status
"

" ビジュアルモード選択
hi Visual     gui=none guifg=khaki guibg=olivedrab cterm=reverse
" vimが 'Not Owning the Selection' のときのビジュアルモード選択
" これをサポートしているのはX11GUI|gui-x11|と|xterm-clipboard|のみ
"hi VisualNOS  cterm=bold,underline
" 最後に検索した語のハイライト
hi Search     guibg=peru guifg=wheat cterm=NONE ctermfg=grey ctermbg=blue
" 'incsearch' のハイライト; ":s///c" で置換されたテキストにも使われる
hi IncSearch  guifg=slategrey guibg=khaki cterm=NONE ctermfg=yellow ctermbg=green
" 閉じた折り畳みの行
hi Folded     guibg=grey30 guifg=gold ctermfg=darkgrey ctermbg=NONE
" 'foldcolumn'
hi FoldColumn guibg=grey30 guifg=tan ctermfg=darkgrey ctermbg=NONE
" カーソルに対応する括弧
"hi MatchParen



"---------------------------------------------------------------------------
" Spell checker
"

" スペルチェッカに認識されない単語
"hi SpellBad
" 大文字で始まるべき単語
"hi SpellCap
" スペルチェッカによって他の地域で使われると判断される単語
"hi SpellLocal
" スペルチェッカによってまず使わないと判断される単語
"hi SpellRare



"---------------------------------------------------------------------------
" タブページ
"

" タブページの行の、アクティブでないタブページのラベル
"hi TabLine
" タブページの行の、ラベルがない部分
"hi TabLineFill
" タブページの行の、アクティブなタブページのラベル
"hi TabLineSel



"---------------------------------------------------------------------------
" Diff
"

" 差分モード: 追加された行
"hi DiffAdd    ctermbg=4
" 差分モード: 変更された行
"hi DiffChange ctermbg=5
" 差分モード: 削除された行
"hi DiffDelete cterm=bold ctermfg=4 ctermbg=6
" 差分モード: 変更された行中の変更されたテキスト
"hi DiffText   cterm=bold ctermbg=1



"---------------------------------------------------------------------------
" Others
"

" 'colorcolumn' で設定された列の表示に使われる
"hi ColorColumn
" Conceal されたテキストの代わりに表示される代替文字の表示に使われる ('conceallevel' 参照)
"hi Conceal
" カーソル下の文字
hi Cursor guibg=khaki guifg=slategrey
" Cursorと同じだが、IMEモードにいるとき使われる
"hi CursorIM
" 'cursorcolumn' がオンになっているときのカーソルがある画面上の列
"hi CursorColumn
" 'cursorline' がオンになっているときのカーソルがある画面上の行
"hi CursorLine
" ディレクトリ名(とリストにある特別な名前)
hi Directory  ctermfg=darkcyan
" 垂直分割したウィンドウの区切りとなる列
hi VertSplit  guibg=#c2bfa5 guifg=grey50 gui=none cterm=reverse
" ':number' と ':#' コマンドの行番号
hi LineNr guifg=gray55 guibg=NONE ctermfg=242 ctermbg=NONE
" LineNr と同じだが 'cursorline' か 'relativenumber' が設定されているときに現在行に使われる
"hi CursorLineNr
" ':set all', ':autocmd' などによる出力のタイトル
hi Title  ctermfg=5 guifg=indianred
" 'wildmenu' 補完における現在の候補
"hi WildMenu ctermfg=0 ctermbg=3
" メニューのフォント、文字、背景。ツールバーにも使われる (引数にfont, guibg, guifgが使える)
"hi Menu
" メインウィンドウのスクロールバーの文字と背景
"hi Scrollbar
" ツールチップのフォント、文字、背景
"hi Tooltip
