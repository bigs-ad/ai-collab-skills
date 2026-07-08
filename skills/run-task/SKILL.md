---
name: run-task
description: Use when the user gives a generic task wrapper such as "continue", "handle this", "do this", or "process this"; when the task type is unclear; or for small obvious doc, config, copy, mechanical, or one-file edits.
---

# Run Task

## Workflow

1. Classify the request: bug, feature, doc, test, research, handoff, project management, or mixed.
2. If a generic wrapper contains a clear bug, switch to `fix-bug`. If it asks for task breakdown, implementation planning, milestones, or sequencing, switch to `plan-work`. If it contains a clear feature, switch to `add-feature`.
3. If the task asks to modify files, docs, assets, project state, fix a bug, or add/change a requirement, use the Plan Approval Gate: do only read-only context loading, align with any AI Collab source-of-truth or task card, present a plan, and wait for explicit user approval before durable changes.
4. For small obvious mechanical edits, keep the plan lightweight, then use the lightest approved mode with a focused diff check.
5. Choose execution mode: QuickProbe, Candidate, Formalize, or GateReview.
6. Set a timebox for work likely to exceed 30 minutes.
7. For Formalize, GateReview, retained work, or cross-file changes, create or update a task card unless the project already has an equivalent source-of-truth artifact.
8. After approval, execute within scope, verify honestly, write back durable state, and report what changed.

## Stop Conditions

If the task refers to "current", "previous", or "continue" but no source of truth can be found, stop after QuickProbe and request or locate context. Do not invent task state.

## Output

Use `assets/templates/task-report.md` for completion reports.

Use `assets/templates/task-card.md` when a task needs durable scope, gates, verification, or writeback but does not justify a full `plan-work` execution plan.

Plan approval requests can be brief, but must name objective, affected artifacts, steps, verification, and risks before implementation.

Never claim tests passed unless they actually ran. If verification was skipped or deferred, say so explicitly.
