# Suite Review

## 2026-07-03 Global Review

Status: PASS_WITH_RISK

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

## Findings Fixed

- Added `plan-work` because planning was spread across `start-project`, `add-feature`, `manage-project`, and `run-task`.
- Routed generic planning requests from `run-task` to `plan-work`.
- Updated `start-project` to recommend `plan-work` when a brief needs execution planning.
- Narrowed `add-feature` UI prompt to avoid owning implementation planning.
- Updated README flow so `delegate-work` follows planned handoff boundaries.
- Added `ai-collab` to reduce user learning cost while keeping detailed workflows in child skills.
- Forward-tested Prompt Set D and Prompt Set E, then clarified `ai-collab` and `run-task` routing boundaries.

## Remaining Risks

- `handle this project` remains naturally ambiguous, but `ai-collab` now routes generic unknown work to `run-task` QuickProbe unless the user explicitly asks for status, priorities, sequencing, blockers, or next action.
- The suite still lacks a no-skill RED baseline campaign, so it should not be described as bulletproof.
- Installation is manual symlink/copy only; no installer script or marketplace packaging exists yet.

## Next Review Gate

Before publishing a `v0.1` release, run a no-skill RED baseline campaign and record the comparison in `tests/validation-results.md`.
