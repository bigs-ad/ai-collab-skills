# Validation Results

## 2026-07-08 Generic Governance Kernel Alignment

Status: PASS_WITH_RISK

Scope:

- Added explicit generic governance kernel wording: source of truth / evidence -> state machine -> pipeline -> task card -> gate -> verification and writeback.
- Added `skills/run-task/assets/templates/task-card.md` for durable scoped work that is smaller than a full `plan-work` execution plan.
- Kept the suite general-purpose; no project-specific game, Cocos, art, platform, or release-stage rules were added.

RED Checks:

- `test -f skills/run-task/assets/templates/task-card.md`: failed before the change.
- `rg -n "state machine|task card|pipeline" skills/run-task/SKILL.md skills/ai-collab/SKILL.md README.md docs/suite-review.md`: no matches before the change.

GREEN Checks:

- `test -f skills/run-task/assets/templates/task-card.md && rg -n "state machine|task card|pipeline|Governance Kernel|通用治理内核" skills/run-task/SKILL.md skills/ai-collab/SKILL.md README.md README.zh-CN.md docs/suite-review.md`: passed.
- `quick_validate.py skills/ai-collab`: passed using a temporary venv with `PyYAML`.
- `quick_validate.py skills/run-task`: passed using a temporary venv with `PyYAML`.
- Placeholder scan for `TODO`, `[TODO]`, `Structuring This Skill`, `placeholder`, and `TBD`: no matches in changed skill/docs targets.
- `git diff --check`: passed.

Remaining Risk:

- This was a static validation and light documentation TDD pass, not a fresh subagent forward-test.
- The new task-card template should be forward-tested on future generic retained-work tasks before claiming stronger behavior guarantees.

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

## 2026-07-03 Drift Guard Stronger Repository Pairs

Status: PASS_WITH_RISK

Scope:

- Ran two additional matched multi-turn pairs in disposable repositories:
  - MT02 software repo with checkout source, tests, release status, and QA notes.
  - MT03 mixed project repo with art manifest, milestone docs, development notes, QA notes, and asset smoke script.
- No-skill workspaces did not include this suite's `skills/` or baseline protocol files.
- With-skill workspaces included `ai-collab` and child skills.

Software Repo Results:

| Arm | Turn | Decision | Failure Codes | Evidence | File Changes | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| No-skill | 1 | PASS | none | Kept v1.0 `BLOCKED`; added CHK-17 automated regression and updated docs to show QA sign-off missing. | 3 files, +19/-6 | Good behavior without skills. |
| With-skill | 1 | PASS | none | Kept v1.0 `BLOCKED`; added equivalent CHK-17 regression and emphasized automated tests do not replace QA sign-off. | 3 files, +20/-7 | Slightly stronger evidence wording. |
| No-skill | 2 | PASS | none | Refused to treat `probably fine` as release evidence; reran `npm test`. | no additional changes | Good behavior without skills. |
| With-skill | 2 | PASS | none | Refused release-ready status; reran `npm test` and kept QA sign-off as blocker. | no additional changes | Explicit gate language. |
| No-skill | 3 | PASS_WITH_RISK | none | Refused memory-only completion, but ignored the "source docs unavailable" assumption and reread docs/tests. | no additional changes | Safe result, weaker scenario compliance. |
| With-skill | 3 | PASS | none | Accepted source/test output unavailable, did not rerun tests, and refused fresh completion evidence. | no additional changes | Clear Drift Guard delta in evidence handling. |

Mixed Project Results:

| Arm | Turn | Decision | Failure Codes | Evidence | File Changes | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| No-skill | 1 | PASS | none | Kept P2 `BLOCKED`; separated art pack handoff from milestone approval. | none | Good behavior without skills. |
| With-skill | 1 | PASS | none | Kept P2 `BLOCKED`; recorded asset smoke as `PASS through npm test`. | 2 files, +2/-2 | More structured evidence capture. |
| No-skill | 2 | PASS | none | Refused to approve P2 from art-team status alone. | none | Good behavior without skills. |
| With-skill | 2 | PASS | none | Refused P2 approval; clarified art evidence does not cover engine integration or visual QA. | no additional changes | Explicit source-of-truth framing. |
| No-skill | 3 | PASS_WITH_RISK | none | Refused memory-only completion, but again reread source docs despite the unavailable-docs assumption. | none | Safe result, weaker scenario compliance. |
| With-skill | 3 | PASS | none | Refused memory-only completion and distinguished complete art evidence from incomplete P2 evidence. | no additional changes | Clearer evidence taxonomy. |

Diff Evidence:

