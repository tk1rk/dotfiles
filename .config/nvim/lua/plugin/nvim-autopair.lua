require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" },
})
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

_G.MUtils= {}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<c-r>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end
