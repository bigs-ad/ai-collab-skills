# AI Collab Skills

[中文说明](README.zh-CN.md)

AI Collab Skills is a compact governance layer for Codex project work: planning, routing, delegation, execution control, verification, bug fixing, and feature intake.

It is designed to sit above domain-specific engineering or creative skills. The same collaboration model should work across software projects, games, content projects, data analysis, operations plans, and mixed business work.

## Design Goals

- Keep the user-facing entry point small: most work can start with `ai-collab`.
- Route by state, evidence, and risk instead of forcing every request through a heavy process.
- Keep source-of-truth docs, temporary notes, implementation work, and verification evidence separate.
- Require a visible plan and explicit user approval before durable work: edits, bug fixes, new requirements, source-of-truth updates, project-state changes, or delegated execution.
- Let one conversation act as the project manager when needed, while approved delegates or subagents handle bounded execution work.
- Make delegation safe with clear briefs, disjoint or gated scopes, structured results, and final synthesis by the coordinator.
- Make drift easier to detect by keeping assumptions, evidence, blockers, and next action visible.

## Governance Kernel

The suite generalizes project work as:

```text
source of truth / evidence
-> state machine
-> plan approval
-> pipeline / task card
-> controlled execution or delegation
-> verification and writeback
```

- Source of truth / evidence: do not turn memory, pressure, or reported status into verified state.
- State machine: keep work in known states such as intake, classified, planned, implementing, verifying, ready, done, or blocked.
- Plan approval: show the plan and wait for explicit approval before durable changes or delegated execution.
- Pipeline / task card: choose the lightest safe process, and make retained work explicit with objective, non-goals, allowed scope, forbidden scope, checks, and writeback.
- Controlled execution or delegation: the coordinator owns requirements, scope, gates, integration, and final status; delegates work only inside approved briefs.
- Verification and writeback: record evidence, skipped checks, remaining risk, and any source-of-truth updates.

## Core Operating Rules

Read-only context loading is allowed so the agent can understand the task. Durable work is gated.

- Plan Approval Gate: modifications, bug fixes, new or changed requirements, source-of-truth updates, project-state changes, and delegated execution require a shown plan plus explicit user approval.
- PM Control Mode: the current conversation can act as the project manager, collecting requirements, maintaining plans and docs, controlling gates, tracking status, and synthesizing results.
- Delegate boundary: delegated agents may change approved execution artifacts inside their briefs, but they must not change project direction, approval scope, gates, or final status.
- Evidence discipline: completion, readiness, and release decisions must be based on checks or inspected evidence, not claims.

## Skills

| Skill | Use For |
| --- | --- |
| `ai-collab` | One entry point that routes a request to the right child skill. |
| `start-project` | Turn a rough idea into project brief, scope, document map, and first workstreams. |
| `plan-work` | Turn approved goals or requirements into execution plans, dependencies, gates, delegation candidates, and verification. |
| `manage-project` | Sync project status, blockers, gates, priorities, source-of-truth updates, and workstream sequencing. |
| `run-task` | Classify ambiguous tasks, choose execution mode, timebox, plan gated work, execute after approval, and report. |
| `fix-bug` | Reproduce, diagnose, fix, and verify broken behavior. |
| `add-feature` | Shape new requirements, acceptance criteria, implementation path, and verification. |
| `delegate-work` | Create safe handoff briefs and coordinate approved conversations, collaborators, or subagents. |
| `check-work` | Review, test, accept, block, or request rework based on evidence. |

## Suggested Flow

Most users can start with `ai-collab`. It selects one primary child skill, applies the highest-risk gate first, and then follows that child skill.

Advanced users can call child skills directly:

1. Use `start-project` when the project is still unclear.
2. Use `plan-work` when approved goals or requirements need an execution plan.
3. Use `manage-project` once multiple workstreams exist.
4. Use `run-task` for ambiguous one-off work.
5. Use `fix-bug` or `add-feature` when the task type is clear.
6. Use `delegate-work` after approval and after safe handoff boundaries are known.
7. Use `check-work` before calling work complete, ready, or releasable.

When using PM Control Mode, keep the main conversation in `manage-project` / `plan-work` / `delegate-work` coordination. Send implementation to approved delegates instead of doing it directly in the PM thread, then use `check-work` to inspect returned evidence.

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
- `tests/pressure-scenarios.md` and `tests/forward-test-matrix.md`: pressure prompts and routing checks for plan approval, PM control, delegation, and evidence gates.

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

This repository is a `v0.1` candidate for local installation and evaluation under the MIT License. Forward-test, baseline, read-only subagent review, and delegate execution smoke evidence are recorded in `tests/validation-results.md`, with release claim boundaries in `docs/releases/v0.1.md`.

Do not describe the suite as mature, bulletproof, proven to reduce AI drift in production, or proven to outperform strong general assistants. Current evidence supports structured collaboration, explicit approval and evidence gates, bounded delegation, and more consistent reporting of assumptions, evidence, blockers, and next action.
