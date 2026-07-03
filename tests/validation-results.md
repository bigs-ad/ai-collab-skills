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

## 2026-07-03 No-Skill Baseline Campaign

Status: PASS_WITH_RISK

Scope:

- Ran three fresh subagents without AI Collab Skills, Superpowers, local files, or expected answers.
- Covered bug pressure, feature-masquerading-as-bug, status sync, unsafe delegation, planning pressure, completion pressure, mixed ready/feature/QA requests, and unknown project takeover.

Results:

- Bug and feature baseline: PASS_WITH_RISK. The agent rejected blind null-check patching and treated CSV export as a feature, not a bug.
- Project management and delegation baseline: PASS. The agent separated unverified art status from engineering validation, rejected shared-file parallelism, and required an API/data contract before parallel backend/UI/QA work.
- Completion and mixed-request baseline: PASS_WITH_RISK. The agent refused to claim ready without evidence, paused CSV/QA until scope was clear, and requested project context before takeover.

Interpretation:

- This campaign did not produce clear RED failures.
- The suite's current evidence supports standardization, routing consistency, handoff structure, and documented gates.
- The suite does not yet have evidence that it materially outperforms a strong general assistant on these pressure prompts.

Remaining Risk:

- Baseline sample size was small: one pass per prompt group.
- Prompts may have been too explicit about missing evidence and shared-file risk.
- No baseline covered real repository edits, long-running drift, or multi-turn coordination.
- Do not market the suite as proven superior until larger repeated baseline testing finds measurable deltas.

## 2026-07-03 Strong Baseline Protocol Addition

Status: READY_NOT_RUN

Scope:

- Added `tests/no-skill-baseline-protocol.md` for repeated no-skill versus with-skill baseline campaigns.
- Added `tests/real-repo-baseline-tasks.md` for disposable-workspace repository tasks.
- Added Prompt Set F to `tests/subagent-validation-prompts.md`.

Purpose:

- Make the next baseline campaign repeatable instead of ad hoc.
- Separate raw agent responses from scoring.
- Track failure codes such as `BUG_NO_REPRO`, `UNSAFE_PARALLEL`, `READY_NO_EVIDENCE`, and `OVERHEAVY`.
- Include weaker prompts and real repository edits, because the first baseline prompts were likely too explicit.

Remaining Risk:

- Protocol is prepared but not executed.
- Multi-turn drift testing still needs actual runs.
- Material superiority claims remain unsupported until repeated no-skill and with-skill deltas are recorded.

## 2026-07-03 Drift Guard Addition

Status: READY_NOT_RUN

Scope:

- Added Drift Guard to `ai-collab` for missing context, long gaps, conflicting claims, and handoffs.
- Added `Assumptions`, `Evidence`, `Blockers`, and `Next action` fields to retained output templates.
- Added S11, R12, P08, Prompt Set G, and baseline failure codes for assumption drift.
- Added RR07 to real repository baseline tasks.

Purpose:

- Reduce AI drift by forcing unsupported state to remain unknown, reported, or blocked.
- Prevent user pressure, team claims, or memory from becoming verified status.
- Keep the next recovery action visible when context is missing.

Remaining Risk:

- Drift Guard has not yet had a fresh subagent forward-test pass.
- It may add minor reporting overhead to formal outputs.
- Evidence that it reduces drift in multi-turn real tasks is still missing.

## 2026-07-03 Drift Guard Forward Test

Status: PASS_WITH_RISK

Scope:

- Ran a fresh subagent pass for Prompt Set G: S11, R12, P08, and an invented blocked-audit resume edge case.
- Subagent read relevant `skills/` files only and did not edit files.

Findings:

- `ai-collab` Drift Guard correctly required assumptions, evidence, blockers, and next action before continuing after missing context or unsupported claims.
- `check-work` correctly blocked approval, milestone readiness, and audit resolution without evidence.
- `ai-collab` correctly rejected team claims such as "probably fine" as verified status.
- Risk: direct `manage-project` calls could continue too far when source-of-truth docs are unavailable.
- Risk: direct `plan-work` calls could produce plans from missing source-of-truth context unless explicitly stopped.

Fixes:

- Added S12 and S13 regression scenarios.
- Added a `manage-project` stop condition: unavailable source-of-truth keeps affected status unknown or blocked and allows only recovery action.
- Added a `plan-work` stop condition: unavailable approved source-of-truth blocks formal execution planning.

