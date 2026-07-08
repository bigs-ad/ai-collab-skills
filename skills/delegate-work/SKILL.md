---
name: delegate-work
description: Use when the user wants separate conversations, subagents, collaborators, handoff prompts, execution briefs, or coordination of delegated work without losing project control.
---

# Delegate Work

## Workflow

1. Identify independent workstreams and dependencies.
2. Reject unsafe parallelism when agents would edit the same files, change unresolved architecture, or touch external systems.
3. Generate a delegation plan and bounded handoff briefs, aligned with any AI Collab source-of-truth, before launching conversations, collaborators, or subagents.
4. Present the delegation plan and wait for explicit user approval.
5. Launch or assign only after approval and only when scopes are disjoint, read-only, or sequenced by an explicit gate.
6. Require structured results from each delegate.
7. Collect, compare, resolve conflicts, and return a single project-manager-level summary.

## Output

Use `assets/templates/agent-brief.md` and `assets/templates/delegate-summary.md`.

The coordinating agent owns project control: requirements, scope, gates, integration, and final status. Delegated agents may change approved execution artifacts within their brief, but must not change project direction, approval scope, gates, or recursively delegate unless explicitly authorized. Do not launch delegated work just because speed is requested; prove the scopes are safe first.

In PM Control Mode, the current conversation stays responsible for requirements, docs, gates, status, and final synthesis while delegated agents do the approved execution work.
