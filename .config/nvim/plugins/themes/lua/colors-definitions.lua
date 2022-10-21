-- start colors
local bg_primary = "#22282a" -- base00
local bg_secondary = "#2c3335" -- base01
local bg_selection = "#384145" -- base02
local fg_comments = "#505d62" -- base03
local fg_secondary = "#97a5aa" -- base04
local fg_primary = "#b9c2c6" -- base05
local fg_tertiary = "#c4cccf" -- base06
local bg_tertiary = "#dbdfe1" -- base07
local red = "#cc5733" --base08
local orange = "#ce9178" -- base09
local yellow = "#cdcd9d" -- base0A
local green = "#41a490" -- base0B
local cyan = "#94cceb" -- base0C
local blue = "#5496d4" -- base0D
local purple = "#646696" -- base0E
local pink = "#bb81c5" -- base0F
-- end colors

local colors = {
  bg_primary = bg_primary,
  bg_secondary = bg_secondary,
  bg_selection = bg_selection,
  fg_comments = fg_comments,

  fg_secondary = fg_secondary,
  fg_primary = fg_primary,
  fg_tertiary = fg_tertiary,
  bg_tertiary = bg_tertiary,

  red = red,
  orange = orange,
  yellow = yellow,
  green = green,
  cyan = cyan,
  blue = blue,
  purple = purple,
  pink = pink,
}

local base16_colors = {
  base00 = bg_primary,
  base01 = bg_secondary,
  base02 = bg_selection,
  base03 = fg_comments,

  base04 = fg_secondary,
  base05 = fg_primary,
  base06 = fg_tertiary,
  base07 = bg_tertiary,

  base08 = red,
  base09 = orange,
  base0A = yellow,
  base0B = green,
  base0C = cyan,
  base0D = blue,
  base0E = purple,
  base0F = pink,
}

return {
  colors = colors,
  base16_colors = base16_colors,
}
