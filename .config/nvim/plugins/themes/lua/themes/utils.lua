local HEX_DIGITS = {
  ['0'] = 0,
  ['1'] = 1,
  ['2'] = 2,
  ['3'] = 3,
  ['4'] = 4,
  ['5'] = 5,
  ['6'] = 6,
  ['7'] = 7,
  ['8'] = 8,
  ['9'] = 9,
  ['a'] = 10,
  ['b'] = 11,
  ['c'] = 12,
  ['d'] = 13,
  ['e'] = 14,
  ['f'] = 15,
  ['A'] = 10,
  ['B'] = 11,
  ['C'] = 12,
  ['D'] = 13,
  ['E'] = 14,
  ['F'] = 15,
}

local function hex_to_rgb(hex)
  local red = HEX_DIGITS[string.sub(hex, 1, 1)] * 16 + HEX_DIGITS[string.sub(hex, 2, 2)]
  local green = HEX_DIGITS[string.sub(hex, 3, 3)] * 16 + HEX_DIGITS[string.sub(hex, 4, 4)]
  local blue = HEX_DIGITS[string.sub(hex, 5, 5)] * 16 + HEX_DIGITS[string.sub(hex, 6, 6)]

  return red, green, blue
end

local function rgb_to_hex(r, g, b)
  return bit.tohex(bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b), 6)
end

local function hsl_to_rgb(h, s, l, a)
  h = h / 360
  s = s / 100
  l = l / 100

  local r, g, b;

  if s == 0 then
    r, g, b = l, l, l; -- achromatic
  else
    local function hue2rgb(p, q, t)
      if t < 0 then t = t + 1 end
      if t > 1 then t = t - 1 end
      if t < 1 / 6 then return p + (q - p) * 6 * t end
      if t < 1 / 2 then return q end
      if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
      return p;
    end

    local q = l < 0.5 and l * (1 + s) or l + s - l * s;
    local p = 2 * l - q;
    r = hue2rgb(p, q, h + 1 / 3);
    g = hue2rgb(p, q, h);
    b = hue2rgb(p, q, h - 1 / 3);
  end

  if not a then a = 1 end

  return r * 255, g * 255, b * 255, a * 255
end

local function hsl_to_hex_string(h, s, l)
  return "#" .. rgb_to_hex(hsl_to_rgb(h, s, l, 100))
end

local function capitalize(s)
	return string.upper(string.sub(s, 1, 1)) .. string.sub(s, 2)
end

-- https://github.com/folke/tokyonight.nvim/blob/v1.0.0/lua/tokyonight/treesitter.lua
local function map_treesitter_key_to_legacy(key)
  local hashMap = {
    ["@constant.builtin"] = "TSConstBuiltin",
    ["@constant.macro"] = "TSConstMacro",
    ["@function.builtin"] = "TSFuncBuiltin",
    ["@function.macro"] = "TSFuncMacro",
    ["@preproc"] = "TSPreProc",
    ["@punctuation.bracket"] = "TSPunctBracket",
    ["@punctuation.delimiter"] = "TSPunctDelimiter",
    ["@punctuation.special"] = "TSPunctSpecial",
    ["@storageclass"] = "TSStorageClass",
    ["@text.danger"] = "TSDanger",
    ["@text.emphasis"] = "TSEmphasis",
    ["@text.environment"] = "TSEnvironment",
    ["@text.environment.name"] = "TSEnvironmentName",
    ["@text.literal"] = "TSLiteral",
    ["@text.math"] = "TSMath",
    ["@text.note"] = "TSNote",
    ["@text.reference"] = "TSTextReference",
    ["@text.strike"] = "TSStrike",
    ["@text.strong"] = "TSStrong",
    ["@text.title"] = "TSTitle",
    ["@text.underline"] = "TSUnderline",
    ["@text.uri"] = "TSURI",
    ["@text.warning"] = "TSWarning",
  }

  if hashMap[key] ~= nil then
    return hashMap[key]
  end

	return "TS" .. (string.gsub(key, ".(%w+)" , capitalize))
end

local function treesitter_map_to_legacy(higlights)
  local result = {}

  for key, value in pairs(higlights) do
    local legacyKey = map_treesitter_key_to_legacy(key)
    result[legacyKey] = value
  end
  -- P(result)
  return result
end

local function highlight(groups)
  for group, props in pairs(groups) do
    if (type(props) == 'string') then
      local cmd = table.concat({
        "highlight", "link", group, props
      }, " ")
      vim.cmd(('hi! link %s %s'):format(group, args))
      return
    end

    local guibg = props.guibg == nil and "" or "guibg=" .. props.guibg
    local guifg = props.guifg == nil and "" or "guifg=" .. props.guifg
    local gui = props.gui == nil and "" or "gui=" .. props.gui
    local guisp = props.guisp == nil and "" or "guisp=" .. props.guisp

    local cmd = table.concat({
      "highlight", group, guifg, guibg, gui, guisp
    }, " ")

    vim.api.nvim_command(cmd)
  end
end

return {
  highlight = highlight,
  treesitter_map_to_legacy = treesitter_map_to_legacy,
}
