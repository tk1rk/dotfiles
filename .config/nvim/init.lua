
--[[

  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

----------------------------------------------------------
-- Import Lua modules
----------------------------------------------------------
require('settings')
require('keymaps')
require('colors')
require('plugins')
require('plugins/alpha-nvim')
require('plugins/chadtree')
require('plugins/colorizer')
require('plugins/indent-blankline')
require('plugins/lualine')
require('plugins/cmp')
require('plugins/nvim-lspconfig')
require('plugins/nvim-treesitter')
require('plugins/plenary')
require('plugins/telescope')
require('plugins/')
require('plugins/vista')


-------------------------------------------------------------
-- packer.nvim bootstrap
-------------------------------------------------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
-------------------------------------------------------------
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end










local neogit = require('neogit') neogit.setup {}
