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

packer.startup(function()
  local use = use
   
    -- packer.nvim -----------------------
    use {'wbthomason/packer.nvim', opt = true}
   
    -- Treesitter -----------------------
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
    use { 'nvim-treesitter/nvim-treesitter-refactor' }
    use { 'p00f/nvim-ts-rainbow' }

    -- polyglot --------------------------
    use { 'sheerun/vim-polyglot' }
    
    -- colorbuddy -----------------------
    use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

    -- colorizer -----------------------
    use {'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup()}

    -- lsp-colors -----------------------
    use { 'folke/lsp-colors.nvim', config = function() require('lspfuzzy').setup {} }

    -- Impatient -----------------------
    use { 'lewis6991/impatient.nvim' }

    -- lspconfig -----------------------
    use { 'neovim/nvim-lspconfig' }

    -- sqlite -----------------------
    use { 'tami5/sqlite.lua' }

    -- plenary.nvim -------------------------
    use { 'nvim-lua/plenary.nvim' }

    -- telescope.nvim -----------------------
    use { 'cljoly/telescope-repo.nvim' }
    use { 'nvim-telescope/telescope.nvim', requires = { 
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-github.nvim' },
      { 'nvim-telescope/telescope-symbols.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-media-files.nvim' },
      { 'nvim-telescope/telescope-frecency.nvim', requires = { 
        {'tami5/sqlite.lua'}, 
        {'kyazdani42/nvim-web-devicons'}} 
      },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'pwntester/octo.nvim', requires = { 
        {'nvim-lua/plenary.nvim'}, 
        {'nvim-telescope/telescope.nvim'}, 
        {'kyazdani42/nvim-web-devicons'} 
      }, config = function() require'octo'.setup() end} 
      },
      { 'nvim-telescope/telescope-ui-select.nvim' }
    }}

    -- fzf ----------------------------
    use { 'junegunn/fzf', run = './install --bin', requires = {
      {'junegunn/fzf.vim'} }
    }

    -- fzf.lua -----------------------
    use { 'ibhagwan/fzf-lua',requires = { 
      {'kyazdani42/nvim-web-devicons'} }
    }

    -- lspfuzzy -----------------------
    use { 'ojroques/nvim-lspfuzzy', requires = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'} }
    }

    -- bubblystatus -----------------------
    use {'datwaft/bubbly.nvim', config = function()
      vim.g.bubbly_palette = {
        background = '#282a36',
        foreground = '#f8f8f2',
        black = '#3e4249',
        red = '#ff5555',
        green = '#50fa7b',
        yellow = '#f1fa8c',
        blue = '#6cb6eb',
        purple = '#bd93f9',
        cyan = '#8be9fd',
        white = '#c5cdd9',
        lightgrey = '#57595e',
        darkgrey = '#404247',
       },
       vim.g.bubbly_statusline = {
         'mode',

         'truncate',

         'path',
         'branch',
         'signify',
         'gitsigns',
         'coc',

         'divisor',

         'filetype',
         'progress',
       } 
       end }
     

    -- chadtree -----------------------
    use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'} 

    -- completions -----------------------
    use {'haorenW1025/completion-nvim', opt = true, requires = { 
      {'hrsh7th/vim-vsnip', opt = true}, 
      {'hrsh7th/vim-vsnip-integ', opt = true} }
    }
 
    -- luadev -----------------------
    use 'folke/lua-dev.nvim'

    -- coq.nvim -----------------------
    use {'ms-jpq/coq_nvim', branch = 'coq', run =: ':COQnow -s'}}
    -- 9000+ Snippets
    use {'ms-jpq/coq.artifacts', branch = 'artifacts'}

    -- Theme/Dracula -----------------------
    use { 'Mofiqul/Dracula.nvim, as = 'dracula' }
    
    -- terminal
    use { 's1n7ax/nvim-terminal', config = function()
      vim.o.hidden = true
      require('nvim-terminal').setup()
      end,
    }
      
    -- neogit -----------------------
    use { 'TimUntersberger/neogit', requires = {
      {'nvim-lua/plenary.nvim'} }
    }


  end
 )




end
 )
