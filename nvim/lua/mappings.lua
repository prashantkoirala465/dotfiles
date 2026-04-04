require "nvchad.mappings"

local map = vim.keymap.set

-- ── General ────────────────────────────────────────
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlights" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- ── Line Movement (Alt-j/k) ───────────────────────
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── Window Navigation (tmux-navigator compat) ─────
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Window left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Window down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Window up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Window right" })

-- ── Window Splits ──────────────────────────────────
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontal" })

-- ── Window Resize ──────────────────────────────────
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Resize up" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Resize down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize right" })

-- ── Buffer Navigation ──────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- ── Better Visual Indenting ────────────────────────
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ── Keep Cursor Centered ───────────────────────────
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })
map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Prev search centered" })

-- ── Yank/Paste Improvements ────────────────────────
map("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- ── Quickfix ───────────────────────────────────────
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })

-- ── Diagnostic ─────────────────────────────────────
map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Next diagnostic" })
map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Prev diagnostic" })
map("n", "<leader>cd", function() vim.diagnostic.open_float() end, { desc = "Line diagnostics" })
