" Vim color file
" forked from desert256.vim
"
" # references
"   * `:he group-name`
"   * `:he highlight-groups`
"   * `:he cterm-colors`
"
"------------------------------------------------------------------------------

" Vim color file
" Maintainer: Henry So, Jr. <henryso@panix.com>

" These are the colors of the "desert" theme by Hans Fugal with a few small
" modifications (namely that I lowered the intensity of the normal white and
" made the normal and nontext backgrounds black), modified to work with 88-
" and 256-color xterms.
"
" The original "desert" theme is available as part of the vim distribution or
" at http://hans.fugal.net/vim/colors/.
"
" The real feature of this color scheme, with a wink to the "inkpot" theme, is
" the programmatic approximation of the gui colors to the palettes of 88- and
" 256- color xterms.  The functions that do this (folded away, for
" readability) are calibrated to the colors used for Thomas E. Dickey's xterm
" (version 200), which is available at http://dickey.his.com/xterm/xterm.html.
"
" I struggled with trying to parse the rgb.txt file to avoid the necessity of
" converting color names to #rrggbb form, but decided it was just not worth
" the effort.  Maybe someone seeing this may decide otherwise...

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="desert256"

if &t_Co == 88 || &t_Co == 256
    " functions {{{
    " returns an approximate grey index for the given grey level
    fun <SID>grey_number(x)
        if &t_Co == 88
            if a:x < 23
                return 0
            elseif a:x < 69
                return 1
            elseif a:x < 103
                return 2
            elseif a:x < 127
                return 3
            elseif a:x < 150
                return 4
            elseif a:x < 173
                return 5
            elseif a:x < 196
                return 6
            elseif a:x < 219
                return 7
            elseif a:x < 243
                return 8
            else
                return 9
            endif
        else
            if a:x < 14
                return 0
            else
                let l:n = (a:x - 8) / 10
                let l:m = (a:x - 8) % 10
                if l:m < 5
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " returns the actual grey level represented by the grey index
    fun <SID>grey_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 46
            elseif a:n == 2
                return 92
            elseif a:n == 3
                return 115
            elseif a:n == 4
                return 139
            elseif a:n == 5
                return 162
            elseif a:n == 6
                return 185
            elseif a:n == 7
                return 208
            elseif a:n == 8
                return 231
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 8 + (a:n * 10)
            endif
        endif
    endfun

    " returns the palette index for the given grey index
    fun <SID>grey_color(n)
        if &t_Co == 88
            if a:n == 0
                return 16
            elseif a:n == 9
                return 79
            else
                return 79 + a:n
            endif
        else
            if a:n == 0
                return 16
            elseif a:n == 25
                return 231
            else
                return 231 + a:n
            endif
        endif
    endfun

    " returns an approximate color index for the given color level
    fun <SID>rgb_number(x)
        if &t_Co == 88
            if a:x < 69
                return 0
            elseif a:x < 172
                return 1
            elseif a:x < 230
                return 2
            else
                return 3
            endif
        else
            if a:x < 75
                return 0
            else
                let l:n = (a:x - 55) / 40
                let l:m = (a:x - 55) % 40
                if l:m < 20
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " returns the actual color level for the given color index
    fun <SID>rgb_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 139
            elseif a:n == 2
                return 205
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 55 + (a:n * 40)
            endif
        endif
    endfun

    " returns the palette index for the given R/G/B color indices
    fun <SID>rgb_color(x, y, z)
        if &t_Co == 88
            return 16 + (a:x * 16) + (a:y * 4) + a:z
        else
            return 16 + (a:x * 36) + (a:y * 6) + a:z
        endif
    endfun

    " returns the palette index to approximate the given R/G/B color levels
    fun <SID>color(r, g, b)
        " get the closest grey
        let l:gx = <SID>grey_number(a:r)
        let l:gy = <SID>grey_number(a:g)
        let l:gz = <SID>grey_number(a:b)

        " get the closest color
        let l:x = <SID>rgb_number(a:r)
        let l:y = <SID>rgb_number(a:g)
        let l:z = <SID>rgb_number(a:b)

        if l:gx == l:gy && l:gy == l:gz
            " there are two possibilities
            let l:dgr = <SID>grey_level(l:gx) - a:r
            let l:dgg = <SID>grey_level(l:gy) - a:g
            let l:dgb = <SID>grey_level(l:gz) - a:b
            let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
            let l:dr = <SID>rgb_level(l:gx) - a:r
            let l:dg = <SID>rgb_level(l:gy) - a:g
            let l:db = <SID>rgb_level(l:gz) - a:b
            let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
            if l:dgrey < l:drgb
                " use the grey
                return <SID>grey_color(l:gx)
            else
                " use the color
                return <SID>rgb_color(l:x, l:y, l:z)
            endif
        else
            " only one possibility
            return <SID>rgb_color(l:x, l:y, l:z)
        endif
    endfun

    " returns the palette index to approximate the 'rrggbb' hex string
    fun <SID>rgb(rgb)
        let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
        let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
        let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

        return <SID>color(l:r, l:g, l:b)
    endfun

    " sets the highlighting for the given group
    fun <SID>X(group, fg, bg, attr)
        if a:fg != ""
            exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
        endif
        if a:bg != ""
            exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
        endif
        if a:attr != ""
            exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
        endif
    endfun
    " }}}

    call <SID>X("Normal", "cccccc", "000000", "")

    " highlight groups
    call <SID>X("Cursor", "708090", "f0e68c", "")
    "CursorIM
    "Directory
    "DiffAdd
    "DiffChange
    "DiffDelete
    "DiffText
    "ErrorMsg
    call <SID>X("VertSplit", "c2bfa5", "7f7f7f", "reverse")
    call <SID>X("Folded", "ffd700", "4d4d4d", "")
    call <SID>X("FoldColumn", "d2b48c", "4d4d4d", "")
    call <SID>X("IncSearch", "708090", "f0e68c", "")
    "LineNr
    call <SID>X("ModeMsg", "daa520", "", "")
    call <SID>X("MoreMsg", "2e8b57", "", "")
    call <SID>X("NonText", "addbe7", "000000", "bold")
    call <SID>X("Question", "00ff7f", "", "")
    call <SID>X("Search", "f5deb3", "cd853f", "")
    call <SID>X("SpecialKey", "9acd32", "", "")
    call <SID>X("StatusLine", "c2bfa5", "000000", "reverse")
    call <SID>X("StatusLineNC", "c2bfa5", "7f7f7f", "reverse")
    call <SID>X("Title", "cd5c5c", "", "")
    call <SID>X("Visual", "6b8e23", "f0e68c", "reverse")
    "VisualNOS
    call <SID>X("WarningMsg", "fa8072", "", "")
    "WildMenu
    "Menu
    "Scrollbar
    "Tooltip

    " syntax highlighting groups
    call <SID>X("Comment", "87ceeb", "", "")
    call <SID>X("Constant", "ffa0a0", "", "")
    call <SID>X("Identifier", "98fb98", "", "none")
    call <SID>X("Statement", "f0e68c", "", "bold")
    call <SID>X("PreProc", "cd5c5c", "", "")
    call <SID>X("Type", "bdb76b", "", "bold")
    call <SID>X("Special", "ffdead", "", "")
    "Underlined
    call <SID>X("Ignore", "666666", "", "")
    "Error
    call <SID>X("Todo", "ff4500", "eeee00", "")

    " delete functions {{{
    delf <SID>X
    delf <SID>rgb
    delf <SID>color
    delf <SID>rgb_color
    delf <SID>rgb_level
    delf <SID>rgb_number
    delf <SID>grey_color
    delf <SID>grey_level
    delf <SID>grey_number
    " }}}
