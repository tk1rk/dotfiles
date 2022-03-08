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
  }, config = function() require('vacuumline.theme.one-dark').setup() end}

  -- dashboard
  use 'glepnir/dashboard-nvim'

  -- lsp config
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }

  -- for LSP autocompletion
  use { 'nvim-lua/completion-nvim' }

  -- TODO: prettify telescope vim, make it use regex & shorten the window
  -- telescope - searching / navigation
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- fidget (lsp progress spinner)
  use { 'j-hui/fidget.nvim', config = function() require"fidget".setup{} }

  -- better hotfix window (for showing and searching through results in telescope's find usages)
  use {'kevinhwang91/nvim-bqf'}

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
require('plugin/nvim-compe')
require('plugin/telescope')
require('plugin/chadtree')
require('plugin/nvim-treesitter')
require('plugin/barbar')
require('plugin/lsp-colors')
require('plugin/fidget')
require('plugin/lsp-trouble')
require('plugin/lspsaga')
require('plugin/dashboard')
require('plugin/vacuumline')
require('plugin/gitsigns')
require('plugin/indent-guide-lines')

return packer
