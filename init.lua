local opt           = vim.opt
local g             = vim.g

g.mapleader         = " "
g.maplocalleader    = "\\"

-------------------------------------- globals -----------------------------------------
g.toggle_theme_icon = "   "

-------------------------------------- options ------------------------------------------
opt.laststatus      = 3 -- global statusline
opt.showmode        = false


opt.inccommand     = 'split'
opt.swapfile       = false

opt.clipboard      = "unnamedplus"

-- Indenting
opt.expandtab      = false
opt.shiftwidth     = 2
opt.smartindent    = true
opt.tabstop        = 2
opt.softtabstop    = 2

opt.ignorecase     = true
opt.smartcase      = true
opt.mouse          = "a"

-- Numbers
opt.number         = true
opt.relativenumber = true
opt.numberwidth    = 2
opt.ruler          = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn    = "yes"
opt.splitbelow    = true
opt.splitright    = true
opt.termguicolors = true
opt.timeoutlen    = 400
opt.undofile      = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime    = 250

-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = "",
	},
	signs = true,
	underline = true,
	severity_sort = true,
})

require("core.init")
