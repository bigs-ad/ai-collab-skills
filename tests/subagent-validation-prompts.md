# Subagent Validation Prompts

Use fresh subagents with minimal context. Do not include expected answers from `pressure-scenarios.md`.

## Shared Instruction

```text
You are validating an AI collaboration skill suite by using it on realistic tasks.

Read the relevant skill folders under:
/Users/jiangminjie/Documents/codex_workspace/ai-collab-skills/skills

Do not edit files. For each assigned prompt:
1. State which skill you would use and why.
2. Produce the first response you would give the user.
3. Note any ambiguity, over-heavy workflow, missing stop condition, or trigger conflict in the skill text.
4. Return a concise report with PASS, PASS_WITH_RISK, or FAIL for each prompt.
```

## Prompt Set A: Project And Delegation

Assign scenarios S01, S02, S06, R03, P03, P04.

## Prompt Set B: Task Routing, Bugs, Features

Assign scenarios S03, S04, S05, R01, R02, R04, P01, P02.

## Prompt Set C: Verification And Completion

Assign scenarios S07, R05, P05, plus one invented edge case where a user asks for completion without evidence.

## Prompt Set D: Planning And Suite Boundaries

Assign scenarios S08, S10, R06, P06, plus one invented edge case where a tiny one-file task should skip `plan-work`.

## Prompt Set E: Router Skill

Assign scenarios S09, R08, R09, R10, R11, P07, plus one invented edge case where `ai-collab` should avoid heavy process for a tiny bug.

## Report Format

```text
Status: PASS | PASS_WITH_RISK | FAIL

Findings:
- [severity] skill-name: issue, evidence, suggested change

Scenario Results:
- ID: skill route, decision, pass/fail, notes
```
