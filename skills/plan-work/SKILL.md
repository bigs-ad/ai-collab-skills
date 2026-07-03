---
name: plan-work
description: Use when approved goals, briefs, PRDs, specs, bug scopes, feature scopes, or stage objectives need to become an execution plan, task breakdown, milestone plan, dependency map, gate list, or verification plan before work begins.
---

# Plan Work

## Workflow

1. Load the approved source of truth: brief, PRD, spec, issue, bug scope, or stage objective.
2. Confirm scope, non-goals, acceptance criteria, constraints, and owner decisions.
3. Split work into ordered tasks with dependencies, gates, and verification for each task.
4. Mark tasks as sequential, concurrent, delegated, blocked, or not-yet-ready.
5. Identify which tasks can feed `delegate-work`, which should stay local, and which need `check-work`.

## Stop Conditions

If the goal is still unclear, use `start-project` or `add-feature` first. If the task is a small, obvious, low-risk single-step change, skip this skill and use `run-task`, `fix-bug`, or `add-feature`.

Do not start implementation or launch agents from this skill. Produce the plan first, then route execution.

## Output

Use `assets/templates/execution-plan.md` for formal plans.
