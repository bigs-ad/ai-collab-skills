#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Install AI Collab Skills into a Codex skills directory.

Usage:
  scripts/install.sh [--copy|--symlink] [--target DIR] [--force] [--dry-run]

Options:
  --symlink      Install each skill as a symlink. This is the default.
  --copy         Copy each skill directory instead of linking it.
  --target DIR   Install into DIR. Defaults to ${CODEX_HOME:-$HOME/.codex}/skills.
  --force        Replace existing targets with the same skill names.
  --dry-run      Print actions without changing files.
  -h, --help     Show this help.
EOF
}

fail() {
  printf 'error: %s\n' "$1" >&2
  exit 1
}

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf 'dry-run:'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE_DIR="$REPO_ROOT/skills"
TARGET_DIR="${CODEX_HOME:-$HOME/.codex}/skills"
MODE="symlink"
FORCE=0
DRY_RUN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --copy)
      MODE="copy"
      ;;
    --symlink)
      MODE="symlink"
      ;;
    --target)
      shift
      [[ $# -gt 0 ]] || fail "--target requires a directory"
      TARGET_DIR="$1"
      ;;
    --target=*)
      TARGET_DIR="${1#--target=}"
      [[ -n "$TARGET_DIR" ]] || fail "--target requires a directory"
      ;;
    --force)
      FORCE=1
      ;;
    --dry-run)
      DRY_RUN=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      fail "unknown option: $1"
      ;;
  esac
  shift
done

[[ -d "$SOURCE_DIR" ]] || fail "missing skills directory: $SOURCE_DIR"

if [[ "$DRY_RUN" -eq 0 ]]; then
  mkdir -p "$TARGET_DIR"
else
  run mkdir -p "$TARGET_DIR"
fi

installed=0
skipped=0

for skill_dir in "$SOURCE_DIR"/*; do
  [[ -d "$skill_dir" && -f "$skill_dir/SKILL.md" ]] || continue

  skill_name="$(basename "$skill_dir")"
  target_path="$TARGET_DIR/$skill_name"

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    if [[ "$MODE" == "symlink" && -L "$target_path" ]]; then
      current_target="$(readlink "$target_path" || true)"
      if [[ "$current_target" == "$skill_dir" ]]; then
        printf 'skip: %s already links to %s\n' "$skill_name" "$skill_dir"
        skipped=$((skipped + 1))
        continue
      fi
    fi

    if [[ "$FORCE" -eq 1 ]]; then
      run rm -rf "$target_path"
    else
      fail "target exists: $target_path (use --force to replace it)"
    fi
  fi

  if [[ "$MODE" == "copy" ]]; then
    run cp -R "$skill_dir" "$target_path"
  else
    run ln -s "$skill_dir" "$target_path"
  fi

  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf 'plan: %s -> %s\n' "$skill_name" "$target_path"
  else
    printf 'install: %s -> %s\n' "$skill_name" "$target_path"
  fi
  installed=$((installed + 1))
done

[[ "$installed" -gt 0 || "$skipped" -gt 0 ]] || fail "no skill folders found in $SOURCE_DIR"

if [[ "$DRY_RUN" -eq 1 ]]; then
  printf 'done: %s planned, %s skipped, target=%s\n' "$installed" "$skipped" "$TARGET_DIR"
else
  printf 'done: %s installed, %s skipped, target=%s\n' "$installed" "$skipped" "$TARGET_DIR"
fi
