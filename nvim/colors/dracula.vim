" Dracula Theme: {{{
"
" https://github.com/zenorocha/dracula-theme
"
" Copyright 2016, All rights reserved
"
" Code licensed under the MIT license
" http://zenorocha.mit-license.org
"
" @author Trevor Heins <@heinst>
" @author Éverton Ribeiro <nuxlli@gmail.com>
" @author Derek Sifford <dereksifford@gmail.com>
" @author Zeno Rocha <hi@zenorocha.com>
scriptencoding utf8
" }}}

" Configuration: {{{

if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'dracula'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" Palette: {{{2

let s:fg        = ['#F8F8F2', 255]

let s:bglighter = ['#424450', 238]
let s:bglight   = ['#343746', 237]
let s:bg        = ['#282A36', 236]
let s:bgdark    = ['#21222C', 235]
let s:bgdarker  = ['#191A21', 234]

let s:subtle    = ['#424450', 238]

let s:selection = ['#44475A', 239]
let s:comment   = ['#6272A4',  61]
let s:cyan      = ['#8BE9FD', 117]
let s:green     = ['#50FA7B',  84]
let s:orange    = ['#FFB86C', 215]
let s:pink      = ['#FF79C6', 212]
let s:purple    = ['#BD93F9', 141]
let s:red       = ['#FF5555', 203]
let s:yellow    = ['#F1FA8C', 228]

let s:none      = ['NONE', 'NONE']

let g:dracula_palette = {
      \ 'fg': s:fg,
      \ 'bg': s:bg,
      \ 'selection': s:selection,
      \ 'comment': s:comment,
      \ 'cyan': s:cyan,
      \ 'green': s:green,
      \ 'orange': s:orange,
      \ 'pink': s:pink,
      \ 'purple': s:purple,
      \ 'red': s:red,
      \ 'yellow': s:yellow,
      \
      \ 'bglighter': s:bglighter,
      \ 'bglight': s:bglight,
      \ 'bgdark': s:bgdark,
      \ 'bgdarker': s:bgdarker,
      \ 'subtle': s:subtle,
      \}

if has('nvim')
  let g:terminal_color_0  = '#21222C'
  let g:terminal_color_1  = '#FF5555'
  let g:terminal_color_2  = '#50FA7B'
  let g:terminal_color_3  = '#F1FA8C'
  let g:terminal_color_4  = '#BD93F9'
  let g:terminal_color_5  = '#FF79C6'
  let g:terminal_color_6  = '#8BE9FD'
  let g:terminal_color_7  = '#F8F8F2'
  let g:terminal_color_8  = '#6272A4'
  let g:terminal_color_9  = '#FF6E6E'
  let g:terminal_color_10 = '#69FF94'
  let g:terminal_color_11 = '#FFFFA5'
  let g:terminal_color_12 = '#D6ACFF'
  let g:terminal_color_13 = '#FF92DF'
  let g:terminal_color_14 = '#A4FFFF'
  let g:terminal_color_15 = '#FFFFFF'
endif

" }}}2
" User Configuration: {{{2

if !exists('g:dracula_bold')
  let g:dracula_bold = 1
endif

if !exists('g:dracula_italic')
  let g:dracula_italic = 1
endif

if !exists('g:dracula_underline')
  let g:dracula_underline = 1
endif

if !exists('g:dracula_undercurl') && g:dracula_underline != 0
  let g:dracula_undercurl = 1
endif

if !exists('g:dracula_inverse')
  let g:dracula_inverse = 1
endif

if !exists('g:dracula_colorterm')
  let g:dracula_colorterm = 1
endif

"}}}2
" Script Helpers: {{{2

let s:attrs = {
      \ 'bold': g:dracula_bold == 1 ? 'bold' : 0,
      \ 'italic': g:dracula_italic == 1 ? 'italic' : 0,
      \ 'underline': g:dracula_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:dracula_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:dracula_inverse == 1 ? 'inverse' : 0,
      \}

function! s:h(scope, fg, ...) " bg, attr_list, special
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  " Falls back to coloring foreground group on terminals because
  " nearly all do not support undercurl
  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !has('gui_running')
    let l:fg[0] = l:special[0]
    let l:fg[1] = l:special[1]
  endif

  let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \ 'guisp=' . l:special[0],
        \]

  execute join(l:hl_string, ' ')
endfunction

function! s:Background()
  if g:dracula_colorterm || has('gui_running')
    return s:bg
  else
    return s:none
  endif
endfunction

"}}}2
" Dracula Highlight Groups: {{{2

call s:h('DraculaBgLight', s:none, s:bglight)
call s:h('DraculaBgLighter', s:none, s:bglighter)
call s:h('DraculaBgDark', s:none, s:bgdark)
call s:h('DraculaBgDarker', s:none, s:bgdarker)

