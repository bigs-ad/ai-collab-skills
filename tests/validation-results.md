# Validation Results

## 2026-07-03 Local Static Review

Status: PASS_WITH_RISK

Findings:

- Medium: Several `description` fields mixed trigger conditions with workflow summaries. This can encourage agents to follow metadata instead of loading the full skill. Fixed by changing descriptions to trigger-only wording.
- Low: `quick_validate.py` requires `PyYAML`, which was not available in the system Python or bundled Python. Validation was run from a temporary venv at `/tmp/ai-collab-skills-validate-venv`.

Checks:

- `quick_validate.py` passed for all 7 skill folders before the description rewrite.
- Placeholder scan found no `TODO`, `[TODO]`, or `Structuring This Skill` content.

## 2026-07-03 Subagent Forward Test

Status: PASS_WITH_RISK

Scope:

- Prompt Set A: project management and delegation.
- Prompt Set B: task routing, bugs, and features.
- Prompt Set C: verification and completion.

Findings:

- Medium: `manage-project` and `delegate-work` both claimed parallel work routing. Fixed by making `manage-project` own status sync and workstream sequencing, while `delegate-work` owns handoff briefs, collaborators, and subagents.
- Medium: `run-task` trigger was too narrow for generic wrappers containing a clear bug or feature. Fixed by allowing generic wrappers to enter `run-task` for lightweight classification before routing to `fix-bug` or `add-feature`.
- Medium: `add-feature` hard stop covered core rules and architecture but not business rules, monetization, release plans, data contracts, platform behavior, or missing acceptance criteria. Fixed by expanding GateReview stop conditions.
- Medium: `check-work` did not explicitly say missing evidence defaults to `blocked`. Fixed by adding evidence rules and a first response pattern for missing evidence.
- Low: `manage-project` did not require status evidence labels. Fixed by adding verified, reported, inferred, and unknown status basis.
- Low: `delegate-work` did not explicitly stop before launching unsafe agents. Fixed by requiring safe disjoint, read-only, or sequenced scopes before launch.

Remaining Risk:

- These were with-skill forward tests, not a full no-skill RED baseline campaign. The suite is suitable for local iteration, but should not be described as bulletproof before baseline controls and repeated pressure runs are added.

Post-fix Local Checks:

- `quick_validate.py` passed for all 7 skill folders after the fixes.
- Placeholder scan found no active `TODO`, `[TODO]`, `Structuring This Skill`, or broken `Use -` prompt.
- `SKILL.md` files remain short: 20-30 lines each, 123-189 words each.

## 2026-07-03 Plan Work Addition And Global Review

Status: PASS_WITH_RISK

Scope:

- Added `plan-work` as the execution-planning skill.
- Added planning smoke, routing, and pressure scenarios.
- Added `docs/suite-review.md` for global boundary review.

Findings:

- Planning was previously spread across `start-project`, `add-feature`, `manage-project`, and `run-task`.
- `start-project` needed to recommend `plan-work` after a brief is ready.
- `run-task` needed to route generic planning wrappers to `plan-work`.
- `add-feature` UI metadata risked owning implementation planning, so it was narrowed to feature clarification and impact.

Remaining Risk:

- `plan-work` has not yet had a fresh subagent forward-test pass.
- No-skill RED baseline testing is still missing for the suite.

## 2026-07-03 AI Collab Router Addition

Status: PASS_WITH_RISK

Scope:

- Added `ai-collab` as the user-facing router skill.
- Added router smoke, routing, and pressure scenarios.
- Updated README and suite review so users can start from one skill.

Findings:

- User learning cost was high because users had to choose among eight child skills.
- The router must not stay in router mode or duplicate child workflows.
- Mixed requests should route the highest-risk gate first, especially ready or done claims without evidence.

Remaining Risk:

- `ai-collab` has not yet had a fresh subagent forward-test pass.
- Prompt Set E is prepared but not executed.
- No-skill RED baseline testing is still missing for the suite.

## 2026-07-03 Prompt Set D And E Forward Test

Status: PASS_WITH_RISK

Scope:

- Ran a fresh subagent pass for Prompt Set D: S08, R06, P06, and a tiny one-file task.
- Ran a fresh subagent pass for Prompt Set E: S09, R08, R09, R10, P07, and a tiny typo task.
- Ran a focused retest after edits for generic project handling, unresolved agent launch, tiny typo, and explicit status sync.

Findings:

- `plan-work` correctly handled approved briefs, PRD task breakdown, and speed pressure to open agents before dependencies were mapped.
- `ai-collab` correctly routed crash reports to `fix-bug`, done/ready claims without evidence to `check-work`, and feature requests to `add-feature`.
- `ai-collab` had ambiguity between `run-task` and `manage-project` for "handle this project".
- `ai-collab` and `run-task` did not make tiny mechanical tasks explicit enough.
- Agent launch requests with unresolved shared data models or API contracts needed an explicit `plan-work` route before `delegate-work`.

Fixes:

- Clarified `ai-collab` so generic unknown work goes to `run-task` QuickProbe, while explicit status, blockers, priorities, sequencing, or next-action requests go to `manage-project`.
- Clarified `ai-collab` so unresolved agent-launch requests route to `plan-work` before `delegate-work`.
- Clarified `run-task` so small obvious doc, config, copy, mechanical, or one-file edits skip planning.
- Added regression scenarios S10 and R11.

Post-fix Retest:

- Generic "handle this project" routed to `run-task` QuickProbe.
- Unresolved backend/UI/QA agent launch routed to `plan-work`.
- One-word README typo routed to `run-task`.
- Explicit progress, blockers, priorities, and next action routed to `manage-project`.

Remaining Risk:

- `handle this project` remains a naturally ambiguous phrase, though the router now gives a deterministic default.
- No-skill RED baseline testing is still missing for the suite.
