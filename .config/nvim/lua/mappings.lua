require "nvchad.mappings"

local map = vim.keymap.set

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Setup language servers.
-- local lspconfig = require "lspconfig"
-- lspconfig.ts_ls.setup {}
-- lspconfig.csharp_ls.setup {}

-- Diagnostics navigation
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- LSP mappings complementares ao Snacks
-- Snacks já cuida de: gd, gD, gr, gI, gy, símbolos LSP
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    -- Hover documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- Signature help
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    -- Code actions (Snacks pode não cobrir todas as situações)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
  end,
})

--Toggle terminal
map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

--Toggle float terminal 2
vim.keymap.set("n", "<A-f>", "<Cmd>FloatermToggle<CR>", { desc = "Toggle float terminal" })

--ZEN mode
vim.keymap.set("n", "<space>tz", "<Cmd>ZenMode<CR>", { desc = "Toggle Zen Mode" })

-- Sobrescreve mapeamentos do NvChad para usar Snacks
-- Precisa estar aqui porque mappings.lua carrega depois dos plugins
vim.schedule(function()
  local Snacks = require "snacks"
  
  -- Find commands (sobrescreve Telescope do NvChad)
  map("n", "<leader>fa", function()
    Snacks.picker.smart()
  end, { desc = "Find All Files" })
  
  map("n", "<leader>ff", function()
    Snacks.picker.files()
  end, { desc = "Find Files" })
  
  map("n", "<leader>fw", function()
    Snacks.picker.grep_word()
  end, { desc = "Find Word" })
  
  map("n", "<leader>fz", function()
    Snacks.picker.grep()
  end, { desc = "Find in Files (live grep)" })
  
  map("n", "<leader>fo", function()
    Snacks.picker.recent()
  end, { desc = "Find Old Files (recent)" })
  
  map("n", "<leader>fh", function()
    Snacks.picker.help()
  end, { desc = "Find Help Pages" })
  
  map("n", "<leader>fb", function()
    Snacks.picker.buffers()
  end, { desc = "Buffers" })
  
  map("n", "<leader>ma", function()
    Snacks.picker.marks()
  end, { desc = "Marks" })
  
  map("n", "<leader>cm", function()
    Snacks.picker.commands()
  end, { desc = "Commands" })
  
  map("n", "<leader>pt", function()
    Snacks.picker.colorschemes()
  end, { desc = "Pick Theme" })
end)
