#!/usr/bin/env bash
# reset-dev.sh — weekly maintenance for a 10x dev box
#
# Runs: brew update/upgrade/cleanup, mise upgrade, cache pruning,
# claude-mem compaction, atuin sync, disk usage reporting.
#
# Usage: reset-dev.sh [--dry-run] [--skip-brew] [--skip-caches]
#
# Safe to run repeatedly. Nothing here is destructive beyond well-known
# caches (~/.cache/uv, ~/.cache/chroma, ~/.cache/giget) that tools
# repopulate on demand.

set -euo pipefail

DRY_RUN=0
SKIP_BREW=0
SKIP_CACHES=0

for arg in "$@"; do
  case "$arg" in
    --dry-run)     DRY_RUN=1 ;;
    --skip-brew)   SKIP_BREW=1 ;;
    --skip-caches) SKIP_CACHES=1 ;;
    -h|--help)
      sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "unknown arg: $arg" >&2
      exit 2
      ;;
  esac
done

# ── Colors ────────────────────────────────────────────
if [[ -t 1 ]]; then
  BOLD=$'\033[1m'; DIM=$'\033[2m'; CYAN=$'\033[36m'
  GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'; RESET=$'\033[0m'
else
  BOLD=''; DIM=''; CYAN=''; GREEN=''; YELLOW=''; RED=''; RESET=''
fi

section() { printf '\n%s══ %s %s\n' "$CYAN$BOLD" "$1" "$RESET"; }
ok()      { printf '%s  ✓%s %s\n' "$GREEN" "$RESET" "$1"; }
warn()    { printf '%s  ⚠%s %s\n' "$YELLOW" "$RESET" "$1"; }
err()     { printf '%s  ✗%s %s\n' "$RED" "$RESET" "$1"; }
note()    { printf '%s  · %s%s\n' "$DIM" "$1" "$RESET"; }

run() {
  if (( DRY_RUN )); then
    note "would run: $*"
  else
    "$@"
  fi
}

# ── Disk usage helper ────────────────────────────────
du_of() {
  local path="$1"
  [[ -e "$path" ]] || { echo "0B"; return; }
  du -sh "$path" 2>/dev/null | awk '{print $1}'
}

# ── Start ─────────────────────────────────────────────
START_TIME=$(date +%s)
printf '%s%s reset-dev · %s %s\n' "$BOLD" "$CYAN" "$(date '+%Y-%m-%d %H:%M')" "$RESET"
(( DRY_RUN )) && warn "DRY RUN — no changes will be made"

# ── Homebrew ──────────────────────────────────────────
if (( ! SKIP_BREW )) && command -v brew >/dev/null 2>&1; then
  section "Homebrew"

  BEFORE_BREW=$(du_of /opt/homebrew)
  note "current /opt/homebrew size: $BEFORE_BREW"

  run brew update
  OUTDATED_COUNT=$(brew outdated 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$OUTDATED_COUNT" -gt 0 ]]; then
    note "outdated packages: $OUTDATED_COUNT"
    run brew upgrade
  else
    ok "nothing outdated"
  fi
  run brew cleanup --prune=all
  run brew autoremove
  if brew doctor >/dev/null 2>&1; then
    ok "brew doctor clean"
  else
    warn "brew doctor has warnings — run manually: brew doctor"
  fi

  AFTER_BREW=$(du_of /opt/homebrew)
  note "final /opt/homebrew size: $AFTER_BREW"
else
  (( SKIP_BREW )) && note "skipping brew (--skip-brew)" || warn "brew not installed"
fi

# ── Mise ──────────────────────────────────────────────
if command -v mise >/dev/null 2>&1; then
  section "Mise (runtime versions)"
  run mise self-update -y || warn "mise self-update failed"
  run mise upgrade || warn "mise upgrade failed"
  mise current 2>/dev/null | sed 's/^/    /' || true
else
  note "mise not installed, skipping"
fi

# ── Caches ────────────────────────────────────────────
if (( ! SKIP_CACHES )); then
  section "Caches"
  for cache in ~/.cache/uv ~/.cache/chroma ~/.cache/giget; do
    if [[ -d "$cache" ]]; then
      size_before=$(du_of "$cache")
      run rm -rf "$cache"
      ok "cleared $cache (was $size_before)"
    fi
  done

  # npm/pnpm/bun caches — only if they exist
  if command -v pnpm >/dev/null 2>&1; then
    run pnpm store prune || warn "pnpm store prune failed"
  fi
  if command -v bun >/dev/null 2>&1; then
    note "bun install cache: $(du_of ~/.bun/install/cache)"
  fi
else
  note "skipping caches (--skip-caches)"
fi

# ── Claude Code housekeeping ──────────────────────────
section "Claude Code"
CLAUDE_PROJECTS_SIZE=$(du_of ~/.claude/projects)
CLAUDE_PLUGINS_SIZE=$(du_of ~/.claude/plugins)
CLAUDE_MEM_SIZE=$(du_of ~/.claude-mem)
note "~/.claude/projects:  $CLAUDE_PROJECTS_SIZE"
note "~/.claude/plugins:   $CLAUDE_PLUGINS_SIZE"
note "~/.claude-mem:       $CLAUDE_MEM_SIZE"

if command -v claude-mem >/dev/null 2>&1; then
  run claude-mem compact 2>/dev/null || note "claude-mem compact skipped (not supported by worker-service)"
fi

# ── Atuin sync ────────────────────────────────────────
if command -v atuin >/dev/null 2>&1; then
  section "Atuin"
  if atuin status 2>/dev/null | grep -qi "logged in\|synced"; then
    run atuin sync 2>/dev/null || warn "atuin sync failed"
  else
    note "atuin not logged in, skipping sync"
  fi
fi

# ── Git gc for dotfiles repo ──────────────────────────
if [[ -d "$HOME/.config/.git" ]]; then
  section "Dotfiles repo"
  cd "$HOME/.config"
  run git gc --auto --quiet
  cd - >/dev/null
fi

# ── Disk usage summary ────────────────────────────────
section "Disk usage summary"
note "~/.cache total:      $(du_of ~/.cache)"
note "~/.claude total:     $(du_of ~/.claude)"
note "~/Library/Caches:    $(du_of ~/Library/Caches)"
note "/opt/homebrew:       $(du_of /opt/homebrew)"

# ── Done ──────────────────────────────────────────────
END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))
printf '\n%s%s done in %ds%s\n' "$BOLD" "$GREEN" "$ELAPSED" "$RESET"
