require("noice").setup {
  -- Desabilita tudo exceto cmdline
  cmdline = {
    enabled = true, -- Habilita cmdline customizado
    view = "cmdline_popup", -- Estilo de popup para todos os cmdlines
    opts = {}, -- global options for the cmdline
    format = {
      -- Comando normal usa popup (centro)
      cmdline = { pattern = "^:", icon = "", lang = "vim" },
      -- Search down usa popup (centro)
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
      -- Search up usa popup (centro)
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
      -- Filter
      filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
      -- Lua commands
      lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
      -- Help
      help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
      -- Input (desabilitado - Snacks cuida)
      input = false,
    },
  },
  messages = {
    enabled = false, -- Desabilita messages (Snacks notifier cuida disso)
  },
  popupmenu = {
    enabled = true, -- Habilita popupmenu para cmdline completion
    backend = "nui", -- backend to use to show regular cmdline completions
  },
  notify = {
    enabled = false, -- Desabilita notify (Snacks notifier cuida disso)
  },
  lsp = {
    progress = {
      enabled = false, -- Desabilita LSP progress (Snacks cuida disso)
    },
    override = {
      -- Override para markdown rendering (mantém compatibilidade com cmp)
      ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
      ["vim.lsp.util.stylize_markdown"] = false,
      ["cmp.entry.get_documentation"] = false,
    },
    hover = {
      enabled = false, -- Desabilita hover (mantém nativo)
    },
    signature = {
      enabled = false, -- Desabilita signature (mantém nativo)
    },
  },
  presets = {
    bottom_search = false, -- Não usa bottom search (todos usam popup no centro)
    command_palette = false, -- Não usa command palette
    long_message_to_split = false, -- Mensagens longas não vão para split
    inc_rename = false, -- Não usa inc_rename (Snacks cuida disso)
    lsp_doc_border = false, -- Não adiciona border em hover/signature
  },
  routes = {
    -- Filtra mensagens para não conflitar com Snacks
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" }, -- Mensagens de save
          { find = "written" }, -- Mensagens de arquivo escrito
        },
      },
      opts = { skip = true }, -- Pula essas mensagens
    },
  },
}

