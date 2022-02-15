local custom_dracula-nvim = require'lualine.themes.dracula-nvim'

-- Change the background of lualine_c section for normal mode
custom_dracula-nvim.normal.c.bg = '#1ACE53'

require('lualine').setup {
  options = {
    -- ...
    theme = 'dracula-nvim'
    -- ...
  }
}'