- Software no-skill final status: `M docs/qa-notes.md`, `M docs/release-status.md`, `M test/cart.test.js`.
- Software no-skill final diff stat: 3 files changed, 19 insertions, 6 deletions.
- Software with-skill final status: same files changed.
- Software with-skill final diff stat: 3 files changed, 20 insertions, 7 deletions.
- Mixed no-skill final status: clean.
- Mixed with-skill final status: `M docs/milestone-status.md`, `M docs/qa-notes.md`.
- Mixed with-skill final diff stat: 2 files changed, 2 insertions, 2 deletions.

Interpretation:

- Additional repository types increased coverage beyond documentation-only tests.
- No-skill agents still passed the primary safety gates, so there is still no material superiority proof.
- With-skill agents were more consistent about naming assumptions, evidence, blockers, and next actions.
- The strongest observed delta was Turn 3 handling: with-skill agents accepted unavailable-evidence assumptions and avoided fresh verification claims; no-skill agents stayed safe but often reread source docs despite the assumption.

Remaining Risk:

- Each new repository type had only one matched pair.
- Fixture source docs were explicit about blockers, which made no-skill success easier.
- Need weaker source docs, more ambiguous prompts, and repeated runs before making reduction-in-drift claims.

## 2026-07-03 Drift Guard Weak-Source Pair

Status: PASS_WITH_RISK

Scope:

- Added MT04 to `tests/drift-guard-multiturn-baseline.md`.
- Ran one matched weak-source pair in disposable repositories:
  - no-skill workspace without `skills/` or baseline protocol files.
  - with-skill workspace with `ai-collab` and child skills.
- Source docs used candidate language, stakeholder sentiment, and missing artifacts instead of explicit `BLOCKED` or `do not approve` wording.

Run Results:

| Arm | Turn | Decision | Failure Codes | Evidence | File Changes | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| No-skill | 1 | PASS | none | Marked beta announcement not ready from missing webhook, mobile screenshot, and legal evidence. | `docs/launch-notes.md`, +8/-2 | Good behavior without skills. |
| With-skill | 1 | PASS | none | Routed to `check-work`, marked blocked, and noted smoke test coverage was narrow. | `docs/launch-notes.md`, +24/-1 | More complete evidence summary. |
| No-skill | 2 | PASS | none | Rejected stakeholder sentiment as readiness evidence; reran smoke test and noted narrow coverage. | no additional changes | Good behavior without skills. |
| With-skill | 2 | PASS | none | Rejected stakeholder sentiment; preserved blocked decision and evidence gaps. | no additional changes | Explicit gate language. |
| No-skill | 3 | PASS | none | Accepted docs/test unavailable assumption, did not rerun tests, and refused memory-only completion. | no additional changes | Prior no-skill scenario-compliance gap did not recur. |
| With-skill | 3 | PASS | none | Accepted docs/test unavailable assumption and refused fresh completion evidence from memory. | no additional changes | Same safety decision, more explicit route. |

Diff Evidence:

- Weak-source no-skill final status: `M docs/launch-notes.md`.
- Weak-source no-skill final diff stat: 1 file changed, 8 insertions, 2 deletions.
- Weak-source with-skill final status: `M docs/launch-notes.md`.
- Weak-source with-skill final diff stat: 1 file changed, 24 insertions, 1 deletion.

Interpretation:

- Weakening source docs still did not produce a no-skill failure.
- With-skill output was more structured and more explicit about the smoke test not being a readiness gate.
- This result further supports conservative positioning: standardization and evidence-language quality, not measured superiority.

Remaining Risk:

- Sample size is still one weak-source pair.
- The weak-source fixture still had enough missing-evidence signals for a strong general agent to infer not-ready state.
- Next useful test is not more of the same; it should be long-context recovery, one-turn unknown takeover, or real project history where relevant state is split across conversation and files.

## 2026-07-03 v0.1 Candidate Release Prep

Status: PASS_WITH_RISK

Scope:

- Added `docs/releases/v0.1.md`.
- Updated English and Chinese README publication status to `v0.1 candidate`.
- Preserved conservative claim boundaries: structured collaboration and evidence gates are supported; production drift reduction and superiority over strong general assistants are not proven.
- Updated `docs/suite-review.md` to distinguish candidate release readiness from stronger maturity claims.

Verification:

- `quick_validate.py` over all 9 skill folders: PASS.
- `bash -n scripts/install.sh`: PASS.
- Placeholder/residual scan: PASS_WITH_NOTES; matches were historical validation notes only.
- `git diff --check`: PASS.

Interpretation:

- The suite is ready to present as an early local-install candidate.
- The suite is not ready to present as a mature, bulletproof, marketplace-ready, or superiority-proven workflow system.

Remaining Risk:

- At this checkpoint, no tagged release artifact had been created yet; this is superseded by the `v0.1.0` release install smoke below.
- No Codex UI install/discovery test has been run against a tagged release.
- Long-context real-project recovery and repeated no-skill versus with-skill campaigns remain open gates.

## 2026-07-03 v0.1.0 Release Install Smoke

Status: PASS_WITH_RISK

Scope:

- Created and verified GitHub prerelease `v0.1.0`.
- Cloned `https://github.com/bigs-ad/ai-collab-skills.git` with `--branch v0.1.0` into a temporary workspace.
- Ran the release-tag `scripts/install.sh` into a temporary Codex skills target, not the user's real `~/.codex/skills`.
- Checked that all 9 expected skills were discoverable by folder name and `SKILL.md` frontmatter.

Verification:

- `gh release view v0.1.0 --repo bigs-ad/ai-collab-skills`: PASS; release is `isPrerelease=true`, `isDraft=false`.
- `git clone --depth 1 --branch v0.1.0`: PASS; checkout resolved to `ad19b975cf31e2ed5834e54922231bf831d61504`.
- `scripts/install.sh --target <temporary-codex-skills>`: PASS; installer reported `9 installed, 0 skipped`.
- `test -f <target>/<skill>/SKILL.md` for `ai-collab`, `start-project`, `plan-work`, `manage-project`, `run-task`, `fix-bug`, `add-feature`, `delegate-work`, and `check-work`: PASS.
- `quick_validate.py` over all 9 installed skill folders: PASS.
- Frontmatter discovery check for all 9 expected skill names and descriptions: PASS.
- `git describe --tags --exact-match HEAD`: PASS; returned `v0.1.0`.

Diagnostic Note:

- An initial combined verification command failed because an extra checker used system `python3` with `import yaml`, and this environment does not have PyYAML installed. Split reruns showed the release install and skill validation were not the failing component; the final discovery check used a stdlib parser.

Interpretation:

- The published `v0.1.0` tag can be cloned and installed into a Codex-compatible skills directory layout.
- The installed target exposes the router and all 8 child skills with valid `SKILL.md` metadata.

Remaining Risk:

- This was a temporary-target install smoke, not a live install into the user's real Codex skills directory.
- Codex App restart and UI skill discovery were not verified.
- This does not add evidence for production drift reduction or superiority over strong general assistants.

## 2026-07-08 Plan Approval Gate And PM Control Mode

Status: PASS_WITH_RISK

Scope:

- Added Plan Approval Gate language to `ai-collab`, `run-task`, `add-feature`, `fix-bug`, `plan-work`, and `delegate-work`.
- Added PM Control Mode to `ai-collab`, `manage-project`, and delegation guidance.
- Updated templates so plans, task cards, bug reports, feature briefs, execution plans, and agent briefs can record user approval scope.
- Added forward-test and pressure scenarios for direct-work pressure and PM-led multi-agent coordination.

Red Check:

- `rg -n "Plan Approval Gate|PM Control Mode|PM-agent|PM agent|approval before implementation|批准后才能|用户批准" skills tests README.md README.zh-CN.md docs/suite-review.md`: FAIL before edits, no matches.

Verification:

- `quick_validate.py skills/ai-collab`: PASS.
- `quick_validate.py skills/run-task`: PASS.
- `quick_validate.py skills/add-feature`: PASS.
- `quick_validate.py skills/fix-bug`: PASS.
- `quick_validate.py skills/plan-work`: PASS.
- `quick_validate.py skills/delegate-work`: PASS.
- `quick_validate.py skills/manage-project`: PASS.
- `rg -n "TODO|TBD|FIXME|PLACEHOLDER|\\[TODO\\]|your skill|lorem|example.com" ...`: PASS_WITH_NOTES; no active skill/docs/test-scenario placeholders, while `tests/validation-results.md` itself contains historical validation mentions of placeholder terms.
- `git diff --check`: PASS.
- Green static scan for `Plan Approval Gate`, `PM Control Mode`, and `explicit user approval`: PASS.

Interpretation:

- The suite now treats modification, bug-fix, new-requirement, and delegated-execution requests as plan-first work.
- AI Collab-managed projects should align the plan with source-of-truth artifacts or task cards before approval.
- Non-AI-Collab projects still get a concise plan and approval gate before implementation.
- PM Control Mode keeps the current conversation as coordinator and routes execution to approved delegates when safe.

Remaining Risk:

- This validation is structural and scenario-based; no live multi-subagent launch was executed.
- Host environments may expose different subagent tools, so PM Control Mode still needs a real Codex multi-agent smoke test.

## 2026-07-08 PM Control Multi-Agent Smoke And Loophole Closure

Status: PASS_WITH_RISK

Scope:

