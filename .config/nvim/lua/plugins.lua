local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn

-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

local packer = require'packer'
local util = require'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
 })

require('impatient')
require'impatient'.enable_profile()
 
 --- startup and add configure plugins
packer.startup(function()
  local use = use
   -- add you plugins here like:
    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
    use 'sheerun/vim-polyglot'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'p00f/nvim-ts-rainbow'
    
    -- Impatient
    use 'lewis6991/impatient.nvim'

    -- lspconfig
    use 'neovim/nvim-lspconfig'

    -- fuzzy-finder
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'cljoly/telescope-repo.nvim'
   
   
  end
 )
