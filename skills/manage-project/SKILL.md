---
name: manage-project
description: Use when an ongoing project needs status sync, progress reporting, priority decisions, blocker review, workstream sequencing, source-of-truth updates, or next-action control across workstreams.
---

# Manage Project

## Workflow

1. Load the project's governance or source-of-truth docs when available.
2. Summarize current state, main priority, blockers, risks, and pending decisions.
3. Mark each status as verified, reported, inferred, or unknown.
4. Separate work into active, blocked, ready, and not-yet-started lanes.
5. Identify what can proceed concurrently and what requires a gate or owner decision.
6. Tell the user the next concrete action.

## Output

Use `assets/templates/status-report.md` for status syncs and project manager reports.

Use `check-work` for completion, readiness, release readiness, or acceptance decisions. Use `delegate-work` when the user needs actual handoff briefs, new conversations, collaborators, or subagents.

Do not change project direction silently. If a decision affects scope, phase, architecture, platform, budget, or release, surface it as a gate.
