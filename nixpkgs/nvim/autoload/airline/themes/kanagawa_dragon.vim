" Kanagawa Dragon (Darker Variant) Airline Theme
" Based on https://github.com/rebelot/kanagawa.nvim

" Color palette
let s:bg = '#181616'          " dragonBlack3
let s:bg_dim = '#0d0c0c'      " dragonBlack0
let s:bg_dark = '#0d0c0c'     " dragonBlack0
let s:bg_light = '#282727'    " dragonBlack4
let s:fg = '#c5c9c5'          " dragonWhite
let s:fg_dim = '#a6a69c'      " dragonGray
let s:gray = '#737c73'        " dragonAsh
let s:red = '#c4746e'         " dragonRed
let s:orange = '#b6927b'      " dragonOrange
let s:yellow = '#c4b28a'      " dragonYellow
let s:green = '#87a987'       " dragonGreen
let s:aqua = '#8ea4a2'        " dragonAqua
let s:blue = '#8ba4b0'        " dragonBlue2
let s:violet = '#8992a7'      " dragonViolet
let s:pink = '#a292a3'        " dragonPink

" Terminal color indices
let s:cterm_bg = 233
let s:cterm_bg_dim = 232
let s:cterm_bg_dark = 232
let s:cterm_bg_light = 235
let s:cterm_fg = 251
let s:cterm_fg_dim = 248
let s:cterm_gray = 243
let s:cterm_red = 167
let s:cterm_orange = 137
let s:cterm_yellow = 180
let s:cterm_green = 108
let s:cterm_aqua = 109
let s:cterm_blue = 109
let s:cterm_violet = 103
let s:cterm_pink = 139

let g:airline#themes#kanagawa_dragon#palette = {}

" Normal mode
let s:N1 = [ s:bg, s:blue, s:cterm_bg, s:cterm_blue ]
let s:N2 = [ s:fg, s:bg_light, s:cterm_fg, s:cterm_bg_light ]
let s:N3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_dragon#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

" Insert mode
let s:I1 = [ s:bg, s:green, s:cterm_bg, s:cterm_green ]
let s:I2 = [ s:fg, s:bg_light, s:cterm_fg, s:cterm_bg_light ]
let s:I3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_dragon#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

" Visual mode
let s:V1 = [ s:bg, s:violet, s:cterm_bg, s:cterm_violet ]
let s:V2 = [ s:fg, s:bg_light, s:cterm_fg, s:cterm_bg_light ]
let s:V3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_dragon#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

" Replace mode
let s:R1 = [ s:bg, s:red, s:cterm_bg, s:cterm_red ]
let s:R2 = [ s:fg, s:bg_light, s:cterm_fg, s:cterm_bg_light ]
let s:R3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_dragon#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

" Inactive window
let s:IA1 = [ s:gray, s:bg_dim, s:cterm_gray, s:cterm_bg_dim ]
let s:IA2 = [ s:gray, s:bg_dim, s:cterm_gray, s:cterm_bg_dim ]
let s:IA3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_dragon#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

" Modified flag
let g:airline#themes#kanagawa_dragon#palette.normal_modified = {
      \ 'airline_c': [ s:orange, s:bg, s:cterm_orange, s:cterm_bg, '' ],
      \ }
let g:airline#themes#kanagawa_dragon#palette.insert_modified = g:airline#themes#kanagawa_dragon#palette.normal_modified
let g:airline#themes#kanagawa_dragon#palette.visual_modified = g:airline#themes#kanagawa_dragon#palette.normal_modified
let g:airline#themes#kanagawa_dragon#palette.replace_modified = g:airline#themes#kanagawa_dragon#palette.normal_modified
let g:airline#themes#kanagawa_dragon#palette.inactive_modified = {
      \ 'airline_c': [ s:orange, s:bg, s:cterm_orange, s:cterm_bg, '' ],
      \ }

" Warnings and errors
let g:airline#themes#kanagawa_dragon#palette.normal.airline_warning = [ s:bg, s:yellow, s:cterm_bg, s:cterm_yellow, 'bold' ]
let g:airline#themes#kanagawa_dragon#palette.normal.airline_error = [ s:bg, s:red, s:cterm_bg, s:cterm_red, 'bold' ]

" Terminal mode
if get(g:, 'airline#extensions#term#enabled', 0)
  let g:airline#themes#kanagawa_dragon#palette.terminal = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
  let g:airline#themes#kanagawa_dragon#palette.normal.airline_term = s:N3
  let g:airline#themes#kanagawa_dragon#palette.terminal.airline_term = s:I3
  let g:airline#themes#kanagawa_dragon#palette.visual.airline_term = s:V3
endif

" Tabline
if get(g:, 'airline#extensions#tabline#enabled', 0)
  let g:airline#themes#kanagawa_dragon#palette.tabline = {
    \ 'airline_tab':     [ s:gray, s:bg_light, s:cterm_gray, s:cterm_bg_light, '' ],
    \ 'airline_tabsel':  [ s:bg, s:blue, s:cterm_bg, s:cterm_blue, '' ],
    \ 'airline_tabtype': [ s:bg, s:blue, s:cterm_bg, s:cterm_blue, '' ],
    \ 'airline_tabfill': [ s:gray, s:bg, s:cterm_gray, s:cterm_bg, '' ],
    \ 'airline_tabmod':  [ s:bg, s:orange, s:cterm_bg, s:cterm_orange, '' ],
    \ 'airline_tabhid':  [ s:gray, s:bg, s:cterm_gray, s:cterm_bg, '' ],
    \ }
endif

" CtrlP
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#kanagawa_dragon#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ s:gray, s:bg_light, s:cterm_gray, s:cterm_bg_light, '' ],
      \ [ s:bg, s:blue, s:cterm_bg, s:cterm_blue, '' ],
      \ [ s:bg, s:green, s:cterm_bg, s:cterm_green, 'bold' ])