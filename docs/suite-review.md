# Suite Review

## 2026-07-03 Global Review

Status: PASS_WITH_RISK

Release Readiness: `v0.1 candidate` is acceptable for local installation and evaluation. Stronger maturity or superiority claims are not supported by current evidence.

## Skill Boundaries

| Skill | Owns | Must Not Own |
| --- | --- | --- |
| `ai-collab` | One-entry routing and highest-risk-first child skill selection. | Detailed child workflows or final decisions without loading the selected child skill. |
| `start-project` | Rough idea to project brief and first workstreams. | Detailed execution plans or implementation. |
| `plan-work` | Approved scope to task breakdown, dependencies, gates, and verification plan. | Scope discovery, direct execution, or launching agents. |
| `manage-project` | Status sync, sequencing, blockers, and next-action control. | Acceptance decisions or handoff briefs. |
| `run-task` | Generic task wrappers and lightweight routing. | Long-form planning when `plan-work` applies. |
| `fix-bug` | Broken behavior, reproduction, narrow fix, and regression check. | New requirements mislabeled as bugs. |
| `add-feature` | New requirement shaping, acceptance criteria, impact, and GateReview. | Detailed task sequencing after scope is approved. |
| `delegate-work` | Safe handoff briefs and delegated-work coordination. | Deciding readiness or skipping dependency mapping. |
| `check-work` | Evidence-based review, acceptance, readiness, and gate decisions. | Scheduling and progress sync. |

## Generic Governance Coverage

| Kernel Piece | Current Owner | Coverage | Remaining Boundary |
| --- | --- | --- | --- |
| Source of truth / evidence | `ai-collab`, `run-task`, `plan-work`, `manage-project`, `check-work` | Explicit evidence labels and stop conditions prevent memory or reported status from becoming verified state. | Project-specific source docs still belong in the project. |
| State machine | `ai-collab` plus child skills | Added a generic fallback state model for projects without their own governance docs. | Do not prescribe domain-specific phases such as game, product, or platform milestones. |
| Pipeline | `run-task` and child skills | QuickProbe, Candidate, Formalize, and GateReview remain the general execution pipeline. | Domain pipelines stay in project docs or specialized skills. |
| Task card | `run-task`, `plan-work` | Added a generic task-card template for durable scoped work that is smaller than a full execution plan. | Projects may replace it with their own issue, ticket, or plan format. |
| Gate | `ai-collab`, `plan-work`, `manage-project`, `check-work` | Gates cover owner decisions, unsafe parallelism, missing evidence, readiness, and irreversible changes. | Gate owners and exact evidence are project-specific. |
| Plan Approval Gate | `ai-collab`, `start-project`, `run-task`, `add-feature`, `fix-bug`, `plan-work`, `manage-project`, `delegate-work` | Modification, bug-fix, new-requirement, source-of-truth update, project-state update, and delegated execution requests now require a shown plan plus explicit user approval before durable work. | Read-only context loading is still allowed so the plan can be grounded. |
| PM Control Mode | `ai-collab`, `manage-project`, `plan-work`, `delegate-work`, `check-work` | The main conversation can act as PM for requirements, source-of-truth docs, plans, gates, status, and synthesis while approved delegates perform execution. | Real subagent availability depends on the host Codex environment. |
| Verification / writeback | `run-task`, `check-work`, templates | Reports and task cards now keep checks, deferred checks, and writeback visible. | Actual commands and artifacts remain project-specific. |

## Findings Fixed

- Added `plan-work` because planning was spread across `start-project`, `add-feature`, `manage-project`, and `run-task`.
- Routed generic planning requests from `run-task` to `plan-work`.
- Updated `start-project` to recommend `plan-work` when a brief needs execution planning.
- Narrowed `add-feature` UI prompt to avoid owning implementation planning.
- Updated README flow so `delegate-work` follows planned handoff boundaries.
- Added `ai-collab` to reduce user learning cost while keeping detailed workflows in child skills.
- Forward-tested Prompt Set D and Prompt Set E, then clarified `ai-collab` and `run-task` routing boundaries.
- Ran a no-skill baseline campaign; it did not produce clear RED failures, so claims about measurable improvement must stay conservative.
- Added stronger baseline protocol and real repository task set for repeated no-skill versus with-skill testing.
- Added Drift Guard fields and scenarios to reduce assumption drift after context gaps, handoffs, and unsupported readiness claims.
- Forward-tested Prompt Set G and added direct source-of-truth stop conditions to `manage-project` and `plan-work`.
- Added a local installer script so users can install the router and all child skills together instead of manually linking each folder.
- Added and ran a Drift Guard multi-turn smoke baseline; both no-skill and with-skill arms preserved evidence gates, so this supports safety coverage but not superiority claims.
- Ran additional Drift Guard matched pairs on disposable software and mixed-project repositories; both arms preserved readiness gates, while with-skill responses were more explicit about assumptions, evidence, blockers, and next action.
- Ran a weak-source matched pair where repository docs used candidate language and stakeholder sentiment instead of explicit blockers; both arms still preserved readiness gates.
- Added conservative `v0.1` candidate release notes with explicit claim boundaries.
- Created `v0.1.0` prerelease and verified release-tag install into a temporary Codex skills target.
- Added the generic governance kernel wording and a reusable task-card template: source of truth / evidence -> state machine -> pipeline -> task card -> gate -> verification and writeback.
- Added Plan Approval Gate and PM Control Mode so direct edits, bug fixes, new requirements, and subagent launches wait for user-approved plans.
- Closed follow-up loopholes found by real subagent smoke: `manage-project` source-of-truth updates, `delegate-work` project-control wording, and `start-project` post-brief approval.

## Remaining Risks

- `handle this project` remains naturally ambiguous, but `ai-collab` now routes generic unknown work to `run-task` QuickProbe unless the user explicitly asks for status, priorities, sequencing, blockers, or next action.
- Drift Guard now has matched runs across documentation, software, mixed-project, and weak-source repositories; repeated long-context or real user project runs are still missing.
- The current no-skill baseline was too small and produced PASS/PASS_WITH_RISK results, so it does not prove this suite outperforms a strong general assistant.
- Installation now has a local script, `v0.1` candidate notes, a `v0.1.0` prerelease, and a temporary-target release install smoke pass; there is still no marketplace packaging or real Codex App restart discovery evidence.

## Next Review Gate

Before publishing stronger claims after `v0.1`, run real long-context project recovery tests, intentionally weaker one-turn takeover prompts, or a real Codex App install/restart discovery check; current matched baselines support standardization but not measurable superiority.
