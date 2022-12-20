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

# Plugins
return require('packer').startup({ function(use)
  use {'wbthomason/packer.nvim'}

  -- startup dashboard
  use {'glepnir/dashboard-nvim'}

  -- Theme
  use { 'Mofiqul/dracula.nvim' }

  -- Statusline
  use {'konapun/vacuumline.nvim', branch = 'next', requires = {
    'glepnir/galaxyline.nvim', branch = 'main',
    'kyazdani42/nvim-web-devicons', opt = true
  }, config = function() require('vacuumline').setup() end} -- Add this line to use defaults; otherwise, call `setup` with your config as described below wherever you configure your plugins


  -- save readonly files
  use {'lambdalisue/suda.vim'}

  -- mkdir
  use {'jghauser/mkdir.nvim'}

  -- sxhkd
  use {'baskerville/vim-sxhkdrc'}

  -- File specific helpers
  use {'elkowar/yuck.vim'}
  use {'Fymyte/rasi.vim',
    ft = { "rasi" }, run = ":TSInstall rasi"
  },

  -- formatting
  use {'gpanders/nvim-parinfer'}

  -- formatting and diagnostic
  use {'jose-elias-alvarez/null-ls.nvim',
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  },

  --file explorer
  use {'nvim-tree/nvim-tree.lua', requires = {
    'nvim-tree/nvim-web-devicons',
    'konapun/vacuumline.nvim' }
  }

  --code correction
  use {'neovim/nvim-lspconfig', requires = {
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
  }

  -- Syntax Highlighting
  use {'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use { 'b4skyx/serenade', 
    wants = {'nvim-treesitter'},
    requires = {'nvim-treesitter/nvim-treesitter', 'cespare/vim-toml'}
  }

  -- rust tools
  use 'simrat39/rust-tools.nvim'

  -- telescope
  use {'nvim-telescope/telescope.nvim', 
    requires = {'nvim-lua/plenary.nvim'}
  }

  -- icon picker
  use {'stevearc/dressing.nvim'}
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
