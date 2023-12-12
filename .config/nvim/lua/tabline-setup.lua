local nvim_dev_icons = require('nvim-web-devicons')

local hl_group_names = {
  fill = 'TLFill',
  tab_normal = 'TLTabNormal',
  tab_active = 'TLTabActive',
  tab_normal_modified = 'TLTabNormalModified',
  tab_active_modified = 'TLTabActiveModified',
  sep_normal = 'TLSepNormal',
  sep_active = 'TLSepActive',
}

local chars = {
  separator = '|',
}

local skipped_buf_names = {
  'NvimTree_1',
  'Trouble',
  'DiffviewFilePanel',
  'null',
  'api.txt',
  '0.fugitiveblame',
  'diffview://',
}

local function add_hl_group(hl_group_name, text)
  return '%#' .. hl_group_name .. '#' .. text
end

local function get_hl(name)
  local hl_group = vim.api.nvim_get_hl(0, { name = name })

  if hl_group.link ~= nil then
    return get_hl(hl_group.link)
  end

  return hl_group
end

local function get_buf_abs_path(buf_nr)
  return vim.api.nvim_buf_get_name(buf_nr)
end

local function get_buf_name_with_ext(buf_nr)
  return vim.fn.expand('#' .. buf_nr .. ':t')
end

local function get_buf_ext(buf_nr)
  return vim.fn.expand('#' .. buf_nr .. ':e')
end

local function draw_buf(params)
  local buf_name_with_ext = params.buf_name_with_ext
  local buf_width = params.buf_width

  local buf_name_with_ext_len = string.len(buf_name_with_ext)
  local icon_with_paddings_len = 5

  if buf_name_with_ext_len > (buf_width - icon_with_paddings_len) then
    return string.sub(buf_name_with_ext, 1, (buf_width - icon_with_paddings_len - 1)) .. '~'
  end

  if buf_name_with_ext_len < (buf_width - icon_with_paddings_len) then
    local buf_name_with_ext_normalized = buf_name_with_ext

    while string.len(buf_name_with_ext_normalized) < (buf_width - icon_with_paddings_len - 1) do
      buf_name_with_ext_normalized = buf_name_with_ext_normalized .. ' '
    end

    return buf_name_with_ext_normalized
  end

  return params.buf_name_with_ext
end

local function setup()
  vim.o.showtabline = 2
  vim.o.tabline = '%!v:lua.nvim_tabline()'

  vim.api.nvim_set_hl(0, hl_group_names.fill, { link = 'TabLineFill' })
  vim.api.nvim_set_hl(0, hl_group_names.tab_normal, { link = 'TabLine' })
  vim.api.nvim_set_hl(0, hl_group_names.tab_active, { link = 'TabLineSel' })

  local hl_normal = get_hl(hl_group_names.tab_normal)
  local hl_active = get_hl(hl_group_names.tab_active)
  local hl_warn = get_hl('WarningMsg')

  vim.api.nvim_set_hl(0, hl_group_names.tab_normal_modified, { fg = hl_warn.fg, bg = hl_normal.bg })
  vim.api.nvim_set_hl(0, hl_group_names.tab_active_modified, { fg = hl_warn.fg, bg = hl_active.bg })
  vim.api.nvim_set_hl(0, hl_group_names.sep_normal, { fg = hl_active.bg, bg = hl_normal.bg })
  vim.api.nvim_set_hl(0, hl_group_names.sep_active, { fg = hl_normal.bg, bg = hl_active.bg })
end

local function tabline()
  local nvim_width = vim.go.columns
  local line = ''
  local buf_nrs = vim.api.nvim_list_bufs()
  local active_buf_nrs = vim.fn.tabpagebuflist()
  local filterred_buf_nrs = {}
  for _, buf_nr in ipairs(buf_nrs) do
    if not vim.api.nvim_buf_is_loaded(buf_nr) then
      goto continue
    end

    local buf_path = get_buf_abs_path(buf_nr)

    if buf_path == '' then
      goto continue
    end

    for _, skipped_buf_name in ipairs(skipped_buf_names) do
      if buf_path:find(skipped_buf_name) ~= nil then
        goto continue
      end
    end

    table.insert(filterred_buf_nrs, buf_nr)

    ::continue::
  end

  local bufs_qty = #filterred_buf_nrs
  local buf_width = math.min(nvim_width / bufs_qty, 30)

  local is_prev_buf_active = false
  for i, buf_nr in ipairs(filterred_buf_nrs) do
    local is_first = i == 1
    local is_last = i == table.getn(filterred_buf_nrs)
    local is_modified = vim.api.nvim_buf_get_option(buf_nr, 'modified')
    local is_active = false
    for _, active_buf_nr in ipairs(active_buf_nrs) do
      if buf_nr == active_buf_nr then
        is_active = true
      end
    end

    local buf_name_with_ext = get_buf_name_with_ext(buf_nr)
    local buf_ext = get_buf_ext(buf_nr)

    local buf_icon, buf_icon_hl_group = nvim_dev_icons.get_icon(buf_name_with_ext, buf_ext, { default = true })

    local tab_hl_group_name = hl_group_names.tab_normal
    if is_active and is_modified then
      tab_hl_group_name = hl_group_names.tab_active_modified
    end
    if not is_active and is_modified then
      tab_hl_group_name = hl_group_names.tab_normal_modified
    end
    if is_active and not is_modified then
      tab_hl_group_name = hl_group_names.tab_active
    end

    local icon_hl_group_name = is_active and buf_icon_hl_group or hl_group_names.tab_normal

    local sep_hl_group_name
    if not is_first and is_active and is_prev_buf_active then
      sep_hl_group_name = hl_group_names.sep_active
    end
    if not is_first and not is_active and not is_prev_buf_active then
      sep_hl_group_name = hl_group_names.sep_normal
    end

    local buf_name_with_ext_normalized = draw_buf({
      buf_name_with_ext = buf_name_with_ext,
      buf_width = buf_width,
    })

    if not is_first and sep_hl_group_name ~= nil then
      line = line .. add_hl_group(sep_hl_group_name, chars.separator)
    end
    if not is_first and sep_hl_group_name == nil then
      line = line .. ' '
    end

    line = line .. add_hl_group(tab_hl_group_name, ' ')
    line = line .. add_hl_group(icon_hl_group_name, buf_icon)
    line = line .. add_hl_group(tab_hl_group_name, ' ')
    line = line .. add_hl_group(tab_hl_group_name, buf_name_with_ext_normalized)
    line = line .. add_hl_group(tab_hl_group_name, ' ')

    if is_last and not is_active then
      line = line .. add_hl_group(hl_group_names.sep_normal, chars.separator)
    end

    is_prev_buf_active = is_active
  end

  return line .. add_hl_group(hl_group_names.fill, '')
end

function _G.nvim_tabline()
  return tabline()
end

return {
  setup = setup,
}
