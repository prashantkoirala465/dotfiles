# Zed Neovim Cheatsheet

> Leader key = `Space` | Normal mode unless noted | `C-` = Ctrl | `S-` = Shift

---

## Files & Buffers

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (fuzzy finder) |
| `<leader><space>` | Find files (alias) |
| `<leader>,` | Switch open buffers |
| `<leader>bb` | Switch open buffers (alias) |
| `<leader>bd` | Close current buffer |
| `<leader>w` | Save file |
| `<leader>q` | Close buffer/tab |

## Search & Grep

| Key | Action |
|-----|--------|
| `<leader>/` | Project-wide search (grep) |
| `<leader>sg` | Project-wide search (alias) |
| `<leader>ss` | File outline / symbols |
| `<leader>sS` | Project-wide symbols |
| `<leader>sb` | Search in current buffer |
| `/` / `?` | Vim forward/backward search |
| `*` / `#` | Search word under cursor |

## Panels

| Key | Action |
|-----|--------|
| `<leader>e` | File explorer (project panel) |
| `<leader>gg` | Git panel |
| `<leader>tt` | Terminal panel |
| `<leader>dd` | Debug panel |
| `<leader>xx` | Diagnostics panel |
| `<leader>aa` | AI Agent panel |
| `Alt-d` | Toggle bottom dock |
| `Space` or `Esc` | Close focused panel (explorer/git/debug) |

