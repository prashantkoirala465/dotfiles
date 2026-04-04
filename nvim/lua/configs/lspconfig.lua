require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "tailwindcss",
  "eslint",
  "jsonls",
  "emmet_ls",
  "gopls",
}

vim.lsp.enable(servers)

-- Install these via Mason:
-- :MasonInstall typescript-language-server tailwindcss-language-server
-- :MasonInstall eslint-lsp json-lsp emmet-ls gopls
