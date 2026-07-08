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
6. Before source-of-truth updates, status document updates, project-state changes, implementation, or delegation, present the plan and wait for explicit approval.
7. Tell the user the next concrete action.

## PM Control Mode

Use PM Control Mode when the user asks this conversation to act as PM, coordinator, PM-agent, or multi-agent controller.

In this mode, keep the current conversation focused on requirements, source-of-truth docs, plans, gates, status, and final synthesis. Do not directly perform implementation work except PM artifacts. Use `plan-work` for execution plans, `delegate-work` for approved subagent briefs, and `check-work` for acceptance.

Before source-of-truth updates, status document updates, project-state changes, implementation, delegation, or subagent launch, present the plan to the user and wait for explicit approval.

## Output

Use `assets/templates/status-report.md` for status syncs and project manager reports.

Use `check-work` for completion, readiness, release readiness, or acceptance decisions. Use `delegate-work` when the user needs actual handoff briefs, new conversations, collaborators, or subagents.

If source-of-truth context is unavailable, mark affected status as unknown or blocked and give the shortest recovery action. Do not approve milestones, change direction, or set verified next actions from memory or reported claims.

Do not change project direction silently. If a decision affects scope, phase, architecture, platform, budget, or release, surface it as a gate.