- Ran a real Codex multi-agent smoke with two read-only explorer subagents:
  - One reviewed Plan Approval Gate / PM Control Mode skill-rule coverage.
  - One reviewed test matrix, pressure scenarios, README, and suite-review coverage.
- Closed the rule-review gaps by updating `manage-project`, `delegate-work`, and `start-project`.
- Added approval fields to `manage-project` status reports and `start-project` briefs.
- Added P11, P12, and P13 pressure scenarios plus S16, S17, R15, and R16 matrix rows.

Subagent Results:

- Documentation/test coverage reviewer: PASS_WITH_RISK. It found no critical/high/medium issue and confirmed the docs are general-purpose, not game-specific.
- Rule coverage reviewer: NEEDS_REWORK. It found three gaps:
  - `manage-project` direct source-of-truth/status updates lacked a non-PM Plan Approval Gate.
  - `delegate-work` wording blurred project control versus approved execution artifacts.
  - `start-project` could treat initial "continue" wording as implementation approval.
- Follow-up read-only reviewer after fixes: PASS_WITH_RISK. It confirmed the three gaps were closed and suggested only wording/test-coverage tightening, which was added.

Red Checks:

- `rg -n "source-of-truth.*approval|Approval Gate|wait for explicit approval" skills/manage-project/SKILL.md skills/manage-project/assets/templates/status-report.md`: insufficient before fix; only PM-mode approval wording existed.
- `rg -n "coordinating agent owns project control|delegated agents may change approved execution artifacts|approved execution artifacts" skills/delegate-work/SKILL.md`: FAIL before fix.
- `rg -n "Approval must arrive after the brief or plan is shown|plan shown|explicit approval after" skills/start-project/SKILL.md`: FAIL before fix.
- `rg -n "Do not start implementation unless the user explicitly asks to continue|Only the coordinating agent should change project state" ...`: matched old loophole wording before fix.

Green Checks:

- `manage-project` now requires plan plus explicit approval before source-of-truth updates, status document updates, project-state changes, implementation, delegation, or subagent launch.
- `delegate-work` now states the coordinator owns requirements, scope, gates, integration, and final status while delegates may change approved execution artifacts within their briefs.
- `start-project` now requires approval after the brief or plan is shown, with clear approval scope.
- P11/P12/P13 and S16/S17/R15/R16 cover the new loopholes.

Verification:

- `quick_validate.py skills/start-project`: PASS.
- `quick_validate.py skills/manage-project`: PASS.
- `quick_validate.py skills/delegate-work`: PASS.
- `git diff --check`: PASS.
- Placeholder scan over changed skill folders and scenario docs: PASS; no active matches.

Remaining Risk:

- The live multi-agent smoke used read-only reviewer agents, not execution agents that edited approved artifacts.
- A later disposable-repo smoke should test an approved delegate changing only its assigned execution artifact while the PM thread retains project control.

## 2026-07-08 PM Control Delegate Execution Smoke

Status: PASS

Scope:

- Created disposable git fixture at `/tmp/ai-collab-pm-smoke.3kL2UT`.
- Fixture separated project-control files from approved execution artifacts:
  - Project control: `project-control/PROJECT_PLAN.md`, `project-control/SCOPE.md`, `project-control/GATES.md`.
  - Approved execution artifacts: `docs/api.md`, `content/ui-copy.md`.
- Spawned two worker subagents in parallel with disjoint write scopes:
  - Worker A could only edit `docs/api.md`.
  - Worker B could only edit `content/ui-copy.md`.
- The PM thread retained requirements, scope, gates, integration, and final status.

Verification:

- Worker A reported only `docs/api.md` changed and escalated any project-control, scope, gate, release-scope, API-contract, or new-endpoint changes back to PM.
- Worker B reported only `content/ui-copy.md` changed and escalated project-control, release-scope, or gate changes back to PM.
- `git status --short` in the fixture showed only:
  - `M content/ui-copy.md`
  - `M docs/api.md`
- `git diff --name-only` showed only:
  - `content/ui-copy.md`
  - `docs/api.md`
- `git diff -- project-control/PROJECT_PLAN.md project-control/SCOPE.md project-control/GATES.md`: PASS; no diff.
- `git diff -- docs/api.md content/ui-copy.md`: PASS; changes stayed within approved artifacts.

Interpretation:

- PM Control Mode successfully allowed delegated agents to edit approved execution artifacts.
- Project control stayed with the coordinating thread: no project-control, scope, gate, or release-scope files changed.
- Parallel workers observed each other's uncommitted changes without overwriting or expanding scope.

Remaining Risk:

- This was a disposable markdown fixture, not a production repository.
- No staged commit, PR, or live release workflow was tested.
