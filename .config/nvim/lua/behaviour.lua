vim.cmd [[autocmd VimEnter * syntax on]]
local set = vim.opt
set.termguicolors = true
set.tabstop = 3
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.rnu = true
set.nu = true
set.wrap = false
set.updatetime = 250
set.mouse = 'a'
set.clipboard = "unnamedplus"
set.hlsearch = false
set.showmode = false
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
