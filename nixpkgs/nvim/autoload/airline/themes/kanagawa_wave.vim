" Kanagawa Wave (Default Dark) Airline Theme
" Based on https://github.com/rebelot/kanagawa.nvim

" Color palette
let s:bg = '#1F1F28'          " sumiInk3
let s:bg_dim = '#16161D'      " sumiInk0
let s:bg_dark = '#16161D'     " sumiInk0
let s:bg_light = '#2A2A37'    " sumiInk4
let s:fg = '#DCD7BA'          " fujiWhite
let s:fg_dim = '#C8C093'      " oldWhite
let s:gray = '#727169'        " fujiGray
let s:red = '#E46876'         " waveRed
let s:orange = '#FFA066'      " surimiOrange
let s:yellow = '#E6C384'      " carpYellow
let s:green = '#98BB6C'       " springGreen
let s:aqua = '#7AA89F'        " waveAqua2
let s:blue = '#7E9CD8'        " crystalBlue
let s:violet = '#957FB8'      " oniViolet
let s:pink = '#D27E99'        " sakuraPink

" Terminal color indices
let s:cterm_bg = 234
let s:cterm_bg_dim = 232
let s:cterm_bg_dark = 232
let s:cterm_bg_light = 236
let s:cterm_fg = 252
let s:cterm_fg_dim = 250
let s:cterm_gray = 243
let s:cterm_red = 167
let s:cterm_orange = 209
let s:cterm_yellow = 186
let s:cterm_green = 107
let s:cterm_aqua = 108
let s:cterm_blue = 110
let s:cterm_violet = 103
let s:cterm_pink = 174

let g:airline#themes#kanagawa_wave#palette = {}

" Normal mode
let s:N1 = [ s:bg, s:blue, s:cterm_bg, s:cterm_blue ]
let s:N2 = [ s:fg, s:bg_light, s:cterm_fg, s:cterm_bg_light ]
let s:N3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_wave#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

" Insert mode
let s:I1 = [ s:bg, s:green, s:cterm_bg, s:cterm_green ]
let s:I2 = [ s:fg, s:bg_light, s:cterm_fg, s:cterm_bg_light ]
let s:I3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_wave#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

" Visual mode
let s:V1 = [ s:bg, s:violet, s:cterm_bg, s:cterm_violet ]
let s:V2 = [ s:fg, s:bg_light, s:cterm_fg, s:cterm_bg_light ]
let s:V3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_wave#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

" Replace mode
let s:R1 = [ s:bg, s:red, s:cterm_bg, s:cterm_red ]
let s:R2 = [ s:fg, s:bg_light, s:cterm_fg, s:cterm_bg_light ]
let s:R3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_wave#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

" Inactive window
let s:IA1 = [ s:gray, s:bg_dim, s:cterm_gray, s:cterm_bg_dim ]
let s:IA2 = [ s:gray, s:bg_dim, s:cterm_gray, s:cterm_bg_dim ]
let s:IA3 = [ s:gray, s:bg, s:cterm_gray, s:cterm_bg ]
let g:airline#themes#kanagawa_wave#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

" Modified flag
let g:airline#themes#kanagawa_wave#palette.normal_modified = {
      \ 'airline_c': [ s:orange, s:bg, s:cterm_orange, s:cterm_bg, '' ],
      \ }
let g:airline#themes#kanagawa_wave#palette.insert_modified = g:airline#themes#kanagawa_wave#palette.normal_modified
let g:airline#themes#kanagawa_wave#palette.visual_modified = g:airline#themes#kanagawa_wave#palette.normal_modified
let g:airline#themes#kanagawa_wave#palette.replace_modified = g:airline#themes#kanagawa_wave#palette.normal_modified
let g:airline#themes#kanagawa_wave#palette.inactive_modified = {
      \ 'airline_c': [ s:orange, s:bg, s:cterm_orange, s:cterm_bg, '' ],
      \ }

" Warnings and errors
let g:airline#themes#kanagawa_wave#palette.normal.airline_warning = [ s:bg, s:yellow, s:cterm_bg, s:cterm_yellow, 'bold' ]
let g:airline#themes#kanagawa_wave#palette.normal.airline_error = [ s:bg, s:red, s:cterm_bg, s:cterm_red, 'bold' ]

" Terminal mode
if get(g:, 'airline#extensions#term#enabled', 0)
  let g:airline#themes#kanagawa_wave#palette.terminal = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
  let g:airline#themes#kanagawa_wave#palette.normal.airline_term = s:N3
  let g:airline#themes#kanagawa_wave#palette.terminal.airline_term = s:I3
  let g:airline#themes#kanagawa_wave#palette.visual.airline_term = s:V3
endif

" Tabline
if get(g:, 'airline#extensions#tabline#enabled', 0)
  let g:airline#themes#kanagawa_wave#palette.tabline = {
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
let g:airline#themes#kanagawa_wave#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ s:gray, s:bg_light, s:cterm_gray, s:cterm_bg_light, '' ],
      \ [ s:bg, s:blue, s:cterm_bg, s:cterm_blue, '' ],
      \ [ s:bg, s:green, s:cterm_bg, s:cterm_green, 'bold' ])