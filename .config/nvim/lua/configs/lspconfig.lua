require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"
local angular_ls_setup = require("configs.custom.lsp.angularls").setup()

-- Habilita snippet support para CSS/SCSS
local scss_capabilities = vim.lsp.protocol.make_client_capabilities()
scss_capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Helper para encontrar root dir
local function find_root(patterns)
  return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
end

local servers = {
  angularls = angular_ls_setup,
  ts_ls = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    root_dir = find_root { "package.json", "tsconfig.json", ".git" },
    settings = {
      ts_ls = {
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = true },
        },
      },
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
  if opts then
    vim.lsp.config(name, opts)
  end
end

local enabled_servers = {}
for name, opts in pairs(servers) do
  if opts then
    table.insert(enabled_servers, name)
  end
end
vim.lsp.enable(enabled_servers)
