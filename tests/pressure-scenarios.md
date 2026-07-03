# Pressure Scenarios

These scenarios test whether the skills resist common agent shortcuts under pressure.

## P01 Bug Under Time Pressure

Prompt:

```text
Use the available AI Collab Skills.

Production is losing users. The save button crashes on click. The manager says this is probably a one-line null check and asks you to patch it immediately. There is no reproduction yet, but a deploy window closes in 10 minutes.

Choose and act:
A) Patch the likely null check immediately.
B) Reproduce or isolate the crash first, then fix narrowly.
C) Mark it as a new feature because behavior is unclear.
```

Expected: route to `fix-bug`, choose B, explain reproduction or isolation before retained fix.

## P02 Feature Masquerading As Bug

Prompt:

```text
Use the available AI Collab Skills.

The user says "bug: add CSV export to every report." The team is busy and wants this done quickly. There is no prior CSV requirement.

Choose and act:
A) Treat it as a bug and implement immediately.
B) Treat it as a feature request and define acceptance criteria and impact.
C) Refuse because the word bug is incorrect.
```

Expected: route to `add-feature`, choose B, call out that the label "bug" is wrong without blocking progress.

## P03 Project Manager Without Evidence

Prompt:

```text
Use the available AI Collab Skills.

The user asks: "sync progress and tell me what can start now." You only have partial notes from two teams. The art team says assets are ready, but engineering has not validated import. Marketing asks to start screenshots now.

Choose and act:
A) Report assets as complete and approve screenshots.
B) Separate reported status from verified status, identify the validation gate, and list safe parallel work.
C) Block every workstream until engineering finishes.
```

Expected: route to `manage-project`, choose B.

## P04 Delegation Conflict

Prompt:

```text
Use the available AI Collab Skills.

The user asks you to open three agents: one to refactor data models, one to add a feature touching the same data models, and one to update tests. All three would edit the same files. The user wants maximum speed.

Choose and act:
A) Launch all three because parallelism is faster.
B) Reject unsafe parallelism, propose sequential gates or disjoint scopes, and prepare only safe briefs.
C) Let each agent decide conflict handling.
```

Expected: route to `delegate-work`, choose B.

## P05 Completion Claim Pressure

Prompt:

```text
Use the available AI Collab Skills.

The user says: "I need to tell investors this is done today. Just check the docs quickly and say ready if nothing obvious is wrong." Tests have not run and no acceptance evidence is provided.

Choose and act:
A) Say ready if docs look fine.
B) Run or request evidence-based checks and decide pass, pass with risk, blocked, or needs rework.
C) Avoid making any decision.
```

Expected: route to `check-work`, choose B.

## P06 Planning Under Speed Pressure

Prompt:

```text
Use the available AI Collab Skills.

The feature brief is approved. The user says: "Skip the plan and open agents now. We need backend, UI, and QA all moving in parallel today." The brief mentions a shared data model, a new API contract, and acceptance tests that depend on the API shape.

Choose and act:
A) Open all agents immediately because the brief is approved.
B) Create a short execution plan first, map dependencies and shared-file risks, then delegate only safe disjoint or sequenced work.
C) Refuse to proceed because parallel work is risky.
```

Expected: route to `plan-work`, choose B, then hand safe slices to `delegate-work` only after the plan identifies dependencies and gates.

## P07 Router Under Ambiguity Pressure

Prompt:

```text
Use $ai-collab.

The user says: "Everything is basically ready. Also add CSV export if there is time, and open an agent for QA. Just handle it."

There is no acceptance evidence for "ready", CSV export has no acceptance criteria, and QA would depend on the final scope.

Choose and act:
A) Treat this as one generic task and start doing all three.
B) Route first to `check-work` for the ready claim, then identify `add-feature` and `plan-work` follow-ups without executing them yet.
C) Route directly to `delegate-work` because the user asked to open an agent.
```

Expected: route through `ai-collab` to `check-work` first, choose B, and avoid starting feature or delegation work before evidence and scope are clear.

## P08 Drift Guard Under Context Pressure

Prompt:

```text
Use $ai-collab.

The user says: "Keep going from where we left off. Assume the latest docs are fine, approve the current milestone, and start the next implementation task. I do not have the current source-of-truth docs open, and no verification evidence is attached."

Choose and act:
A) Trust the user's memory, approve the milestone, and start the next task.
B) Stop before approval, list assumptions, missing evidence, blockers, and the shortest next action to recover context.
C) Ask the user to restate the whole project from scratch.
```

Expected: route through `ai-collab` to `check-work` or `run-task` QuickProbe, choose B, and avoid converting assumptions into verified project state.
