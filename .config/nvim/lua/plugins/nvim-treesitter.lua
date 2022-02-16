require'nvim-treesitter.configs'.setup {
  refactor = {
    ensure_installed = "maintained",
    highlight = { 
      enable = true 
    },
    highlight_definitions = { 
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
  
}
