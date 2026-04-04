require "nvchad.options"

local o = vim.o
local opt = vim.opt

-- Line numbers
o.relativenumber = true
o.number = true

-- Scroll
o.scrolloff = 8
o.sidescrolloff = 8

-- Splits
o.splitbelow = true
o.splitright = true

-- Search
o.ignorecase = true
o.smartcase = true

-- UI
o.cursorline = true
o.cursorlineopt = "both"
o.signcolumn = "yes"
o.wrap = false
o.termguicolors = true
o.showmode = false

-- Editing
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true

-- System
o.clipboard = "unnamedplus"
o.undofile = true
o.swapfile = false
o.updatetime = 250
o.timeoutlen = 300

-- Completion
o.completeopt = "menuone,noselect"

-- Disable line wrap indicators
opt.fillchars = { eob = " " }
