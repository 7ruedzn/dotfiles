require("nvchad.configs.lspconfig").defaults()

local util = require "lspconfig/util"
local nvlsp = require "nvchad.configs.lspconfig"

--Enable (broadcasting) snippet capability for completion
local scss_capabilities = vim.lsp.protocol.make_client_capabilities()
scss_capabilities.textDocument.completion.completionItem.snippetSupport = true

--INFO: Get node modules from current project. NEEDS to install the LSP on the web-project
-- with npm i -D @angular/language-server@15.2.1 (version can vary)
local node_modules = util.path.join(vim.fn.getcwd(), "node_modules")

local servers = {
  angularls = {
    cmd = {
      "ngserver",
      "--stdio",
      "--tsProbeLocations",
      node_modules,
      "--ngProbeLocations",
      node_modules,
    },
  },
  html = {},
  cssls = {
    filetypes = { "css", "scss", "less" },
    capabilities = scss_capabilities,
    settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
    },
  },
  sql = {
    filetypes = { "sql" },
    capabilities = nvlsp.capabilities,
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
  },
  gopls = {
    on_attach = nvlsp.on_attach,
    capabilities = nvlsp.capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  },
  ts_ls = {
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    on_attach = function(client, bufnr)
      require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
    end,
  },
  csharp_ls = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    cmd = { "csharp-ls" },
    filetypes = { "cs", "csx" },
    root_dir = util.root_pattern("*.sln", "*.csproj", ".git"),
  },
  json_lsp = {},
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
