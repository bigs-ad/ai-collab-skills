---
name: run-task
description: Use when the user gives a generic task wrapper such as "continue", "handle this", "do this", or "process this", or when the task type is unclear across bug, feature, document, research, test, project-management, and handoff work.
---

# Run Task

## Workflow

1. Classify the request: bug, feature, doc, test, research, handoff, project management, or mixed.
2. If a generic wrapper contains a clear bug, switch to `fix-bug`. If it asks for task breakdown, implementation planning, milestones, or sequencing, switch to `plan-work`. If it contains a clear feature, switch to `add-feature`.
3. Choose execution mode: QuickProbe, Candidate, Formalize, or GateReview.
4. Set a timebox for work likely to exceed 30 minutes.
5. Execute within scope, verify honestly, and report what changed.

## Stop Conditions

If the task refers to "current", "previous", or "continue" but no source of truth can be found, stop after QuickProbe and request or locate context. Do not invent task state.

## Output

Use `assets/templates/task-report.md` for completion reports.

Never claim tests passed unless they actually ran. If verification was skipped or deferred, say so explicitly.
