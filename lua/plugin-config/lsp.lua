local config = {}

-- lsp
function config:configLSP()
  local util = require("lspconfig/util")

  local servers = {
    "jsonls",
    "clangd",
    "pyright",
    "vimls",
    "html",
    "cssls"
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  for _, server in ipairs(servers) do
    require("lspconfig")[server].setup {
      capabilities = capabilities
    }
  end

  require "lspconfig".pyright.setup {
    capabilities = capabilities
  }

  require "lspconfig".gopls.setup {
    capabilities = capabilities,
    cmd = {"gopls"},
    filetypes = {"go", "gomod"},
    root_dir = function(fname)
      return util.root_pattern("go.mod", ".git")(fname) or util.path.dirname(fname)
    end,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true
        },
        staticcheck = true
      }
    }
  }
end

config:configLSP()
