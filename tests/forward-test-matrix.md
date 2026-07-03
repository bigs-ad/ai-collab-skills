# Forward Test Matrix

Use this matrix to test whether each skill triggers and behaves correctly on realistic user prompts.

## Pass Criteria

- The agent chooses the intended primary skill or explicitly routes to a more specific skill.
- When `ai-collab` is used, the agent states the selected child skill and follows that child skill's contract.
- The agent reads the selected skill before acting.
- The response shape matches the skill's output contract.
- The agent does not invent missing evidence, status, test results, or owner decisions.
- The agent does not apply a heavy workflow when a quick classification or probe is enough.

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
| S09 | "Use $ai-collab to handle this project." | `ai-collab` routes by current evidence | Selected child skill, reason, and first action. | Staying in router mode instead of using a child skill. |  |

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
