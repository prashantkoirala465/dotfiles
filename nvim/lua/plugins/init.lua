return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "markdown",
        "markdown_inline",
        "yaml",
        "toml",
        "bash",
        "regex",
        "prisma",
        "graphql",
        "dockerfile",
        "gitcommit",
        "diff",
        "go",
        "gomod",
        "gosum",
      },
    },
  },

  -- Seamless tmux <-> nvim pane navigation with C-h/j/k/l
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
}
