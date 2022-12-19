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



return require('packer').startup({ function(use)
  use {'wbthomason/packer.nvim'}

  -- startup dashboard
  use {'glepnir/dashboard-nvim'}

  -- save readonly files
  use {'lambdalisue/suda.vim'}

  use {'jghauser/mkdir.nvim'}

  use {'baskerville/vim-sxhkdrc'}

  use {'elkowar/yuck.vim'}

  use { 
    'Fymyte/rasi.vim',
      ft = { "rasi" },
      run = ":TSInstall rasi"
  },

  use {'gpanders/nvim-parinfer'}

  -- formatting and diagnostic
  use { 
    'jose-elias-alvarez/null-ls.nvim',
      after = "nvim-lspconfig",
      config = function()
	  require("custom.plugins.null-ls").setup()
     end,
  },



  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lualine/lualine.nvim'
    }
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
      {
        "L3MON4D3/LuaSnip",
        wants = {
          "friendly-snippets",
          "vim-snippets",
        },
      },
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
      'windwp/nvim-autopairs',
      'windwp/nvim-ts-autotag',
      'saadparwaiz1/cmp_luasnip',
    }
  }

  use { 'b4skyx/serenade',
    wants = {
      "nvim-treesitter"
    },
    requires = {
      'nvim-treesitter/nvim-treesitter',
      'cespare/vim-toml'
    }
  }

  use 'simrat39/rust-tools.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use "stevearc/dressing.nvim"
  use({
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
  })

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
