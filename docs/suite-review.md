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
- Ran a no-skill baseline campaign; it did not produce clear RED failures, so claims about measurable improvement must stay conservative.
- Added stronger baseline protocol and real repository task set for repeated no-skill versus with-skill testing.
- Added Drift Guard fields and scenarios to reduce assumption drift after context gaps, handoffs, and unsupported readiness claims.
- Forward-tested Prompt Set G and added direct source-of-truth stop conditions to `manage-project` and `plan-work`.
- Added a local installer script so users can install the router and all child skills together instead of manually linking each folder.
- Added and ran a Drift Guard multi-turn smoke baseline; both no-skill and with-skill arms preserved evidence gates, so this supports safety coverage but not superiority claims.
- Ran additional Drift Guard matched pairs on disposable software and mixed-project repositories; both arms preserved readiness gates, while with-skill responses were more explicit about assumptions, evidence, blockers, and next action.
- Ran a weak-source matched pair where repository docs used candidate language and stakeholder sentiment instead of explicit blockers; both arms still preserved readiness gates.

## Remaining Risks

- `handle this project` remains naturally ambiguous, but `ai-collab` now routes generic unknown work to `run-task` QuickProbe unless the user explicitly asks for status, priorities, sequencing, blockers, or next action.
- Drift Guard now has matched runs across documentation, software, mixed-project, and weak-source repositories; repeated long-context or real user project runs are still missing.
- The current no-skill baseline was too small and produced PASS/PASS_WITH_RISK results, so it does not prove this suite outperforms a strong general assistant.
- Installation now has a local script, but there is still no marketplace packaging or released versioned artifact.

## Next Review Gate

Before publishing a `v0.1` release, run real long-context project recovery tests or intentionally weaker one-turn takeover prompts; current matched baselines support standardization but not measurable superiority.
