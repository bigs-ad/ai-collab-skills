# AI Collab Skills

[中文说明](README.zh-CN.md)

AI Collab Skills is a small suite of Codex skills for project collaboration, planning, routing, delegation, verification, bug fixing, and feature work.

The suite is designed to sit at the same level as other reusable agent workflow skills: it should work across software projects, games, content projects, data analysis, operations plans, and mixed business work.

## Design Goals

- Keep the user-facing skill set small.
- Prefer short, action-oriented names.
- Route tasks by state and risk instead of forcing every task through a heavy process.
- Use timeboxes so long-running work reports why it is slow and what is blocking progress.
- Separate source-of-truth docs, temporary agent notes, implementation work, and verification evidence.
- Make delegation safer by defining bounded briefs and collecting structured results.
- Make drift easier to detect by keeping assumptions, evidence, blockers, and next action visible.
- Require a visible plan and explicit approval before modifications, bug fixes, new requirements, or delegated execution.

## Governance Kernel

The suite generalizes project work as:

```text
source of truth / evidence
-> state machine
-> pipeline
-> task card
-> gate
-> verification and writeback
```

- State machine: keep work in known states such as intake, classified, planned, implementing, verifying, ready, done, or blocked.
- Pipeline: choose the lightest safe process for the task type and execution mode.
- Task card: make durable work explicit with objective, non-goals, allowed scope, forbidden scope, checks, and writeback.
- Gate: stop for owner decisions or missing evidence before scope, architecture, platform, budget, release, or irreversible changes.

## Plan Approval And PM Control

For any modification, bug fix, or new/changed requirement, the suite should first load enough read-only context to make a plan, show that plan to the user, and wait for explicit approval before implementation, file edits, subagent launch, or other durable state changes.

PM Control Mode keeps the current conversation as the project manager: it collects requirements, updates source-of-truth docs and plans, controls gates, and synthesizes results. Actual execution is delegated only after user approval, and multiple subagents are used only when their scopes are disjoint, read-only, or sequenced by gates.

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

When using PM Control Mode, keep the main conversation in `manage-project` / `plan-work` / `delegate-work` coordination and send implementation to approved delegates instead of doing it directly in the PM thread.

## Execution Modes

| Mode | Purpose | Typical Use |
| --- | --- | --- |
| QuickProbe | Fast exploration without formal deliverables. | Clarify feasibility, inspect unknowns, make a small spike. |
| Candidate | Produce a reviewable candidate result. | Draft docs, propose architecture, produce a first implementation. |
| Formalize | Convert accepted direction into source-of-truth artifacts or production code. | Approved features, approved docs, retained fixes. |
| GateReview | Stop for owner decision before continuing. | Scope, architecture, platform, budget, release, or irreversible decisions. |

## Review Artifacts

- `docs/releases/v0.1.md`: conservative v0.1 candidate release notes and claim boundaries.
- `docs/suite-review.md`: current suite boundary review and remaining risks.
- `tests/validation-results.md`: validation history and evidence.
- `tests/no-skill-baseline-protocol.md`: repeatable no-skill versus with-skill baseline protocol.
- `tests/real-repo-baseline-tasks.md`: real repository tasks for stronger baseline campaigns.
- `tests/drift-guard-multiturn-baseline.md`: multi-turn context drift smoke and baseline protocol.

## Local Install

Recommended:

```bash
git clone https://github.com/bigs-ad/ai-collab-skills.git
cd ai-collab-skills
./scripts/install.sh
```

The installer links every folder under `skills/` into `${CODEX_HOME:-$HOME/.codex}/skills`. Installing only `ai-collab` is not enough because the router loads child skills before acting.

Useful options:

```bash
./scripts/install.sh --copy
./scripts/install.sh --target /path/to/codex/skills
./scripts/install.sh --force
./scripts/install.sh --dry-run
```

Manual fallback:

```bash
ln -s /path/to/ai-collab-skills/skills/ai-collab ~/.codex/skills/ai-collab
ln -s /path/to/ai-collab-skills/skills/start-project ~/.codex/skills/start-project
```

Repeat for every child skill you want the router to use.

## Publication Status

This repository is a `v0.1` candidate for local installation and evaluation under the MIT License. Forward-test and baseline evidence is recorded in `tests/validation-results.md`, with release claim boundaries in `docs/releases/v0.1.md`.

Do not describe the suite as mature, bulletproof, proven to reduce AI drift in production, or proven to outperform strong general assistants. Current evidence supports structured collaboration, explicit evidence gates, and more consistent reporting of assumptions, evidence, blockers, and next action.
