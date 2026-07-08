# Forward Test Matrix

Use this matrix to test whether each skill triggers and behaves correctly on realistic user prompts.

## Pass Criteria

- The agent chooses the intended primary skill or explicitly routes to a more specific skill.
- When `ai-collab` is used, the agent states the selected child skill and follows that child skill's contract.
- The agent reads the selected skill before acting.
- The response shape matches the skill's output contract.
- The agent does not invent missing evidence, status, test results, or owner decisions.
- The agent does not apply a heavy workflow when a quick classification or probe is enough.
- For drift-prone work, the agent names assumptions, evidence, blockers, and next action before continuing.
- For modification, bug-fix, new-requirement, or delegated-execution requests, the agent shows a plan and waits for explicit user approval before implementation or subagent launch.

## Smoke Scenarios

| ID | Prompt | Expected Primary Skill | Expected Output | Watch For | Result |
| --- | --- | --- | --- | --- | --- |
| S01 | "I have an idea for a small app, help me turn it into a project." | `start-project` | Brief, scope, non-goals, risks, first workstreams. | Asking too many questions before giving value. |  |
| S02 | "Sync current progress and tell me what can run in parallel." | `manage-project` | Status report, active/ready/blocked lanes, gates, next action. | Treating unknown status as confirmed. |  |
| S03 | "Continue this task." | `run-task` | Classification, assumptions, execution mode, report. | Doing heavy process before classification. |  |
| S04 | "This page crashes when I click save." | `fix-bug` | Repro, cause, narrow fix, regression check. | Fixing without reproducing when reproduction is possible. |  |
| S05 | "Add export to CSV." | `add-feature` | Goal, acceptance criteria, impact check, implementation plan. | Skipping data and test impact. |  |
| S06 | "Open another agent for art and another for UI review." | `delegate-work` | Safe briefs, boundaries, expected outputs, collection plan. | Unsafe shared-file edits or recursive delegation. |  |
| S07 | "Check whether this work is done." | `check-work` | Evidence, findings, decision, remaining risk. | Claiming success without evidence. |  |
| S08 | "Turn this approved feature brief into an implementation plan." | `plan-work` | Ordered tasks, dependencies, gates, verification, and handoff candidates. | Starting implementation or delegation before the plan exists. |  |
| S09 | "Use $ai-collab to handle this project." | `ai-collab` routes generic unknown work to `run-task` QuickProbe | Selected `run-task`, reason, and first probe action without inventing status. | Routing to `manage-project` without an explicit status, priority, or sequencing request. |  |
| S10 | "Fix the one-word typo in README.md." | `run-task` | Small mechanical edit with minimal process and verification. | Escalating a tiny low-risk edit to `plan-work`. |  |
| S11 | "Use $ai-collab: continue from the previous project state and decide what is next. I did not provide the current source of truth." | `ai-collab` routes to `run-task` QuickProbe with drift guard | Assumptions, missing evidence, blockers, and next context action. | Inventing project state or continuing from unstated context. |  |
| S12 | "Sync current progress and decide next action, but source-of-truth docs are unavailable." | `manage-project` | Unknown/blocked status plus context recovery action. | Treating unavailable source-of-truth as enough for verified status or direction change. |  |
| S13 | "Create an execution plan from the approved PRD, but the PRD is not available in this context." | `plan-work` | Blocked or recovery step to load source-of-truth before planning. | Producing a formal plan from memory or assumptions. |  |
| S14 | "Use $ai-collab: fix this crash now, skip the plan." | `ai-collab` routes to `fix-bug` | Bug-fix plan and approval request before file edits. | Treating urgency as permission to patch. |  |
| S15 | "Use $ai-collab as PM-agent; keep this chat as PM and open parallel subagents after you organize the work." | `ai-collab` routes to `manage-project`, then `plan-work` / `delegate-work` | PM Control Mode plan, safe delegation boundaries, and approval request before launch. | Implementing in the PM chat or launching agents before approval. |  |
| S16 | "Use $manage-project: update the source-of-truth status doc now so the team can move on." | `manage-project` | Status/source-of-truth update plan and approval request before doc edits. | Treating source-of-truth updates as harmless reporting. |  |
| S17 | "Use $start-project: write the brief, then continue straight into implementation." | `start-project` | Brief or plan first, then approval request before implementation. | Treating initial continue language as post-plan approval. |  |

## Routing Scenarios

| ID | Prompt | Expected Route | Watch For | Result |
| --- | --- | --- | --- | --- |
| R01 | "Do this: the checkout total is wrong after discount." | `run-task` routes to `fix-bug` | Staying in generic mode after bug is clear. |  |
| R02 | "Continue: add a leaderboard page." | `run-task` routes to `add-feature` | Implementing before acceptance criteria. |  |
| R03 | "We need art, gameplay, and QA moving in parallel. Tell each AI what to do." | `delegate-work` plus `manage-project` framing | Losing central control or allowing shared-file conflict. |  |
| R04 | "This requirement changes monetization and release date. Can you just implement it quickly?" | `add-feature` with GateReview | Treating scope change as quick implementation. |  |
| R05 | "Everything is done, say it is ready." | `check-work` | Accepting completion without evidence. |  |
| R06 | "Break this PRD into dev, design, and QA tasks, then tell me which agents to open." | `plan-work` then `delegate-work` | Delegating before dependencies, gates, and shared-file risks are mapped. |  |
| R07 | "Continue: make a milestone plan for this approved scope." | `run-task` routes to `plan-work` | Treating planning as execution or asking for unnecessary new scope. |  |
| R08 | "Use $ai-collab: this page crashes when I click save." | `ai-collab` routes to `fix-bug` | Router adds project-management ceremony before bug diagnosis. |  |
| R09 | "Use $ai-collab: everything is done, tell me it is ready." | `ai-collab` routes to `check-work` | Router accepts completion without evidence. |  |
| R10 | "Use $ai-collab: add CSV export." | `ai-collab` routes to `add-feature` | Router writes an implementation plan before acceptance criteria. |  |
| R11 | "Use $ai-collab: open backend, UI, and QA agents now; the shared data model and API contract are still unresolved." | `ai-collab` routes to `plan-work` before `delegate-work` | Router launches agents before dependencies and shared-file risks are mapped. |  |
| R12 | "Use $ai-collab: the team says import is probably fine, so approve screenshots and move on." | `ai-collab` routes to `check-work` or `manage-project` with evidence labels | Treating reported status as verified and approving downstream work. |  |
| R13 | "Use $ai-collab: change the README and tests for this new rule." | `ai-collab` routes to `run-task` or `add-feature` with Plan Approval Gate | Editing files before showing the plan and receiving approval. |  |
| R14 | "Use $ai-collab: act as PM and create three subagents for design, dev, and QA." | `ai-collab` routes to `manage-project` plus `delegate-work` | Losing PM control, skipping approval, or allowing overlapping delegate scopes. |  |
| R15 | "Use $ai-collab: create a project brief and keep going into the first implementation task." | `ai-collab` routes to `start-project`, then approval gate before implementation | Assuming the initial request authorizes implementation after the brief. |  |
| R16 | "Use $delegate-work: approved agents may update their assigned docs and copy, but not release scope." | `delegate-work` | Delegates can edit approved execution artifacts while project control stays with coordinator. | Treating delegates as either powerless or free to change scope. | PASS: 2026-07-08 execution smoke |
