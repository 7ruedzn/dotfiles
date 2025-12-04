require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- Habilita snippet support para CSS/SCSS
local scss_capabilities = vim.lsp.protocol.make_client_capabilities()
scss_capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Helper para encontrar root dir
local function find_root(patterns)
  return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
end

local servers = {
  angularls = {
    filetypes = { "html", "htmlangular" },
    on_attach = nvlsp.on_attach,
    capabilities = nvlsp.capabilities,
    on_init = nvlsp.on_init,
    cmd = {
      "node",
      vim.fn.expand "~/projects/web-faturamento/node_modules/@angular/language-server/index.js",
      "--stdio",
      "--tsProbeLocations",
      vim.fn.expand "~/projects/web-faturamento/node_modules",
      "--ngProbeLocations",
      vim.fn.expand "~/projects/web-faturamento/node_modules",
    },
  },
  cssls = {
    filetypes = { "css", "scss", "less" },
    capabilities = scss_capabilities,
    settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
    },
  },

  gopls = {
    on_attach = nvlsp.on_attach,
    capabilities = nvlsp.capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = find_root { "go.work", "go.mod", ".git" },
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = { unusedparams = true },
      },
    },
  },

  ts_ls = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  },

  eslint = {
    filetypes = { "typescript", "typescriptreact" },
    root_dir = find_root {
      ".eslintrc.json",
      ".eslintrc.js",
      ".eslintrc",
      "eslint.config.js",
      "package.json",
    },
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      nvlsp.on_attach(client, bufnr)
    end,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
      workingDirectory = { mode = "auto" },
      validate = "on",
      packageManager = "yarn",
      useESLintClass = true,
      format = false,
      quiet = false,
    },
  },

  csharp_ls = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    cmd = { "csharp-ls" },
    filetypes = { "cs", "csx" },
    root_dir = find_root { "*.sln", "*.csproj", ".git" },
  },

  jsonls = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  },

  lua_ls = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  },
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
end

vim.lsp.enable(vim.tbl_keys(servers))
