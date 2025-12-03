-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "rosepine",

  hl_override = {
    CursorLine = { bg = "one_bg2" },
    CursorLineNr = { fg = "dark_purple" },
    LineNr = { fg = "light_grey" },
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

return M