else
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
    hi Pmenu      guibg=#ffa0a0 guifg=gray20 ctermfg=black ctermbg=magenta
    " 選択されたアイテム
    hi PmenuSel   guibg=SkyBlue guifg=gray20 ctermfg=black ctermbg=cyan
    " スクロールバー
    hi PmenuSbar  guibg=#ffa0a0 ctermbg=magenta
    " スクロールバーのツマミ
    hi PmenuThumb guibg=#ff6666 ctermbg=7


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
    hi Underlined cterm=underline ctermfg=5
    " (見た目上)空白, 不可視
    hi Ignore     guifg=grey40 cterm=bold ctermfg=darkgrey
    " エラーなど、なんらかの誤った構造
    hi Error cterm=bold ctermfg=7 ctermbg=1
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
    hi VisualNOS  cterm=bold,underline
    " 最後に検索した語のハイライト
    hi Search     guibg=peru guifg=wheat cterm=NONE ctermfg=black ctermbg=magenta
    " 'incsearch' のハイライト; ":s///c" で置換されたテキストにも使われる
    hi IncSearch  guifg=slategrey guibg=khaki cterm=NONE ctermfg=yellow ctermbg=darkgreen
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
    hi DiffAdd    ctermbg=4
    " 差分モード: 変更された行
    hi DiffChange ctermbg=5
    " 差分モード: 削除された行
    hi DiffDelete cterm=bold ctermfg=4 ctermbg=6
    " 差分モード: 変更された行中の変更されたテキスト
    hi DiffText   cterm=bold ctermbg=1



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
    hi CursorLine ctermfg=white
    " ディレクトリ名(とリストにある特別な名前)
    hi Directory  ctermfg=darkcyan
    " 垂直分割したウィンドウの区切りとなる列
    hi VertSplit  guibg=#c2bfa5 guifg=grey50 gui=none cterm=reverse
    " ':number' と ':#' コマンドの行番号
    hi LineNr guifg=gray55 guibg=NONE ctermfg=3
    " LineNr と同じだが 'cursorline' か 'relativenumber' が設定されているときに現在行に使われる
    "hi CursorLineNr
    " ':set all', ':autocmd' などによる出力のタイトル
    hi Title  ctermfg=5 guifg=indianred
    " 'wildmenu' 補完における現在の候補
    hi WildMenu ctermfg=0 ctermbg=3
    " メニューのフォント、文字、背景。ツールバーにも使われる (引数にfont, guibg, guifgが使える)
    "hi Menu
    " メインウィンドウのスクロールバーの文字と背景
    "hi Scrollbar
    " ツールチップのフォント、文字、背景
    "hi Tooltip
endif

" vim: set fdl=0 fdm=marker:
