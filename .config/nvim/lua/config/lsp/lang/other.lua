local capabilities = require("lsp/capabilities")
local on_attach = require("lsp/lsp")

local servers = { "dockerls", "texlab", "bashls", "clangd", "pyright" }

for _, server in ipairs(servers) do
  require('lspconfig')[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
