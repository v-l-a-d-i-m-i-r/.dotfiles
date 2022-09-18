local groups = require("groups-highlight")
local C = require("colors-definitions").colors

return function ()
  return {
    NvimTreeFolderIcon = {fg = C.blue },
		NvimTreeIndentMarker = groups.IndentGuides,
		-- NvimTreeNormal = {fg = C.light_gray, bg = C.tree_gray, },
		-- NvimTreeVertSplit = {fg = C.alt_bg, bg = C.alt_bg, },
		NvimTreeFolderName = {fg = C.blue},
		-- NvimTreeOpenedFolderName = {fg = C.folder_blue, style = "bold,italic", },
		-- NvimTreeEmptyFolderName = {fg = C.gray, style = "italic", },
		-- NvimTreeGitIgnored = {fg = C.gray, style = "italic", },
		-- NvimTreeImageFile = {fg = C.light_gray, },
		-- NvimTreeSpecialFile = {fg = C.orange, },
		-- NvimTreeEndOfBuffer = {fg = C.tree_gray, },
		-- NvimTreeCursorLine = { bg = C.bg_selection },
		-- NvimTreeGitignoreIcon = {fg = "#E64A19", },
    NvimTreeOpenedFile = { fg = C.cyan},
		NvimTreeGitStaged = groups.SignAdd,
		NvimTreeGitNew = groups.SignAdd,
		NvimTreeGitRenamed = groups.SignAdd,
		NvimTreeGitDeleted = groups.SignDelete,
		NvimTreeGitMerge = groups.SignChange,
		NvimTreeGitDirty = groups.SignChange,
		-- NvimTreeSymlink = {fg = C.cyan, },
		NvimTreeRootFolder = {fg = C.fg_primary}
		-- NvimTreeExecFile = {fg = "#9FBA89", },
  }
end
