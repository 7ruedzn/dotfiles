local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    typescript = { { "prettierd, prettier" } },
    typescriptreact = { { "prettierd, prettier" } },
    javascript = { { "prettierd, prettier" } },
    javascriptreact = { { "prettierd, prettier" } },
    css = { { "prettierd, prettier" } },
    html = { { "prettierd, prettier" } },
    ["_"] = { "trim_whitespace" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
