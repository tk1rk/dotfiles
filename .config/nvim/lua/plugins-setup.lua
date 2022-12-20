local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
    return require("packer.util").float({ border = "rounded" })
  end,
  },
})

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '~/.local/share/nvim/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

    -- startup dashboard
  use 'glepnir/dashboard-nvim'

  -- Theme
  use 'Mofiqul/dracula.nvim' 

  -- Statusline
  use {'konapun/vacuumline.nvim', branch = 'next', requires = {
    'glepnir/galaxyline.nvim', branch = 'main',
    'kyazdani42/nvim-web-devicons', opt = true
  }, config = function() require('vacuumline').setup() end} -- Add this line to use defaults; otherwise, call `setup` with your config as described below wherever you configure your plugins

  --file explorer
  use {'nvim-tree/nvim-tree.lua', requires = {
    'nvim-tree/nvim-web-devicons',
    'konapun/vacuumline.nvim' }
  }

  -- LSP Configuration & Plugins
  use {'neovim/nvim-lspconfig', requires = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- Useful status updates for LSP
    'j-hui/fidget.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
      {"L3MON4D3/LuaSnip",
        wants = {
          "friendly-snippets",
          "vim-snippets",
        },
      },
    'rafamadriz/friendly-snippets',
    'honza/vim-snippets',
    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag',
    'saadparwaiz1/cmp_luasnip'}
    },
  }

  -- formatting and diagnostic
  use {'jose-elias-alvarez/null-ls.nvim',
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  },

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- save readonly files
  use 'lambdalisue/suda.vim'

  -- indent
  use `lukas-reineke/indent-blankline.nvim`

  -- mkdir
  use 'jghauser/mkdir.nvim'

  -- sxhkd
  use 'baskerville/vim-sxhkdrc'

  -- File specific helpers
  use 'elkowar/yuck.vim'
  use {'Fymyte/rasi.vim',
    ft = { "rasi" }, run = ":TSInstall rasi"
  },

  -- formatting
  use {'gpanders/nvim-parinfer'}

  -- Syntax Highlighting
  use {'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use {'b4skyx/serenade', 
    wants = {'nvim-treesitter'},
    requires = {'nvim-treesitter/nvim-treesitter', 'cespare/vim-toml'}
  }

  -- rust tools
  use 'simrat39/rust-tools.nvim'

  -- telescope
  use {'nvim-telescope/telescope.nvim', 
    requires = {'nvim-lua/plenary.nvim'}
  }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- icon picker
  use 'stevearc/dressing.nvim'
  use {'ziontee113/icon-picker.nvim',
    config = function()
      require("icon-picker").setup({disable_legacy_commands = true})
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  } })
\& 
