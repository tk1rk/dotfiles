local capabilities = require("lsp/capabilities")
local on_attach = require("lsp/lsp")
local opts = {
  tools = { -- rust-tools options
    autoSetHints = true,
    inlay_hints = {
      parameter_hints_prefix = "« ",
      other_hints_prefix = "» ",
      highlight = "NonText",
    },
  },
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importPrefix = "by_self",
        },
        cargo = {
          loadOutDirsFromCheck = true,
          allFeatures = true
        },
        procMacro = {
          enable = true
        },
        checkOnSave = {
          command = "clippy"
        },
        diagnostics = {
          enable = true,
          disabled = { "unresolved-proc-macro" },
          enableExperimental = true,
        },
      }
    }
  },
}
require('rust-tools').setup(opts)