## LSP / Code Actions

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gy` | Go to type definition |
| `gI` | Go to implementation |
| `gA` | Go to all references |
| `gs` | File symbols |
| `gS` | Project symbols |
| `gh` or `K` | Hover documentation |
| `g.` | Open code actions |
| `cd` | Rename symbol |
| `<leader>ca` | Code actions (leader) |
| `<leader>cr` | Rename symbol (leader) |
| `<leader>cf` | Format file |
| `<leader>lr` | Restart language server |

## Diagnostics

| Key | Action |
|-----|--------|
| `]d` or `g]` | Next diagnostic |
| `[d` or `g[` | Previous diagnostic |
| `<leader>xj` | Next diagnostic (leader) |
| `<leader>xk` | Previous diagnostic (leader) |
| `<leader>xx` | Open diagnostics panel |
| `:cn` / `:cp` | Next/previous in quickfix |

## Git (Built-in)

| Key | Action |
|-----|--------|
| `]c` | Next git change (hunk) |
| `[c` | Previous git change |
| `do` | Expand/view diff hunk |
| `dO` | Toggle staged |
| `du` | Stage and next (diff view) |
| `dU` | Unstage and next |
| `dp` | Revert hunk |
| `<leader>gg` | Git panel |
| `:G` / `:Git` | Open git panel (ex) |

## Sneak (Two-char Search)

| Key | Action |
|-----|--------|
| `s{char}{char}` | Sneak forward to match |
| `S{char}{char}` | Sneak backward to match |
| `;` | Repeat sneak forward |
| `,` | Repeat sneak backward |

> Replaces default `s` (use `cl` instead) and `S` (use `cc` instead)

## Surround

| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Add surround (e.g., `ysiw"`) |
| `cs{old}{new}` | Change surround (e.g., `cs"'`) |
| `ds{char}` | Delete surround (e.g., `ds"`) |
| `S{char}` (visual) | Surround selection |

## Multi-Cursor

| Key | Action |
|-----|--------|
| `gl` | Add cursor at next word match |
| `gL` | Add cursor at prev word match |
| `ga` | Select all matches of word |
| `g>` | Skip current, add next match |
| `g<` | Skip current, add prev match |
| Visual `gA` | Cursor at end of every selected line |
| Visual `gI` | Cursor at start of every selected line |

## Text Objects (Tree-sitter)

| Object | Inner | Around |
|--------|-------|--------|
| Function/method | `if` | `af` |
| Class/definition | `ic` | `ac` |
| Argument/param | `ia` | `aa` |
| HTML tag | `it` | `at` |
| Indent level | `ii` | `ai` / `aI` |
| Comment | — | `gc` |
| Any quotes | — | Bind `vim::AnyQuotes` |
| Any brackets | — | Bind `vim::AnyBrackets` |

## Motions (Tree-sitter)

| Key | Action |
|-----|--------|
| `]m` / `[m` | Next/prev method start |
| `]M` / `[M` | Next/prev method end |
| `]]` / `[[` | Next/prev section |
| `]/` / `[/` | Next/prev comment |
| `]x` | Select smaller syntax node |
| `[x` | Select larger syntax node |

## Comment

| Key | Action |
|-----|--------|
| `gcc` | Toggle comment (line) |
| `gc{motion}` | Toggle comment (motion) |
| Visual `gc` | Toggle comment (selection) |

## Window / Pane Management

| Key | Action |
|-----|--------|
| `C-w v` or `:vs` | Split vertically |
| `C-w s` or `:sp` | Split horizontally |
| `C-w h/j/k/l` | Navigate panes (vim) |
| `C-h/j/k/l` | Navigate panes (tmux-style, works everywhere) |
| `C-w q` | Close pane |
| `C-w gd` | Go to definition in split |
| `C-w gD` | Go to type definition in split |

## Tabs

| Key | Action |
|-----|--------|
| `H` (Shift-h) | Previous tab |
| `L` (Shift-l) | Next tab |
| `[[` | Move tab left |
| `]]` | Move tab right |

## Terminal

| Key | Action |
|-----|--------|
| `<leader>tt` | Toggle terminal focus |
| `Escape` | Return to editor (from terminal) |
| `Shift-Space` | Toggle vi mode in terminal |
| `C-n` | New terminal tab |

## Debugger

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dd` | Debug panel |
| `<leader>dg` | Start debugger |
| `<leader>dc` | Continue |
| `<leader>dn` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dr` | Restart |
| `<leader>ds` | Stop |

## Toggle UI

| Key | Action |
|-----|--------|
| `<leader>uw` | Toggle word wrap |
| `<leader>uh` | Toggle inlay hints |
| `:set wrap` | Enable word wrap (ex) |
| `:set nowrap` | Disable word wrap (ex) |
| `:set relativenumber` | Relative line numbers (ex) |

## Insert Mode

| Key | Action |
|-----|--------|
| `jk` | Escape to normal mode |
| `C-x C-o` | Trigger completion |
| `C-x C-c` | Copilot suggestion |
| `C-x C-a` | Inline AI assistant |
| `C-x C-l` | Code actions |
| `C-x C-z` | Hide suggestions |

## Ex Commands

| Command | Action |
|---------|--------|
| `:w` / `:W` | Save (alias catches typo) |
| `:q` / `:Q` | Quit |
| `:wq` / `:Wq` | Save and quit |
| `:wa` | Save all |
| `:qa` | Quit all |
| `:bd` | Close buffer |
| `:E` | File explorer |
| `:G` | Git panel |
| `:te` | Terminal |
| `:clist` | Diagnostics |
| `:<n>` | Go to line n |
| `:s/foo/bar/g` | Substitute (uses Zed regex) |
| `:sort` | Sort lines |

## Settings Summary

| Setting | Value | Why |
|---------|-------|-----|
| Relative line numbers | Auto-toggle | Relative in normal, absolute in insert |
| Clipboard | `on_yank` | Only `y` copies to system clipboard, `d`/`c` don't |
| Smartcase find | Enabled | `f`/`t` case-insensitive for lowercase |
| Scroll margin | 8 lines | Like `scrolloff` — keeps context around cursor |
| Cursor blink | Off | Solid cursor, standard vim |
| Scrollbar | Hidden | Navigate by motion, not mouse |
| Inline blame | On | See git blame inline |
| Inlay hints | On | Type hints for TS/Rust/etc |
| Indent guides | On | Visual indent structure |
| Yank highlight | 250ms | Brief flash on yank |
| Command aliases | `:W` `:Q` etc | Catches shift-key typos |
