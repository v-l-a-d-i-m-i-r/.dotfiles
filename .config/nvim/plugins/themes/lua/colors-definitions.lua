local hsl_to_hex_string = require("color-utils").hsl_to_hex_string

local base_hue = 197
local base_saturation = 10
local base_lightnes = 15
local base_lightnes_step = 8

local bg_primary =  hsl_to_hex_string(base_hue, base_saturation, base_lightnes + base_lightnes_step * 0) -- base00
local bg_secondary = hsl_to_hex_string(base_hue, base_saturation, base_lightnes + base_lightnes_step * 0.5) -- base01
local bg_selection = hsl_to_hex_string(base_hue, base_saturation, base_lightnes + base_lightnes_step * 2) -- base03
local fg_comments = hsl_to_hex_string(base_hue, base_saturation, base_lightnes + base_lightnes_step * 3) -- base04

local fg_secondary = hsl_to_hex_string(base_hue, base_saturation, base_lightnes + base_lightnes_step * 5) -- base05
local fg_primary = hsl_to_hex_string(base_hue, base_saturation, base_lightnes + base_lightnes_step * 6) -- base06
local fg_tertiary = hsl_to_hex_string(base_hue, base_saturation, base_lightnes + base_lightnes_step * 7) -- base07
local bg_tertiary = hsl_to_hex_string(base_hue, base_saturation, base_lightnes + base_lightnes_step * 8) -- base08

local red = hsl_to_hex_string(3, 30, 40) -- red
local orange = hsl_to_hex_string(27, 30, 40) -- orange
local yellow = hsl_to_hex_string(49, 19, 44) -- yellow
local green = hsl_to_hex_string(102, 19, 44) -- green
local cyan = hsl_to_hex_string(180, 30, 44) -- cyan
local blue = hsl_to_hex_string(203, 30, 50) -- blue
local purple = hsl_to_hex_string(276, 14, 40) -- purple
local pink = hsl_to_hex_string(300, 30, 40) -- pink

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
