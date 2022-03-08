require'nvim-treesitter.configs'.setup {
  ensure_installed = {"all"}
  ignore_install = {"haskell"}, -- broken
  highlight = {
    enable = true,              
  },
  rainbow = {
    enable = true,
    extended_mode = true, 
  } 
}
