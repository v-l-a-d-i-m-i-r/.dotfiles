-- local palette = {
--   base00 = '#2e3440',
--   base01 = '#3b4252',
--   base02 = '#434c5e',
--   base03 = '#4c566a',
--   base04 = '#d8dee9',
--   base05 = '#e5e9f0',
--   base06 = '#eceff4',
--   base07 = '#8fbcbb',
--   base08 = '#bf616a',
--   base09 = '#d08770',
--   base0A = '#ebcb8b',
--   base0B = '#a3be8c',
--   base0C = '#88c0d0',
--   base0D = '#81a1c1',
--   base0E = '#b48ead',
--   base0F = '#5e81ac'
-- }
-- --! vscode darkplus
-- ! http://blog.itaysk.com/2018/03/06/making-my-terminal-look-like-vscode
-- ! http://www.eclipsecolorthemes.org/?view=theme&id=50827
-- ! special
-- *.foreground:   #d4d4d4
-- *.background:   #1e1e1e
-- *.cursorColor:  #D2D2D2
--
-- ! black
-- ! *.color0:       #000000
-- *.color0:       #262626
-- *.color8:       #797979
--
-- ! red
-- *.color1:       #d25252
-- *.color9:       #ce9178
--
-- ! green
-- *.color2:       #608b4e
-- *.color10:      #7fb347
--
-- ! yellow
-- *.color3:       #ccdf32
-- *.color11:      #d9e577
--
-- ! blue
-- *.color4:       #569cd6
-- *.color12:      #79abff
--
-- ! magenta
-- *.color5:       #d197d9
-- *.color13:      #bfa4a4
--
-- ! cyan
-- *.color6:       #9cdcfe
-- *.color14:      #bed6ff
--
-- ! white
-- *.color7:       #d0d0d0
-- *.color15:      #d8d8d8

-- #define nord0 #2E3440
-- #define nord1 #3B4252
-- #define nord2 #434C5E
-- #define nord3 #4C566A
-- #define nord4 #D8DEE9
-- #define nord5 #E5E9F0
-- #define nord6 #ECEFF4
-- #define nord7 #8FBCBB
-- #define nord8 #88C0D0
-- #define nord9 #81A1C1
-- #define nord10 #5E81AC
-- #define nord11 #BF616A
-- #define nord12 #D08770
-- #define nord13 #EBCB8B
-- #define nord14 #A3BE8C
-- #define nord15 #B48EAD
--
-- *.foreground:   nord4
-- *.background:   nord0
-- *.cursorColor:  nord4
-- *fading: 35
-- *fadeColor: nord3
--
-- ! black
-- *.color0: nord1
-- *.color8: nord3
--
-- ! red
-- *.color1: nord11
-- *.color9: nord11
--
-- ! green
-- *.color2: nord14
-- *.color10: nord14
--
-- ! yellow
-- *.color3: nord13
-- *.color11: nord13
--
-- ! blue
-- *.color4: nord9
-- ! *.color12: nord9
-- *.color12: nord10
--
-- ! magenta
-- *.color5: nord15
-- *.color13: nord15
--
-- ! cyan
-- *.color6: nord8
-- *.color14: nord7
--
-- ! white
-- *.color7: nord5
-- *.color15: nord6
 
local palette = {
  base00 = '#2e3440',
  base01 = '#3b4252',
  base02 = '#434c5e',
  base03 = '#4c566a',
  base04 = '#d8dee9',
  base05 = '#e5e9f0',
  base06 = '#eceff4',
  base07 = '#8fbcbb',
  base08 = '#bf616a',
  base09 = '#d08770',
  base0A = '#ebcb8b',
  base0B = '#a3be8c',
  base0C = '#88c0d0',
  base0D = '#81a1c1',
  base0E = '#b48ead',
  base0F = '#5e81ac'
}

require('base16-colorscheme').setup(palette)
