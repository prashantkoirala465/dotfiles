# ── Prompt ──────────────────────────────────────────
eval "$(starship init zsh)"

# ── Completion ──────────────────────────────────────
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
bindkey '^I' complete-word

# ── History ─────────────────────────────────────────
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ── Plugins ─────────────────────────────────────────
BREW_PREFIX="/opt/homebrew"
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ── Environment ─────────────────────────────────────
export EDITOR="nvim"
export VISUAL="nvim"

# ── PATH ─────────────────────────────────────────────
export BUN_INSTALL="$HOME/.bun"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"

# ── Bun ─────────────────────────────────────────────
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ── FZF ─────────────────────────────────────────────
eval "$(fzf --zsh)"

fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() { fd --hidden --exclude .git . "$1" }
_fzf_compgen_dir() { fd --type=d --hidden --exclude .git . "$1" }

[[ -f ~/fzf-git.sh/fzf-git.sh ]] && source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ── Bat ─────────────────────────────────────────────
export BAT_THEME=ansi

# ── Eza ─────────────────────────────────────────────
alias ls="eza --icons=always"
alias ll="eza -la --icons=always --git"
alias lt="eza --tree --icons=always --level=2"
alias la="eza -a --icons=always"

# ── Git Aliases ─────────────────────────────────────
alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gds="git diff --staged"
alias gco="git checkout"
alias gsw="git switch"
alias gb="git branch"
alias gba="git branch -a"
alias glg="git log --oneline --graph --decorate -20"
alias gst="git stash"
alias gstp="git stash pop"
alias gundo="git reset --soft HEAD~1"
alias gamend="git commit --amend --no-edit"
alias lg="lazygit"

# ── Docker Aliases ──────────────────────────────────
alias dk="docker"
alias dkc="docker compose"
alias dkcu="docker compose up -d"
alias dkcd="docker compose down"
alias dkcl="docker compose logs -f"
alias dkps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"

# ── Navigation ──────────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias dots="cd ~/.config"
alias reset-dev="$HOME/.config/scripts/reset-dev.sh"
alias python="python3"

# ── Yazi (cd on exit) ──────────────────────────────
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ── Go Aliases ──────────────────────────────────────
alias gr="go run ."
alias gt="go test ./..."
alias gob="go build ./..."
alias gmt="go mod tidy"

# ── Node/NPM Aliases ──────────────────────────────
alias nr="npm run"
alias nt="npm test"
alias nd="npm run dev"
alias nb="npm run build"
alias ni="npm install"

# ── Mise (replaces nvm + direnv) ─────────────────
eval "$(mise activate zsh)"

# ── Project Switcher ──────────────────────────────
fp() {
  local dirs=()
  [[ -d "$HOME/projects" ]] && dirs+=("$HOME/projects")
  [[ -d "$HOME/work" ]] && dirs+=("$HOME/work")
  [[ -d "$HOME/dev" ]] && dirs+=("$HOME/dev")
  [[ ${#dirs[@]} -eq 0 ]] && dirs+=("$HOME")

  local project
  project=$(fd -t d --max-depth 1 . "${dirs[@]}" 2>/dev/null | fzf --preview 'eza --tree --color=always --level=2 {}' --header 'Pick a project')
  [[ -z "$project" ]] && return

  local name=$(basename "$project")
  if command -v tmux >/dev/null 2>&1 && [[ -n "$TMUX" ]]; then
    if ! tmux has-session -t "$name" 2>/dev/null; then
      tmux new-session -d -s "$name" -c "$project"
    fi
    tmux switch-client -t "$name"
  else
    builtin cd "$project"
  fi
}

# ── Dev Session Launcher ──────────────────────────
dev() {
  local dir="${1:-.}"
  [[ ! -d "$dir" ]] && dir=$(zoxide query "$1" 2>/dev/null)
  [[ -z "$dir" ]] && echo "Not found: $1" && return 1

  local name=$(basename "$dir")
  if ! tmux has-session -t "$name" 2>/dev/null; then
    tmux new-session -d -s "$name" -c "$dir"
    tmux send-keys -t "$name" "zed ." Enter
    tmux split-window -t "$name" -v -p 30 -c "$dir"
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$name"
  else
    tmux attach-session -t "$name"
  fi
}

# ── Atuin ───────────────────────────────────────────
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# ── Notes (quick scratch capture) ──────────────────
notes() {
  local dir="$HOME/notes"
  [[ -d "$dir" ]] || mkdir -p "$dir"

  if [[ $# -eq 0 ]]; then
    command ls -1t "$dir" 2>/dev/null | sed 's/\.md$//'
    return
  fi

  local name="$1"
  local file="$dir/${name}.md"
  local stamp
  stamp=$(date "+%Y-%m-%d %H:%M")

  if [[ ! -f "$file" ]]; then
    {
      print -- "# ${name}"
      print --
      print -- "## ${stamp}"
      print --
    } > "$file"
  else
    {
      print --
      print -- "## ${stamp}"
      print --
    } >> "$file"
  fi

  "${EDITOR:-nvim}" +'$' "$file"
}

# ── Misc ────────────────────────────────────────────
alias claude-mem='bun "/Users/prashantkoirala/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'

# ── Zoxide (MUST stay at the bottom per zoxide doctor) ──
eval "$(zoxide init zsh)"
alias cd="z"
