local fn = vim.fn
local installPath = DATA_PATH..'/site/pack/packer/start/packer.nvim'

-- install packer if it's not installed already
local packerBootstrap = nil
if fn.empty(fn.glob(installPath)) > 0 then
  packerBootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', installPath})
  vim.cmd [[packadd packer.nvim]]
end

local packer = require('packer').startup(function(use)
  -- Packer should manage itself
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use 'Mofiqul/dracula.nvim'

  -- git integration
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- surround vim
  use 'tpope/vim-surround'

  -- nerd commenter
  use 'scrooloose/nerdcommenter'

  -- status line
  use {'konapun/vacuumline.nvim', requires = {
  'glepnir/galaxyline.nvim', branch = 'main',
  'kyazdani42/nvim-web-devicons', opt = true
  }, config = function() require('vacuumline.theme.one-dark').setup() end} -- Add this line to use defaults; otherwise, call `setup` with your config as described below wherever you configure your plugins

  -- show recent files on empty nvim command
  use 'mhinz/vim-startify'

  -- lsp config
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }

  -- for LSP autocompletion
  use 'hrsh7th/nvim-compe'

  -- TODO: prettify telescope vim, make it use regex & shorten the window
  -- telescope - searching / navigation
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- better hotfix window (for showing and searching through results in telescope's find usages)
  use {"kevinhwang91/nvim-bqf"}

  -- better highlighting
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- color-buddy
  use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- file explorer
  use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'}

  -- prettier tabs
  use 'romgrk/barbar.nvim'

  -- nice diagnostic pane on the bottom
  use 'folke/lsp-trouble.nvim'

  -- support the missing lsp diagnostic colors
  use 'folke/lsp-colors.nvim'

  -- better LSP UI (for code actions, rename etc.)
  use 'glepnir/lspsaga.nvim'

  -- show indentation levels
  use 'Yggdroot/indentLine'

  -- this will automatically install listed dependencies
  -- only the first time NeoVim is opened, because that's when Packer gets installed
  if packerBootstrap then
    require('packer').sync()
  end
end)

-- plugin specific configs go here
require('plugin-config/nvim-compe')
require('plugin-config/telescope')
require('plugin-config/chadtree')
require('plugin-config/nvim-treesitter')
require('plugin-config/barbar')
require('plugin-config/lsp-colors')
require('plugin-config/lsp-trouble')
require('plugin-config/lspsaga')
require('plugin-config/vacuumline')
require('plugin-config/gitsigns')
require('plugin-config/indent-guide-lines')

return packer
