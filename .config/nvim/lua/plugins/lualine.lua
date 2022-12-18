require("nvim-tree").setup()

require('lualine').setup {
  options = {
    theme = 'serenade',
    section_separators = '',
    component_separators = '',
    disabled_filetypes = { 'NvimTree' },
  },
}

require('telescope.builtin')