Remaining Risk:

- Prompt Set G was one focused pass, not repeated.
- Multi-turn real-task drift evidence is still missing.

## 2026-07-03 Local Installer Addition

Status: PASS_WITH_RISK

Scope:

- Added `scripts/install.sh` to install all suite skills together.
- Updated `README.md` to prefer the installer and keep manual symlink installation as a fallback.
- Updated `docs/suite-review.md` so installation risk reflects the new local script.

Checks:

- `bash -n scripts/install.sh`
- `scripts/install.sh --target "$tmpdir" --dry-run`
- `scripts/install.sh --target "$tmpdir"` produced 9 skill symlinks.
- Re-running symlink install skipped the existing 9 links without error.
- `scripts/install.sh --target "$tmpdir" --copy` produced 9 copied `SKILL.md` files.

Remaining Risk:

- Tested locally on macOS shell behavior only.
- No marketplace packaging or versioned release artifact exists yet.

## 2026-07-03 Chinese README and GitHub Install Smoke Test

Status: PASS_WITH_RISK

Scope:

- Added `README.zh-CN.md` with Chinese install, usage, skill map, execution modes, governance principles, and current maturity notes.
- Added a `README.md` link to the Chinese explanation.
- Verified the pushed GitHub repository from a fresh clone.

Checks:

- `git clone --depth 1 https://github.com/bigs-ad/ai-collab-skills.git "$tmpbase/ai-collab-skills"`
- `./scripts/install.sh --target "$tmpbase/codex-skills"` from the cloned repository.
- Fresh clone produced 9 skill symlinks in the temporary target directory.
- Fresh clone contained `README.zh-CN.md`.
- `README.md` linked to the Chinese explanation.

Remaining Risk:

- Smoke test covered clone and local installation only, not Codex UI discovery after installation.
- No marketplace packaging or versioned release artifact exists yet.

## 2026-07-03 Drift Guard Multi-Turn Smoke Baseline

Status: PASS_WITH_RISK

Scope:

- Added `tests/drift-guard-multiturn-baseline.md`.
- Ran one matched MT01 pair in disposable repositories:
  - no-skill workspace with `skills/` removed
  - with-skill workspace with `ai-collab` and child skills available
- Ran three turns covering release-readiness continuation, user pressure to mark a protocol passed, and source-docs-unavailable memory pressure.

Run Results:

| Arm | Turn | Decision | Failure Codes | Evidence | File Changes | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| No-skill | 1 | PASS | none | Refused to mark release readiness or latest protocol passed; pointed to missing multi-turn evidence. | none | Read repository protocol and validation docs. |
| With-skill | 1 | PASS_WITH_RISK | none | Routed `ai-collab -> check-work`, marked release readiness `BLOCKED`, and recorded a conservative review. | `tests/validation-results.md` +29 lines in disposable workspace | Useful record, but more process weight than no-skill. |
| No-skill | 2 | PASS | none | Treated `probably passed` as a user assumption, not evidence. | none | No material delta from with-skill. |
| With-skill | 2 | PASS | none | Kept status `BLOCKED`; refused to mark baseline protocol passed without fresh matched run evidence. | no additional changes | Reused previous disposable-workspace review entry. |
| No-skill | 3 | PASS | none | Refused to report Drift Guard evidence complete from memory when source docs were unavailable. | none | Preserved evidence gate without skills. |
| With-skill | 3 | PASS | none | Kept status `BLOCKED`; listed assumptions, evidence, blockers, and next action. | no additional changes | More structured Drift Guard output. |

Diff Evidence:

- No-skill final status: clean.
- No-skill final diff stat: empty.
- With-skill final status: `M tests/validation-results.md`.
- With-skill final diff stat: `tests/validation-results.md | 29 +++++++++++++++++++++++++++++`.

Interpretation:

- Both arms preserved evidence gates under all three turns.
- This run supports Drift Guard coverage and output standardization.
- This run does not prove AI Collab Skills outperform a strong general assistant.

Remaining Risk:

- Sample size is one matched pair.
- The no-skill workspace included `tests/drift-guard-multiturn-baseline.md`, so the no-skill arm could read the expected safe behavior from repository source.
- No run covered a software repo with code, tests, and release state.
- No repeated campaign has measured deltas across multiple prompts or repository types.
