local opt = vim.opt
local g = vim.g

-------------------------------------- globals -----------------------------------------
g.toggle_theme_icon = "   "

-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"

-- Indenting
opt.expandtab = false
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

g.mapleader = " "
g.maplocalleader = " "

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    vim.wo.cursorline = true
    vim.wo.cursorcolumn = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  callback = function()
    vim.wo.cursorline = false
    vim.wo.cursorcolumn = false
  end,
})

-------------------------------------- commands ------------------------------------------
require("core.init")

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#FF0000" })
