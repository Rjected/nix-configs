" Kanagawa Lotus (Light) Airline Theme
" Based on https://github.com/rebelot/kanagawa.nvim

" Color palette
let s:bg = '#f2ecbc'          " lotusWhite3
let s:bg_dim = '#e5ddb0'      " lotusWhite2
let s:bg_dark = '#d5cea3'     " lotusWhite0
let s:fg = '#545464'          " lotusInk1
let s:fg_dim = '#43436c'      " lotusInk2
let s:gray = '#716e61'        " lotusGray2
let s:red = '#c84053'         " lotusRed
let s:orange = '#cc6d00'      " lotusOrange
let s:yellow = '#77713f'      " lotusYellow
let s:green = '#6f894e'       " lotusGreen
let s:aqua = '#597b75'        " lotusAqua
let s:blue = '#4d699b'        " lotusBlue4
let s:violet = '#624c83'      " lotusViolet4
let s:pink = '#b35b79'        " lotusPink

" Terminal color indices
let s:cterm_bg = 255
let s:cterm_bg_dim = 254
let s:cterm_bg_dark = 252
let s:cterm_fg = 240
let s:cterm_fg_dim = 238
let s:cterm_gray = 243
let s:cterm_red = 167
let s:cterm_orange = 166
let s:cterm_yellow = 100
let s:cterm_green = 65
let s:cterm_aqua = 66
let s:cterm_blue = 67
let s:cterm_violet = 97
let s:cterm_pink = 132

let g:airline#themes#kanagawa_lotus#palette = {}

" Normal mode
let s:N1 = [ s:bg, s:blue, s:cterm_bg, s:cterm_blue ]
let s:N2 = [ s:fg, s:bg_dim, s:cterm_fg, s:cterm_bg_dim ]
let s:N3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_lotus#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

" Insert mode
let s:I1 = [ s:bg, s:green, s:cterm_bg, s:cterm_green ]
let s:I2 = [ s:fg, s:bg_dim, s:cterm_fg, s:cterm_bg_dim ]
let s:I3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_lotus#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

" Visual mode
let s:V1 = [ s:bg, s:violet, s:cterm_bg, s:cterm_violet ]
let s:V2 = [ s:fg, s:bg_dim, s:cterm_fg, s:cterm_bg_dim ]
let s:V3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_lotus#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

" Replace mode
let s:R1 = [ s:bg, s:red, s:cterm_bg, s:cterm_red ]
let s:R2 = [ s:fg, s:bg_dim, s:cterm_fg, s:cterm_bg_dim ]
let s:R3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_lotus#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

" Inactive window
let s:IA1 = [ s:gray, s:bg_dim, s:cterm_gray, s:cterm_bg_dim ]
let s:IA2 = [ s:gray, s:bg_dim, s:cterm_gray, s:cterm_bg_dim ]
let s:IA3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_lotus#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

" Modified flag
let g:airline#themes#kanagawa_lotus#palette.normal_modified = {
      \ 'airline_c': [ s:orange, s:bg, s:cterm_orange, s:cterm_bg, '' ],
      \ }
let g:airline#themes#kanagawa_lotus#palette.insert_modified = g:airline#themes#kanagawa_lotus#palette.normal_modified
let g:airline#themes#kanagawa_lotus#palette.visual_modified = g:airline#themes#kanagawa_lotus#palette.normal_modified
let g:airline#themes#kanagawa_lotus#palette.replace_modified = g:airline#themes#kanagawa_lotus#palette.normal_modified
let g:airline#themes#kanagawa_lotus#palette.inactive_modified = {
      \ 'airline_c': [ s:orange, s:bg, s:cterm_orange, s:cterm_bg, '' ],
      \ }

" Warnings and errors
let g:airline#themes#kanagawa_lotus#palette.normal.airline_warning = [ s:fg, s:yellow, s:cterm_fg, s:cterm_yellow, 'bold' ]
let g:airline#themes#kanagawa_lotus#palette.normal.airline_error = [ s:bg, s:red, s:cterm_bg, s:cterm_red, 'bold' ]

" Terminal mode
if get(g:, 'airline#extensions#term#enabled', 0)
  let g:airline#themes#kanagawa_lotus#palette.terminal = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
  let g:airline#themes#kanagawa_lotus#palette.normal.airline_term = s:N3
  let g:airline#themes#kanagawa_lotus#palette.terminal.airline_term = s:I3
  let g:airline#themes#kanagawa_lotus#palette.visual.airline_term = s:V3
endif

" Tabline
if get(g:, 'airline#extensions#tabline#enabled', 0)
  let g:airline#themes#kanagawa_lotus#palette.tabline = {
    \ 'airline_tab':     [ s:gray, s:bg_dim, s:cterm_gray, s:cterm_bg_dim, '' ],
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
let g:airline#themes#kanagawa_lotus#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ s:gray, s:bg_dim, s:cterm_gray, s:cterm_bg_dim, '' ],
      \ [ s:bg, s:blue, s:cterm_bg, s:cterm_blue, '' ],
      \ [ s:bg, s:green, s:cterm_bg, s:cterm_green, 'bold' ])