---
name: delegate-work
description: Use when the user wants separate conversations, subagents, collaborators, handoff prompts, execution briefs, or coordination of delegated work without losing project control.
---

# Delegate Work

## Workflow

1. Identify independent workstreams and dependencies.
2. Reject unsafe parallelism when agents would edit the same files, change unresolved architecture, or touch external systems.
3. Generate bounded handoff briefs before launching conversations, collaborators, or subagents.
4. Launch or assign only when scopes are disjoint, read-only, or sequenced by an explicit gate.
5. Require structured results from each delegate.
6. Collect, compare, resolve conflicts, and return a single project-manager-level summary.

## Output

Use `assets/templates/agent-brief.md` and `assets/templates/delegate-summary.md`.

Only the coordinating agent should change project state. Delegated agents should not recursively delegate unless explicitly authorized. Do not launch delegated work just because speed is requested; prove the scopes are safe first.
