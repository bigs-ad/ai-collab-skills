---
name: ai-collab
description: Use when the user wants one simple entry point for project collaboration, task handling, status sync, planning, delegation, bug fixing, feature work, review, acceptance, or "what should happen next" without choosing a specific AI Collab child skill.
---

# AI Collab

## Workflow

1. Classify the request and current evidence.
2. Select exactly one primary child skill first, then follow that skill.
3. State the selected child skill and the reason in one short sentence.
4. If multiple concerns are mixed, handle the highest-risk gate first.

## Route Table

| Situation | Primary Skill |
| --- | --- |
| Rough idea, new project, unclear concept | `start-project` |
| Approved scope needs task breakdown, dependencies, gates, or milestones | `plan-work` |
| Status sync, blockers, priorities, sequencing, next action | `manage-project` |
| Generic "continue", "do this", "handle this", unclear task type | `run-task` |
| Bug, error, crash, failing test, regression, wrong output | `fix-bug` |
| New feature, changed behavior, new field, product rule change | `add-feature` |
| New conversation, subagent, collaborator, handoff brief | `delegate-work` |
| Review, test, acceptance, ready/done/release decision | `check-work` |

## Guardrails

Do not stay in router mode. Load and follow the selected child skill.

Do not use `plan-work` for small, obvious, low-risk single-step tasks. Route those to `run-task`, `fix-bug`, or `add-feature`.

Do not launch agents before `plan-work` or `delegate-work` confirms safe boundaries.

If the user claims work is done or ready without evidence, route to `check-work` first.

If current state is unknown, route to `manage-project` or `run-task` QuickProbe. Do not invent project status.
