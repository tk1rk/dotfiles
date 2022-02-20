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
    
    -- colorbuddy
    use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

    -- Impatient
    use { 'lewis6991/impatient.nvim' }

    -- lspconfig
    use { 'neovim/nvim-lspconfig' }

    -- sqlite
    use { "tami5/sqlite.lua" }

    -- fuzzy-finder
    use { 'cljoly/telescope-repo.nvim' }
    use { 'nvim-telescope/telescope.nvim', 
      requires = { 
        {'nvim-lua/plenary.nvim'} 
      }
    }

    use { 'nvim-telescope/telescope-fzf-native.nvim', 
      run = 'make', 
      config = function() 
        require"plugins/telescope".load_extension("fzf-native")
      end
    }

    use { 'nvim-telescope/telescope-media-files.nvim', 
      config = function() 
        require"plugins/telescope".load_extension("media-files")
        end
    }

    use {
      "nvim-telescope/telescope-frecency.nvim",
        requires = { 
          {"tami5/sqlite.lua"}, 
          {'kyazdani42/nvim-web-devicons'} 
        },
        config = function()   
          require"telescope".load_extension("frecency")
        end,
    }
    
    use { "nvim-telescope/telescope-file-browser.nvim" }

    use { 'pwntester/octo.nvim', 
      requires = { 
        {'nvim-lua/plenary.nvim'}, 
        {'nvim-telescope/telescope.nvim'}, 
        {'kyazdani42/nvim-web-devicons'} 
      }, 
      config = function () 
        require"octo".setup() 
      end 
    }

    -- vacuumline
    
    

    -- chadtree
    use { 'ms-jpq/chadtree', branch = 'chad', 
      run = 'python3 -m chadtree deps'
    } 

    -- completions
    use {'haorenW1025/completion-nvim', opt = true, 
      requires = { 
        {'hrsh7th/vim-vsnip', opt = true}, 
        {'hrsh7th/vim-vsnip-integ', opt = true} 
      }
    }

    -- Theme/Dracula
    use { 'Mofiqul/Dracula.nvim, as = 'dracula' }
    
    -- neogit
    use { 'TimUntersberger/neogit', 
      requires = {
        {'nvim-lua/plenary.nvim'} 
      }
    }


  end
 )

lua require'colorizer'.setup()


end
 )
