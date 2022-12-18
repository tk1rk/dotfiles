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

return require('packer').startup({ function(use)
  use 'wbthomason/packer.nvim'

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
