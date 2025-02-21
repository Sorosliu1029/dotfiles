vim.cmd("set encoding=utf-8")

-- appearance related
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set ruler")
vim.cmd("set cursorline")
vim.cmd("set cursorcolumn")

-- indent related
vim.cmd("set autoindent")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.termguicolors = true

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- :checkhealth
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

