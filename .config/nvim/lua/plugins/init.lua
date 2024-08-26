return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
    config = function()
      require "configs.custom.noice"
    end,
  },
  {
    "folke/trouble.nvim",
    --branch = "dev", -- IMPORTANT!
    keys = {
      {
        "<leader>d",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>db",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>ds",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>dd",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>dl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>dk",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
  },
  {
    "folke/trouble.nvim",
  },
  {
    "artemave/workspace-diagnostics.nvim",
  },
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufRead",
    config = function() --Enables the plugin
      require("todo-comments").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require "configs.custom.autotags"
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    event = "VeryLazy",
    dependencies = {
      --You may not need this if you don't lazy load
      --Or if the parsers are in your $RUNTIMEPATH
      -- "nvim-treesitter/nvim-treesitter",
      -- "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    -- dependencies = {
    --   {
    -- "nvim-telescope/telescope-live-grep-args.nvim",
    -- This will not install any breaking changes.
    -- For major updates, this must be adjusted manually.
    -- version = "^1.0.0",
    -- },
    -- },
    -- config = function()
    -- require("telescope").load_extension("live_grep_args")
    -- require "configs.custom.live_grep_args"
    -- end
  },
  -- {
  --   "mg979/vim-visual-multi",
  --   event = "VeryLazy",
  --   config = function ()
  --
  --   end
  -- },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "prettier",
        "angular-language-server",
        "clangd",
        "typescript-language-server",
        "css-lsp",
        "css-variables-language-server",
        "cssmodules-language-server",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "scss",
        "cpp",
        "javascript",
        "typescript",
        "tsx",
      },
    },
  },
}
