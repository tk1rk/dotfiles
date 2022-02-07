require('maps')
require('settings')
require('status')
require('utils')

cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
-- This will load fzy_native and have it override the default file sorter
require('telescope').load_extension('fzf_native')
paq {'savq/paq-nvim', opt = true}    -- paq-nvim manages itself

paq {
    'nvim-treesitter/nvim-treesitter';
    'neovim/nvim-lspconfig';
    'junegunn/fzf', run = fn['fzf#install'];
    'junegunn/fzf.vim';
 
    'ojroques/nvim-lspfuzzy';
    'nvim-lua/popup.nvim';
    'nvim-telescope/telescope.nvim';
    'nvim-telescope/telescope-fzf-writer.nvim';
    'nvim-lua/plenary.nvim';
    'rust-analyzer/rust-analyzer';



-- truecolor
if has('nvim') || has('termguicolors')
  set termguicolors
endif
