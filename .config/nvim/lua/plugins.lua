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
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- surround vim
  use 'tpope/vim-surround'

  -- nerd commenter
  use 'scrooloose/nerdcommenter'

  -- status line
  use {
    'konapun/vacuumline.nvim', 
    requires = {
      {'glepnir/galaxyline.nvim', branch = 'main'},
      {'kyazdani42/nvim-web-devicons', opt = true}
  }, config = function() require('vacuumline.theme.one-dark').setup() 
  end} 

  -- dashboard
  use 'glepnir/dashboard-nvim'

  -- lsp config
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer'
  }

  -- for LSP autocompletion
  use 'hrsh7th/nvim-compe'

  -- telescope - searching / navigation
  -------------------------------------
  use {
    'nvim-telescope/telescope.nvim', 
    requires = {
      {'nvim-lua/popup.nvim'}, 
      {'nvim-lua/plenary.nvim'}
    }
  }
  -------------------
  --telescope project
  use {
    'nvim-telescope/telescope-project.nvim',
    config = function()
      require"telescope".load_extension("project")
    end
  }
  ------------------
  --telescope-github
  use {
    'nvim-telescope/telescope-github.nvim',
    config = function()
      require"telescope".load_extension("gh")
    end
  }
  ------------------------
  -- telescope media files
  use {
    'nvim-telescope/telescope-media-files.nvim',
    config = function()
      require"telescope".extensions.media_files.media_files()
    end
  }
  -----------------
  -- telescope-cheat
  use {
    'nvim-telescope/telescope-cheat.nvim',
    requires = 'tami5/sql.nvim',
    config = function()
      require"telescope".load_extension("cheat")
    end
  }

  -- better hotfix window (for showing and searching through results in telescope's find usages)
  use {"kevinhwang91/nvim-bqf"}

  -- better highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/playground'

  -- color-buddy
  use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- file explorer
  use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'}

  -- prettier tabs
  use 'romgrk/barbar.nvim'

  -- autopairs
  use 'windwp/nvim-autopairs'

  -- nice diagnostic pane on the bottom
  use 'folke/lsp-trouble.nvim'

  -- support the missing lsp diagnostic colors
  use 'folke/lsp-colors.nvim'

  -- better LSP UI (for code actions, rename etc.)
  use 'glepnir/lspsaga.nvim'

  -- terminal integration
  use 'akinsho/nvim-toggleterm.lua'

  -- indentation 
  use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}

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
require('plugin/lsp-trouble')
require('plugin/lspsaga')
require('plugin/vacuumline')
require('plugin/gitsigns')
require('plugin/neogit')
require('plugin/indent-guide-lines')

return packer
