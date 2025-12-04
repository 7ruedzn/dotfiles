local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    scss = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    -- go = { "gopls" },
    sql = { "sqlfmt" },
    ["_"] = { "trim_whitespace" },
  },
  format_on_save = {
    timeout_ms = 3000,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
