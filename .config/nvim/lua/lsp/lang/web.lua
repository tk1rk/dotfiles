local capabilities = require("lsp/capabilities")
local on_attach = require("lsp/lsp")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.js,*.jsx,*.ts,*.tsx,*.md,*.scss,*.yaml,*.yml,*.less,*.json,*.css,*.cjs",
  callback = function()
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))
    vim.cmd [[silent %!prettierd --stdin-filepath % ]]
    if vim.v.shell_error ~= 0 then
      vim.cmd.undo()
    end
    vim.api.nvim_win_set_cursor(0, { r, c })
  end
})

local servers = { "tsserver", "eslint", "cssls", "html", "jsonls", "svelte", "tailwindcss" }

for _, server in ipairs(servers) do
  require('lspconfig')[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

vim.cmd [[autocmd VimLeave * !killall prettierd]]
