---
name: ai-collab
description: Use when the user wants one simple entry point for project collaboration, task handling, status sync, planning, delegation, bug fixing, feature work, review, acceptance, or "what should happen next" without choosing a specific AI Collab child skill.
---

# AI Collab

## Workflow

1. Classify the request and current evidence.
2. Select the most specific primary child skill. Use `run-task` only for generic or unclear work, unknown project state, or tiny mechanical edits.
3. State the selected child skill and the reason in one short sentence.
4. Load and follow the selected child skill. That child skill may route again if its own contract requires it.
5. If multiple concerns are mixed, handle the highest-risk gate first.

## Drift Guard

Before continuing after missing context, long gaps, conflicting claims, or handoffs, name:

- Assumptions:
- Evidence:
- Blockers:
- Next action:

If evidence is missing, keep the state unknown, reported, or blocked. Do not turn memory, user pressure, or team claims into verified status.

## Generic Governance Kernel

When project-specific governance is absent or incomplete, preserve this default model:

- State machine: Intake -> Classified -> ContextLoaded -> Planned/Implementing -> Verifying -> ReadyForReview/Done/Blocked.
- Pipeline: classify, load source of truth, choose mode, gate scope, execute, verify, write back, report.
- Task card: retained or cross-file work needs objective, non-goals, allowed scope, forbidden scope, verification, and writeback.
- Gates: stop for owner decision on scope, architecture, data contracts, platform behavior, budget, release, irreversible actions, or missing evidence.

## Plan Approval Gate

When the user asks to modify files, docs, assets, project state, fix a bug, or add/change a requirement, do not implement, patch, launch agents, or make durable state changes before explicit user approval.

You may do read-only context loading needed to build the plan. Then present the plan and wait.

If the project is already managed by AI Collab governance, align the plan with its source-of-truth artifact, task card, execution plan, or gate format before asking for approval. Otherwise present a concise plan with objective, scope, non-goals, steps, verification, risks, and affected artifacts.

Urgency, prior intent, or "just do it" in the original request is not approval to skip this gate. Approval must arrive after the plan is shown.

## PM Control Mode

Use this mode when the user asks for PM-agent, project-manager mode, current chat as PM, multi-agent control, or similar coordination.

The current conversation owns requirements, source-of-truth docs, plans, gates, status, and final synthesis. It should not directly perform implementation work except PM artifacts. Actual execution goes to delegated conversations, collaborators, or subagents only after the user approves the plan.

Multiple subagents are allowed only when the approved plan proves their scopes are disjoint, read-only, or sequenced by explicit gates. Otherwise propose sequential gates or smaller safe briefs.

## Route Table

| Situation | Primary Skill |
| --- | --- |
| Rough idea, new project, unclear concept | `start-project` |
| Approved scope needs task breakdown, dependencies, gates, or milestones | `plan-work` |
| Open agents while dependencies, shared files, API contracts, or gates are unresolved | `plan-work` |
| PM-agent, current chat as PM, multi-agent project control | `manage-project`, then `plan-work` or `delegate-work` |
| Status sync, blockers, priorities, sequencing, next action | `manage-project` |
| Generic "continue", "do this", "handle this", unclear task type, unknown project state | `run-task` |
| Small obvious doc, config, copy, mechanical, or one-file edit | `run-task` |
| Bug, error, crash, failing test, regression, wrong output | `fix-bug` |
| New feature, changed behavior, new field, product rule change | `add-feature` |
| New conversation, subagent, collaborator, handoff brief with safe boundaries | `delegate-work` |
| Review, test, acceptance, ready/done/release decision | `check-work` |

## Guardrails

Do not stay in router mode. Load and follow the selected child skill.

Do not use `plan-work` for small, obvious, low-risk single-step tasks. Route those to `run-task`, `fix-bug`, or `add-feature`.

Do not launch agents before the Plan Approval Gate passes and `plan-work` or `delegate-work` confirms safe boundaries.

If the user claims work is done or ready without evidence, route to `check-work` first.

If current state is unknown, route to `run-task` QuickProbe unless the user explicitly asks for status, blockers, priorities, sequencing, or next action. Do not invent project status.
