" -----------------------------------------------------------------------------
" File: night.vim
" Description: 
" Author: Luis Zuniga
" Source: 
" Last Modified: 
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='night'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:night_bold')
  let g:night_bold=1
endif
if !exists('g:night_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:night_italic=1
  else
    let g:night_italic=0
  endif
endif
if !exists('g:night_undercurl')
  let g:night_undercurl=1
endif
if !exists('g:night_underline')
  let g:night_underline=1
endif
if !exists('g:night_inverse')
  let g:night_inverse=1
endif

if !exists('g:night_guisp_fallback') || index(['fg', 'bg'], g:night_guisp_fallback) == -1
  let g:night_guisp_fallback='NONE'
endif

if !exists('g:night_improved_strings')
  let g:night_improved_strings=0
endif

if !exists('g:night_improved_warnings')
  let g:night_improved_warnings=0
endif

if !exists('g:night_termcolors')
  let g:night_termcolors=256
endif

if !exists('g:night_invert_indent_guides')
  let g:night_invert_indent_guides=0
endif

if exists('g:night_contrast')
  echo 'g:night_contrast is deprecated; use g:night_contrast_light and g:night_contrast_dark instead'
endif

if !exists('g:night_contrast_dark')
  let g:night_contrast_dark='medium'
endif

if !exists('g:night_contrast_light')
  let g:night_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" dark ladder
let s:gb.dark0_hard  = ['#141520', 234]   " bg_popup
let s:gb.dark0       = ['#1a1b26', 235]   " bg
let s:gb.dark0_soft  = ['#1d1f2d', 236]   " bg_alt
let s:gb.dark1       = ['#1d1f2d', 237]   " bg_alt
let s:gb.dark2       = ['#202437', 239]   " bg_high
let s:gb.dark3       = ['#1f253f', 241]   " bg_visual
let s:gb.dark4       = ['#414868', 243]   " border
let s:gb.dark4_256   = ['#414868', 243]   " border

" gray ladder
let s:gb.gray_245    = ['#4d526b', 245]   " comment
let s:gb.gray_244    = ['#484b5c', 244]   " line_nr

" light / foreground ladder
let s:gb.light0_hard = ['#ffffff', 230]   " white
let s:gb.light0      = ['#c0caf5', 229]   " fg
let s:gb.light0_soft = ['#a9b1d6', 228]   " fg_alt
let s:gb.light1      = ['#c0caf5', 223]   " fg
let s:gb.light2      = ['#a9b1d6', 250]   " fg_alt
let s:gb.light3      = ['#484b5c', 248]   " line_nr
let s:gb.light4      = ['#4d526b', 246]   " comment
let s:gb.light4_256  = ['#4d526b', 246]   " comment

" bright accents
let s:gb.bright_red     = ['#f7768e', 167]   " red
let s:gb.bright_green   = ['#9ece6a', 142]   " green
let s:gb.bright_yellow  = ['#e0af68', 214]   " yellow2
let s:gb.bright_blue    = ['#7aa2f7', 109]   " blue
let s:gb.bright_purple  = ['#bb9af7', 175]   " purple
let s:gb.bright_aqua    = ['#7dcfff', 108]   " cyan
let s:gb.bright_orange  = ['#e08f68', 208]   " orange

" neutral accents
let s:gb.neutral_red    = ['#f7768e', 124]   " red
let s:gb.neutral_green  = ['#9ece6a', 106]   " green
let s:gb.neutral_yellow = ['#dec76e', 172]   " yellow
let s:gb.neutral_blue   = ['#7aa2f7', 66]    " blue
let s:gb.neutral_purple = ['#bb9af7', 132]   " purple
let s:gb.neutral_aqua   = ['#7dcfff', 72]    " cyan
let s:gb.neutral_orange = ['#e08f68', 166]   " orange

" faded accents
let s:gb.faded_red      = ['#f44747', 88]    " red_err
let s:gb.faded_green    = ['#9ece6a', 100]   " green
let s:gb.faded_yellow   = ['#d79a42', 136]   " warning
let s:gb.faded_blue     = ['#7aa2f7', 24]    " blue
let s:gb.faded_purple   = ['#bb9af7', 96]    " purple
let s:gb.faded_aqua     = ['#7dcfff', 66]    " cyan
let s:gb.faded_orange   = ['#e08f68', 130]   " orange

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:night_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:night_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:night_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:night_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:night_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:night_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:night_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:night_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:night_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:night_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:night_hls_cursor')
  let s:hls_cursor = get(s:gb, g:night_hls_cursor)
endif

let s:number_column = s:none
if exists('g:night_number_column')
  let s:number_column = get(s:gb, g:night_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:night_sign_column')
    let s:sign_column = get(s:gb, g:night_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:night_color_column')
  let s:color_column = get(s:gb, g:night_color_column)
endif

let s:vert_split = s:bg0
if exists('g:night_vert_split')
  let s:vert_split = get(s:gb, g:night_vert_split)
endif

let s:invert_signs = ''
if exists('g:night_invert_signs')
  if g:night_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:night_invert_selection')
  if g:night_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:night_invert_tabline')
  if g:night_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:night_italicize_comments')
  if g:night_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:night_italicize_strings')
  if g:night_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:night_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:night_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Night Hi Groups: {{{

" memoize common hi groups
call s:HL('NightFg0', s:fg0)
call s:HL('NightFg1', s:fg1)
call s:HL('NightFg2', s:fg2)
call s:HL('NightFg3', s:fg3)
call s:HL('NightFg4', s:fg4)
call s:HL('NightGray', s:gray)
call s:HL('NightBg0', s:bg0)
call s:HL('NightBg1', s:bg1)
call s:HL('NightBg2', s:bg2)
call s:HL('NightBg3', s:bg3)
call s:HL('NightBg4', s:bg4)

call s:HL('NightRed', s:red)
call s:HL('NightRedBold', s:red, s:none, s:bold)
call s:HL('NightGreen', s:green)
call s:HL('NightGreenBold', s:green, s:none, s:bold)
call s:HL('NightYellow', s:yellow)
call s:HL('NightYellowBold', s:yellow, s:none, s:bold)
call s:HL('NightBlue', s:blue)
call s:HL('NightBlueBold', s:blue, s:none, s:bold)
call s:HL('NightPurple', s:purple)
call s:HL('NightPurpleBold', s:purple, s:none, s:bold)
call s:HL('NightAqua', s:aqua)
call s:HL('NightAquaBold', s:aqua, s:none, s:bold)
call s:HL('NightOrange', s:orange)
call s:HL('NightOrangeBold', s:orange, s:none, s:bold)

call s:HL('NightRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('NightGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('NightYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('NightBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('NightPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('NightAquaSign', s:aqua, s:sign_column, s:invert_signs)
call s:HL('NightOrangeSign', s:orange, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

call s:HL('Normal', s:fg0, s:bg0)
" Normal text

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/gruvbox/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:fg0, s:bg1)
endif

hi! link NonText NightBg2
hi! link SpecialKey NightBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

" call s:HL('StatusLine',   s:fg2, s:bg1, s:inverse)
" call s:HL('StatusLineNC', s:fg3, s:bg1, s:inverse)
call s:HL('StatusLine',   s:fg0, s:bg2)
call s:HL('StatusLineNC', s:fg3, s:bg1)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:bg0)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory NightGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title NightGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg NightYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg NightYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question NightOrangeBold
" Warning messages
hi! link WarningMsg NightRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:fg3, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:night_improved_strings == 0
  hi! link Special NightOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement NightPurple
" if, then, else, endif, swicth, etc.
hi! link Conditional NightPurple
" for, do, while, etc.
hi! link Repeat NightPurple
" case, default, etc.
hi! link Label NightRed
" try, catch, throw
hi! link Exception NightRed
" sizeof, "+", "*", etc.
hi! link Operator NightAqua
" Any other keyword
hi! link Keyword NightPurple

" Variable name
hi! link Identifier NightFg1
" Function name
hi! link Function NightBlue

" Generic preprocessor
hi! link PreProc NightRed
" Preprocessor #include
hi! link Include NightPurple
" Preprocessor #define
hi! link Define NightPurple
" Same as Define
hi! link Macro NightPurple
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit NightPurple

" Generic constant
hi! link Constant NightAqua
" Character constant: 'c', '/n'
hi! link Character NightAqua
" String constant: "this is a string"
if g:night_improved_strings == 0
  call s:HL('String',  s:green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean NightOrange
" Number constant: 234, 0xff
hi! link Number NightOrange
" Floating point constant: 2.3e10
hi! link Float NightOrange

" Generic type
hi! link Type NightRed
" static, register, volatile, etc
hi! link StorageClass NightOrange
" struct, union, enum, etc.
hi! link Structure NightRed
" typedef
hi! link Typedef NightYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:night_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:night_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd NightGreenSign
hi! link GitGutterChange NightAquaSign
hi! link GitGutterDelete NightRedSign
hi! link GitGutterChangeDelete NightAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile NightGreen
hi! link gitcommitDiscardedFile NightRed

" }}}
" Signify: {{{

hi! link SignifySignAdd NightGreenSign
hi! link SignifySignChange NightAquaSign
hi! link SignifySignDelete NightRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign NightRedSign
hi! link SyntasticWarningSign NightYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   NightBlueSign
hi! link SignatureMarkerText NightPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl NightBlueSign
hi! link ShowMarksHLu NightBlueSign
hi! link ShowMarksHLo NightBlueSign
hi! link ShowMarksHLm NightBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch NightYellow
hi! link CtrlPNoEntries NightRed
hi! link CtrlPPrtBase NightBg2
hi! link CtrlPPrtCursor NightBlue
hi! link CtrlPLinePre NightBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket NightFg3
hi! link StartifyFile NightFg1
hi! link StartifyNumber NightBlue
hi! link StartifyPath NightGray
hi! link StartifySlash NightGray
hi! link StartifySection NightYellow
hi! link StartifySpecial NightBg2
hi! link StartifyHeader NightOrange
hi! link StartifyFooter NightBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign NightRedSign
hi! link ALEWarningSign NightYellowSign
hi! link ALEInfoSign NightBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail NightAqua
hi! link DirvishArg NightYellow

" }}}
" Netrw: {{{

hi! link netrwDir NightAqua
hi! link netrwClassify NightAqua
hi! link netrwLink NightGray
hi! link netrwSymLink NightFg1
hi! link netrwExe NightYellow
hi! link netrwComment NightGray
hi! link netrwList NightBlue
hi! link netrwHelpCmd NightAqua
hi! link netrwCmdSep NightFg3
hi! link netrwVersion NightGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir NightAqua
hi! link NERDTreeDirSlash NightAqua

hi! link NERDTreeOpenable NightOrange
hi! link NERDTreeClosable NightOrange

hi! link NERDTreeFile NightFg1
hi! link NERDTreeExecFile NightYellow

hi! link NERDTreeUp NightGray
hi! link NERDTreeCWD NightGreen
hi! link NERDTreeHelp NightFg1

hi! link NERDTreeToggleOn NightGreen
hi! link NERDTreeToggleOff NightRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign NightRedSign
hi! link CocWarningSign NightOrangeSign
hi! link CocInfoSign NightYellowSign
hi! link CocHintSign NightBlueSign
hi! link CocErrorFloat NightRed
hi! link CocWarningFloat NightOrange
hi! link CocInfoFloat NightYellow
hi! link CocHintFloat NightBlue
hi! link CocDiagnosticsError NightRed
hi! link CocDiagnosticsWarning NightOrange
hi! link CocDiagnosticsInfo NightYellow
hi! link CocDiagnosticsHint NightBlue

hi! link CocSelectedText NightRed
hi! link CocCodeLens NightGray

call s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:red)
call s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:orange)
call s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:yellow)
call s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:blue)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded NightGreen
hi! link diffRemoved NightRed
hi! link diffChanged NightAqua

hi! link diffFile NightOrange
hi! link diffNewFile NightYellow

hi! link diffLine NightBlue

" }}}
" Html: {{{

hi! link htmlTag NightBlue
hi! link htmlEndTag NightBlue

hi! link htmlTagName NightAquaBold
hi! link htmlArg NightAqua

hi! link htmlScriptTag NightPurple
hi! link htmlTagN NightFg1
hi! link htmlSpecialTagName NightAquaBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar NightOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag NightBlue
hi! link xmlEndTag NightBlue
hi! link xmlTagName NightBlue
hi! link xmlEqual NightBlue
hi! link docbkKeyword NightAquaBold

hi! link xmlDocTypeDecl NightGray
hi! link xmlDocTypeKeyword NightPurple
hi! link xmlCdataStart NightGray
hi! link xmlCdataCdata NightPurple
hi! link dtdFunction NightGray
hi! link dtdTagName NightPurple

hi! link xmlAttrib NightAqua
hi! link xmlProcessingDelim NightGray
hi! link dtdParamEntityPunct NightGray
hi! link dtdParamEntityDPunct NightGray
hi! link xmlAttribPunct NightGray

hi! link xmlEntity NightOrange
hi! link xmlEntityPunct NightOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation NightOrange
hi! link vimBracket NightOrange
hi! link vimMapModKey NightOrange
hi! link vimFuncSID NightFg3
hi! link vimSetSep NightFg3
hi! link vimSep NightFg3
hi! link vimContinue NightFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword NightBlue
hi! link clojureCond NightOrange
hi! link clojureSpecial NightOrange
hi! link clojureDefine NightOrange

hi! link clojureFunc NightYellow
hi! link clojureRepeat NightYellow
hi! link clojureCharacter NightAqua
hi! link clojureStringEscape NightAqua
hi! link clojureException NightRed

hi! link clojureRegexp NightAqua
hi! link clojureRegexpEscape NightAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen NightFg3
hi! link clojureAnonArg NightYellow
hi! link clojureVariable NightBlue
hi! link clojureMacro NightOrange

hi! link clojureMeta NightYellow
hi! link clojureDeref NightYellow
hi! link clojureQuote NightYellow
hi! link clojureUnquote NightYellow

" }}}
" C: {{{

hi! link cOperator NightPurple
hi! link cStructure NightOrange

" }}}
" Python: {{{

hi! link pythonBuiltin NightOrange
hi! link pythonBuiltinObj NightOrange
hi! link pythonBuiltinFunc NightOrange
hi! link pythonFunction NightAqua
hi! link pythonDecorator NightRed
hi! link pythonInclude NightBlue
hi! link pythonImport NightBlue
hi! link pythonRun NightBlue
hi! link pythonCoding NightBlue
hi! link pythonOperator NightRed
hi! link pythonException NightRed
hi! link pythonExceptions NightPurple
hi! link pythonBoolean NightPurple
hi! link pythonDot NightFg3
hi! link pythonConditional NightRed
hi! link pythonRepeat NightRed
hi! link pythonDottedName NightGreenBold

" }}}
" CSS: {{{

hi! link cssBraces NightBlue
hi! link cssFunctionName NightYellow
hi! link cssIdentifier NightOrange
hi! link cssClassName NightGreen
hi! link cssColor NightBlue
hi! link cssSelectorOp NightBlue
hi! link cssSelectorOp2 NightBlue
hi! link cssImportant NightGreen
hi! link cssVendor NightFg1

hi! link cssTextProp NightAqua
hi! link cssAnimationProp NightAqua
hi! link cssUIProp NightYellow
hi! link cssTransformProp NightAqua
hi! link cssTransitionProp NightAqua
hi! link cssPrintProp NightAqua
hi! link cssPositioningProp NightYellow
hi! link cssBoxProp NightAqua
hi! link cssFontDescriptorProp NightAqua
hi! link cssFlexibleBoxProp NightAqua
hi! link cssBorderOutlineProp NightAqua
hi! link cssBackgroundProp NightAqua
hi! link cssMarginProp NightAqua
hi! link cssListProp NightAqua
hi! link cssTableProp NightAqua
hi! link cssFontProp NightAqua
hi! link cssPaddingProp NightAqua
hi! link cssDimensionProp NightAqua
hi! link cssRenderProp NightAqua
hi! link cssColorProp NightAqua
hi! link cssGeneratedContentProp NightAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces NightFg1
hi! link javaScriptFunction NightAqua
hi! link javaScriptIdentifier NightRed
hi! link javaScriptMember NightBlue
hi! link javaScriptNumber NightPurple
hi! link javaScriptNull NightPurple
hi! link javaScriptParens NightFg3

" }}}
" YAJS: {{{

hi! link javascriptImport NightAqua
hi! link javascriptExport NightAqua
hi! link javascriptClassKeyword NightAqua
hi! link javascriptClassExtends NightAqua
hi! link javascriptDefault NightAqua

hi! link javascriptClassName NightYellow
hi! link javascriptClassSuperName NightYellow
hi! link javascriptGlobal NightYellow

hi! link javascriptEndColons NightFg1
hi! link javascriptFuncArg NightFg1
hi! link javascriptGlobalMethod NightFg1
hi! link javascriptNodeGlobal NightFg1
hi! link javascriptBOMWindowProp NightFg1
hi! link javascriptArrayMethod NightFg1
hi! link javascriptArrayStaticMethod NightFg1
hi! link javascriptCacheMethod NightFg1
hi! link javascriptDateMethod NightFg1
hi! link javascriptMathStaticMethod NightFg1

" hi! link javascriptProp NightFg1
hi! link javascriptURLUtilsProp NightFg1
hi! link javascriptBOMNavigatorProp NightFg1
hi! link javascriptDOMDocMethod NightFg1
hi! link javascriptDOMDocProp NightFg1
hi! link javascriptBOMLocationMethod NightFg1
hi! link javascriptBOMWindowMethod NightFg1
hi! link javascriptStringMethod NightFg1

hi! link javascriptVariable NightOrange
" hi! link javascriptVariable NightRed
" hi! link javascriptIdentifier NightOrange
" hi! link javascriptClassSuper NightOrange
hi! link javascriptIdentifier NightOrange
hi! link javascriptClassSuper NightOrange

" hi! link javascriptFuncKeyword NightOrange
" hi! link javascriptAsyncFunc NightOrange
hi! link javascriptFuncKeyword NightAqua
hi! link javascriptAsyncFunc NightAqua
hi! link javascriptClassStatic NightOrange

hi! link javascriptOperator NightRed
hi! link javascriptForOperator NightRed
hi! link javascriptYield NightRed
hi! link javascriptExceptions NightRed
hi! link javascriptMessage NightRed

hi! link javascriptTemplateSB NightAqua
hi! link javascriptTemplateSubstitution NightFg1

" hi! link javascriptLabel NightBlue
" hi! link javascriptObjectLabel NightBlue
" hi! link javascriptPropertyName NightBlue
hi! link javascriptLabel NightFg1
hi! link javascriptObjectLabel NightFg1
hi! link javascriptPropertyName NightFg1

hi! link javascriptLogicSymbols NightFg1
hi! link javascriptArrowFunc NightYellow

hi! link javascriptDocParamName NightFg4
hi! link javascriptDocTags NightFg4
hi! link javascriptDocNotation NightFg4
hi! link javascriptDocParamType NightFg4
hi! link javascriptDocNamedParamType NightFg4

hi! link javascriptBrackets NightFg1
hi! link javascriptDOMElemAttrs NightFg1
hi! link javascriptDOMEventMethod NightFg1
hi! link javascriptDOMNodeMethod NightFg1
hi! link javascriptDOMStorageMethod NightFg1
hi! link javascriptHeadersMethod NightFg1

hi! link javascriptAsyncFuncKeyword NightRed
hi! link javascriptAwaitFuncKeyword NightRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword NightAqua
hi! link jsExtendsKeyword NightAqua
hi! link jsExportDefault NightAqua
hi! link jsTemplateBraces NightAqua
hi! link jsGlobalNodeObjects NightFg1
hi! link jsGlobalObjects NightFg1
hi! link jsFunction NightAqua
hi! link jsFuncParens NightFg3
hi! link jsParens NightFg3
hi! link jsNull NightPurple
hi! link jsUndefined NightPurple
hi! link jsClassDefinition NightYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved NightAqua
hi! link typeScriptLabel NightAqua
hi! link typeScriptFuncKeyword NightAqua
hi! link typeScriptIdentifier NightOrange
hi! link typeScriptBraces NightFg1
hi! link typeScriptEndColons NightFg1
hi! link typeScriptDOMObjects NightFg1
hi! link typeScriptAjaxMethods NightFg1
hi! link typeScriptLogicSymbols NightFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects NightFg1
hi! link typeScriptParens NightFg3
hi! link typeScriptOpSymbols NightFg3
hi! link typeScriptHtmlElemProperties NightFg1
hi! link typeScriptNull NightPurple
hi! link typeScriptInterpolationDelimiter NightAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword NightAqua
hi! link purescriptModuleName NightFg1
hi! link purescriptWhere NightAqua
hi! link purescriptDelimiter NightFg4
hi! link purescriptType NightFg1
hi! link purescriptImportKeyword NightAqua
hi! link purescriptHidingKeyword NightAqua
hi! link purescriptAsKeyword NightAqua
hi! link purescriptStructure NightAqua
hi! link purescriptOperator NightBlue

hi! link purescriptTypeVar NightFg1
hi! link purescriptConstructor NightFg1
hi! link purescriptFunction NightFg1
hi! link purescriptConditional NightOrange
hi! link purescriptBacktick NightOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp NightFg3
hi! link coffeeSpecialOp NightFg3
hi! link coffeeCurly NightOrange
hi! link coffeeParen NightFg3
hi! link coffeeBracket NightOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter NightGreen
hi! link rubyInterpolationDelimiter NightAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier NightRed
hi! link objcDirective NightBlue

" }}}
" Go: {{{

hi! link goDirective NightAqua
hi! link goConstants NightPurple
hi! link goDeclaration NightRed
hi! link goDeclType NightBlue
hi! link goBuiltins NightOrange

" }}}
" Lua: {{{

hi! link luaIn NightRed
hi! link luaFunction NightAqua
hi! link luaTable NightOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp NightFg3
hi! link moonExtendedOp NightFg3
hi! link moonFunction NightFg3
hi! link moonObject NightYellow

" }}}
" Java: {{{

hi! link javaAnnotation NightBlue
hi! link javaDocTags NightAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen NightFg3
hi! link javaParen1 NightFg3
hi! link javaParen2 NightFg3
hi! link javaParen3 NightFg3
hi! link javaParen4 NightFg3
hi! link javaParen5 NightFg3
hi! link javaOperator NightOrange

hi! link javaVarArg NightGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter NightGreen
hi! link elixirInterpolationDelimiter NightAqua

hi! link elixirModuleDeclaration NightYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition NightFg1
hi! link scalaCaseFollowing NightFg1
hi! link scalaCapitalWord NightFg1
hi! link scalaTypeExtension NightFg1

hi! link scalaKeyword NightRed
hi! link scalaKeywordModifier NightRed

hi! link scalaSpecial NightAqua
hi! link scalaOperator NightFg1

hi! link scalaTypeDeclaration NightYellow
hi! link scalaTypeTypePostDeclaration NightYellow

hi! link scalaInstanceDeclaration NightFg1
hi! link scalaInterpolation NightAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 NightGreenBold
hi! link markdownH2 NightGreenBold
hi! link markdownH3 NightYellowBold
hi! link markdownH4 NightYellowBold
hi! link markdownH5 NightYellow
hi! link markdownH6 NightYellow

hi! link markdownCode NightAqua
hi! link markdownCodeBlock NightAqua
hi! link markdownCodeDelimiter NightAqua

hi! link markdownBlockquote NightGray
hi! link markdownListMarker NightGray
hi! link markdownOrderedListMarker NightGray
hi! link markdownRule NightGray
hi! link markdownHeadingRule NightGray

hi! link markdownUrlDelimiter NightFg3
hi! link markdownLinkDelimiter NightFg3
hi! link markdownLinkTextDelimiter NightFg3

hi! link markdownHeadingDelimiter NightOrange
hi! link markdownUrl NightPurple
hi! link markdownUrlTitleDelimiter NightGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType NightYellow
" hi! link haskellOperators NightOrange
" hi! link haskellConditional NightAqua
" hi! link haskellLet NightOrange
"
hi! link haskellType NightFg1
hi! link haskellIdentifier NightFg1
hi! link haskellSeparator NightFg1
hi! link haskellDelimiter NightFg4
hi! link haskellOperators NightBlue
"
hi! link haskellBacktick NightOrange
hi! link haskellStatement NightOrange
hi! link haskellConditional NightOrange

hi! link haskellLet NightAqua
hi! link haskellDefault NightAqua
hi! link haskellWhere NightAqua
hi! link haskellBottom NightAqua
hi! link haskellBlockKeywords NightAqua
hi! link haskellImportKeywords NightAqua
hi! link haskellDeclKeyword NightAqua
hi! link haskellDeriving NightAqua
hi! link haskellAssocType NightAqua

hi! link haskellNumber NightPurple
hi! link haskellPragma NightPurple

hi! link haskellString NightGreen
hi! link haskellChar NightGreen

" }}}
" Json: {{{

hi! link jsonKeyword NightGreen
hi! link jsonQuote NightGreen
hi! link jsonBraces NightFg1
hi! link jsonString NightFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! NightHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! NightHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