call s:h('DraculaFg', s:fg)
call s:h('DraculaFgUnderline', s:fg, s:none, [s:attrs.underline])
call s:h('DraculaFgBold', s:fg, s:none, [s:attrs.bold])

call s:h('DraculaComment', s:comment)
call s:h('DraculaCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('DraculaSelection', s:none, s:selection)

call s:h('DraculaSubtle', s:subtle)

call s:h('DraculaCyan', s:cyan)
call s:h('DraculaCyanItalic', s:cyan, s:none, [s:attrs.italic])

call s:h('DraculaGreen', s:green)
call s:h('DraculaGreenBold', s:green, s:none, [s:attrs.bold])
call s:h('DraculaGreenItalic', s:green, s:none, [s:attrs.italic])
call s:h('DraculaGreenItalicUnderline', s:green, s:none, [s:attrs.italic, s:attrs.underline])

call s:h('DraculaOrange', s:orange)
call s:h('DraculaOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('DraculaOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('DraculaOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('DraculaOrangeInverse', s:bg, s:orange)

call s:h('DraculaPink', s:pink)
call s:h('DraculaPinkItalic', s:pink, s:none, [s:attrs.italic])

call s:h('DraculaPurple', s:purple)
call s:h('DraculaPurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('DraculaPurpleItalic', s:purple, s:none, [s:attrs.italic])

call s:h('DraculaRed', s:red)
call s:h('DraculaRedInverse', s:fg, s:red)

call s:h('DraculaYellow', s:yellow)
call s:h('DraculaYellowItalic', s:yellow, s:none, [s:attrs.italic])

call s:h('DraculaError', s:red, s:none, [], s:red)

call s:h('DraculaErrorLine', s:none, s:none, [s:attrs.undercurl], s:red)
call s:h('DraculaWarnLine', s:none, s:none, [s:attrs.undercurl], s:orange)
call s:h('DraculaInfoLine', s:none, s:none, [s:attrs.undercurl], s:cyan)

call s:h('DraculaTodo', s:cyan, s:none, [s:attrs.bold, s:attrs.inverse])
call s:h('DraculaSearch', s:green, s:none, [s:attrs.inverse])
call s:h('DraculaBoundary', s:comment, s:bgdark)
call s:h('DraculaLink', s:cyan, s:none, [s:attrs.underline])

call s:h('DraculaDiffChange', s:none, s:none)
call s:h('DraculaDiffText', s:bg, s:orange)
call s:h('DraculaDiffDelete', s:red, s:bgdark)

" }}}2

" }}}
" User Interface: {{{

set background=dark

" Required as some plugins will overwrite
call s:h('Normal', s:fg, s:Background())
call s:h('StatusLine', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, [s:attrs.bold])
call s:h('CursorLine', s:none, s:subtle)

hi! link ColorColumn  DraculaSelection
hi! link CursorColumn DraculaSelection
hi! link CursorLineNr DraculaYellow
hi! link DiffAdd      DraculaGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   DraculaDiffChange
hi! link DiffDelete   DraculaDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     DraculaDiffText
hi! link Directory    DraculaPurpleBold
hi! link ErrorMsg     DraculaRedInverse
hi! link FoldColumn   DraculaSubtle
hi! link Folded       DraculaBoundary
hi! link IncSearch    DraculaOrangeInverse
hi! link LineNr       DraculaComment
hi! link MoreMsg      DraculaFgBold
hi! link NonText      DraculaSubtle
hi! link Pmenu        DraculaBgDark
hi! link PmenuSbar    DraculaBgDark
hi! link PmenuSel     DraculaSelection
hi! link PmenuThumb   DraculaSelection
hi! link Question     DraculaFgBold
hi! link Search       DraculaSearch
hi! link SignColumn   DraculaComment
hi! link TabLine      DraculaBoundary
hi! link TabLineFill  DraculaBgDarker
hi! link TabLineSel   Normal
hi! link Title        DraculaGreenBold
hi! link VertSplit    DraculaBoundary
hi! link Visual       DraculaSelection
hi! link VisualNOS    Visual
hi! link WarningMsg   DraculaOrangeInverse

" }}}
" Syntax: {{{

" Required as some plugins will overwrite
call s:h('MatchParen', s:fg, s:pink, [s:attrs.underline])
call s:h('Conceal', s:comment, s:bglight)

" Neovim uses SpecialKey for escape characters only. Vim uses it for that, plus whitespace.
if has('nvim')
  hi! link SpecialKey DraculaRed
else
  hi! link SpecialKey DraculaSubtle
endif

hi! link Comment DraculaComment
hi! link Underlined DraculaFgUnderline
hi! link Todo DraculaTodo

hi! link Error DraculaError
hi! link SpellBad DraculaErrorLine
hi! link SpellLocal DraculaWarnLine
hi! link SpellCap DraculaInfoLine
hi! link SpellRare DraculaInfoLine

hi! link Constant DraculaPurple
hi! link String DraculaYellow
hi! link Character DraculaPink
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier DraculaFg
hi! link Function DraculaGreen

hi! link Statement DraculaPink
hi! link Conditional DraculaPink
hi! link Repeat DraculaPink
hi! link Label DraculaPink
hi! link Operator DraculaPink
hi! link Keyword DraculaPink
hi! link Exception DraculaPink

hi! link PreProc DraculaPink
hi! link Include DraculaPink
hi! link Define DraculaPink
hi! link Macro DraculaPink
hi! link PreCondit DraculaPink
hi! link StorageClass DraculaPink
hi! link Structure DraculaPink
hi! link Typedef DraculaPink

" -----------------------------
" C / C++ / clangd semantic fixes (CLEAN)
" -----------------------------

" -----------------------------
" Builtin / primitive types → CYAN
" int, float, uint8_t, size_t, auto
" -----------------------------
hi! link @type.builtin.c DraculaCyan
hi! link @type.builtin.cpp DraculaCyan

hi! link @lsp.type.type.c DraculaCyan
hi! link @lsp.type.type.cpp DraculaCyan

hi! link @lsp.mod.deduced.c DraculaCyan
hi! link @lsp.mod.deduced.cpp DraculaCyan
hi! link @lsp.typemod.type.deduced.c DraculaCyan
hi! link @lsp.typemod.type.deduced.cpp DraculaCyan


" -----------------------------
" Namespaces → PURPLE
" std::
" -----------------------------
hi! link @namespace.c DraculaPurple
hi! link @namespace.cpp DraculaPurple

hi! link @lsp.type.namespace.c DraculaPurple
hi! link @lsp.type.namespace.cpp DraculaPurple
hi! link @lsp.typemod.namespace.defaultLibrary.c DraculaPurple
hi! link @lsp.typemod.namespace.defaultLibrary.cpp DraculaPurple


" -----------------------------
" std types → PINK
" vector, string, optional, etc
" -----------------------------
hi! link @lsp.typemod.class.defaultLibrary.c DraculaPink
hi! link @lsp.typemod.class.defaultLibrary.cpp DraculaPink
hi! link @lsp.typemod.struct.defaultLibrary.c DraculaPink
hi! link @lsp.typemod.struct.defaultLibrary.cpp DraculaPink
hi! link @lsp.typemod.enum.defaultLibrary.c DraculaPink
hi! link @lsp.typemod.enum.defaultLibrary.cpp DraculaPink
hi! link @lsp.typemod.typeAlias.defaultLibrary.c DraculaPink
hi! link @lsp.typemod.typeAlias.defaultLibrary.cpp DraculaPink

" IMPORTANT: do NOT override with @type.cpp here


" -----------------------------
" User-defined types → GREEN
" vec, ClockState, etc
" -----------------------------
hi! link @type.c DraculaGreen
hi! link @type.cpp DraculaGreen

hi! link @lsp.type.class.c DraculaGreen
hi! link @lsp.type.class.cpp DraculaGreen
hi! link @lsp.type.struct.c DraculaGreen
hi! link @lsp.type.struct.cpp DraculaGreen
hi! link @lsp.type.enum.c DraculaGreen
hi! link @lsp.type.enum.cpp DraculaGreen
hi! link @lsp.type.typeAlias.c DraculaGreen
hi! link @lsp.type.typeAlias.cpp DraculaGreen

" -----------------------------
" Type declarations → WHITE
" struct vec / class Foo
" -----------------------------
hi! link @type.definition.c DraculaFg
hi! link @type.definition.cpp DraculaFg

hi! link @lsp.typemod.class.declaration.c DraculaFg
hi! link @lsp.typemod.class.declaration.cpp DraculaFg
hi! link @lsp.typemod.struct.declaration.c DraculaFg
hi! link @lsp.typemod.struct.declaration.cpp DraculaFg

hi! link @lsp.typemod.class.definition.c DraculaFg
hi! link @lsp.typemod.class.definition.cpp DraculaFg
hi! link @lsp.typemod.struct.definition.c DraculaFg
hi! link @lsp.typemod.struct.definition.cpp DraculaFg


" -----------------------------
" Functions / methods → GREEN
" -----------------------------
hi! link @constructor.c DraculaGreen
hi! link @constructor.cpp DraculaGreen

hi! link @function.c DraculaGreen
hi! link @function.cpp DraculaGreen
hi! link @function.call.c DraculaGreen
hi! link @function.call.cpp DraculaGreen
hi! link @function.method.c DraculaGreen
hi! link @function.method.cpp DraculaGreen
hi! link @function.method.call.c DraculaGreen
hi! link @function.method.call.cpp DraculaGreen

hi! link @lsp.type.function.c DraculaGreen
hi! link @lsp.type.function.cpp DraculaGreen
hi! link @lsp.type.method.c DraculaGreen
hi! link @lsp.type.method.cpp DraculaGreen


" -----------------------------
" Constructors (clangd quirks)
" -----------------------------
hi! link @lsp.mod.constructorOrDestructor.c DraculaGreen
hi! link @lsp.mod.constructorOrDestructor.cpp DraculaGreen

hi! link @lsp.typemod.class.constructorOrDestructor.cpp DraculaGreen
hi! link @lsp.typemod.struct.constructorOrDestructor.cpp DraculaGreen
hi! link @lsp.typemod.type.constructorOrDestructor.cpp DraculaGreen


" -----------------------------
" Operators → PINK
" -----------------------------
hi! link @operator.c DraculaPink
hi! link @operator.cpp DraculaPink
hi! link @function.operator.c DraculaPink
hi! link @function.operator.cpp DraculaPink

hi! link @lsp.type.operator.c DraculaPink
hi! link @lsp.type.operator.cpp DraculaPink


" -----------------------------
" Variables / parameters → WHITE
" -----------------------------
hi! link @variable.c DraculaFg
hi! link @variable.cpp DraculaFg
hi! link @variable.parameter.c DraculaFg
hi! link @variable.parameter.cpp DraculaFg

hi! link @lsp.type.variable.c DraculaFg
hi! link @lsp.type.variable.cpp DraculaFg
hi! link @lsp.type.parameter.c DraculaFg
hi! link @lsp.type.parameter.cpp DraculaFg


" -----------------------------
" Members / fields → WHITE
" -----------------------------
hi! link @variable.member.c DraculaFg
hi! link @variable.member.cpp DraculaFg
hi! link @property.c DraculaFg
hi! link @property.cpp DraculaFg

hi! link @lsp.type.property.c DraculaFg
hi! link @lsp.type.property.cpp DraculaFg


" -----------------------------
" std objects → PINK
" std::cout
" -----------------------------
hi! link @lsp.typemod.variable.defaultLibrary.c DraculaPink
hi! link @lsp.typemod.variable.defaultLibrary.cpp DraculaPink
hi! link @lsp.typemod.property.defaultLibrary.c DraculaPink
hi! link @lsp.typemod.property.defaultLibrary.cpp DraculaPink

if has('nvim')
lua << EOF
local group = vim.api.nvim_create_augroup('DraculaCppStableConstructorHighlight', {
  clear = true,
})

local function token_text_looks_like_ctor(bufnr, token)
  local line = vim.api.nvim_buf_get_lines(bufnr, token.line, token.line + 1, false)[1]
  if not line then
    return false
  end

  -- token.start_col is 0-based byte offset.
  -- token.end_col is also byte-based.
  local after = line:sub(token.end_col + 1)

  -- Constructor declaration/definition has the class name directly followed by "(",
  -- possibly with whitespace in between.
  return after:match('^%s*%(') ~= nil
end

vim.api.nvim_create_autocmd('LspTokenUpdate', {
  group = group,
  callback = function(ev)
    local ft = vim.bo[ev.buf].filetype
    if ft ~= 'cpp' and ft ~= 'c' then
      return
    end

    local token = ev.data.token
    if not token then
      return
    end

    if token.type ~= 'class'
        and token.type ~= 'struct'
        and token.type ~= 'type' then
      return
    end

    if not token_text_looks_like_ctor(ev.buf, token) then
      return
    end

    local semantic_priority =
      vim.hl
      and vim.hl.priorities
      and vim.hl.priorities.semantic_tokens
      or 125

    vim.lsp.semantic_tokens.highlight_token(
      token,
      ev.buf,
      ev.data.client_id,
      'DraculaGreen',
      { priority = semantic_priority + 20 }
    )
  end,
})
EOF
endif

hi! link Special DraculaPink
hi! link SpecialComment DraculaCyanItalic
hi! link Identifier DraculaPurple
hi! link helpHyperTextJump DraculaLink
hi! link helpCommand DraculaPurple
hi! link helpExample DraculaGreen
hi! link helpBacktick Special

"}}}
hi Pmenu ctermfg=15 ctermbg=61 cterm=NONE guifg=#f8f8f2 guibg=#646e96 gui=NONE
hi PmenuSel ctermfg=16 ctermbg=84 cterm=bold guifg=#282a36 guibg=#50fa7b gui=NONE
" vim: fdm=marker ts=2 sts=2 sw=2:
