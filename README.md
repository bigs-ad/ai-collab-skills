# AI Collab Skills

AI Collab Skills is a small suite of Codex skills for project collaboration, planning, routing, delegation, verification, bug fixing, and feature work.

The suite is designed to sit at the same level as other reusable agent workflow skills: it should work across software projects, games, content projects, data analysis, operations plans, and mixed business work.

## Design Goals

- Keep the user-facing skill set small.
- Prefer short, action-oriented names.
- Route tasks by state and risk instead of forcing every task through a heavy process.
- Use timeboxes so long-running work reports why it is slow and what is blocking progress.
- Separate source-of-truth docs, temporary agent notes, implementation work, and verification evidence.
- Make delegation safer by defining bounded briefs and collecting structured results.

## Skills

| Skill | Use For |
| --- | --- |
| `ai-collab` | One entry point that routes a request to the right child skill. |
| `start-project` | Turn a rough idea into project brief, scope, document map, and first workstreams. |
| `plan-work` | Turn approved goals or requirements into execution plans, dependencies, gates, and verification. |
| `manage-project` | Sync project status, blockers, gates, priorities, and workstream sequencing. |
| `run-task` | Classify ambiguous tasks, choose execution mode, timebox, execute, and report. |
| `fix-bug` | Reproduce, diagnose, fix, and verify broken behavior. |
| `add-feature` | Shape new requirements, acceptance criteria, implementation path, and verification. |
| `delegate-work` | Create safe handoff briefs for conversations, collaborators, or subagents. |
| `check-work` | Review, test, accept, block, or request rework based on evidence. |

## Suggested Flow

Most users can start with `ai-collab`. It selects one primary child skill and then follows that skill.

Advanced users can call child skills directly:

1. Use `start-project` when the project is still unclear.
2. Use `plan-work` when approved goals or requirements need an execution plan.
3. Use `manage-project` once multiple workstreams exist.
4. Use `run-task` for ambiguous one-off work.
5. Use `fix-bug` or `add-feature` when the task type is clear.
6. Use `delegate-work` after `plan-work` identifies safe handoff boundaries.
7. Use `check-work` before calling work complete.

## Execution Modes

| Mode | Purpose | Typical Use |
| --- | --- | --- |
| QuickProbe | Fast exploration without formal deliverables. | Clarify feasibility, inspect unknowns, make a small spike. |
| Candidate | Produce a reviewable candidate result. | Draft docs, propose architecture, produce a first implementation. |
| Formalize | Convert accepted direction into source-of-truth artifacts or production code. | Approved features, approved docs, retained fixes. |
| GateReview | Stop for owner decision before continuing. | Scope, architecture, platform, budget, release, or irreversible decisions. |

## Review Artifacts

- `docs/suite-review.md`: current suite boundary review and remaining risks.
- `tests/validation-results.md`: validation history and evidence.

## Local Install

Copy or symlink each folder under `skills/` into your Codex skills directory, usually `~/.codex/skills/`.

Install `ai-collab` plus the child skills it routes to. Installing only the router is not enough because the router loads a child skill before acting.

Example:

```bash
ln -s /path/to/ai-collab-skills/skills/ai-collab ~/.codex/skills/ai-collab
ln -s /path/to/ai-collab-skills/skills/start-project ~/.codex/skills/start-project
```

Repeat for the skills you want to enable.

## Publication Status

This repository skeleton is ready for local iteration under the MIT License. Forward-test and baseline evidence is recorded in `tests/validation-results.md`.

Before describing the suite as mature or bulletproof, run a larger baseline campaign with repeated pressure tests and real repository tasks.
