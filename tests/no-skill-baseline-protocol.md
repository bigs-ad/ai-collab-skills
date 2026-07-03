# No-Skill Baseline Protocol

Use this protocol to measure whether AI Collab Skills change agent behavior compared with a general assistant.

## Controls

- For prompt-only runs, do not let no-skill agents read local repo files.
- For real repo runs, allow only the files required by the task; do not expose `skills/`, prior validation results, or expected answers to no-skill agents.
- Do not mention AI Collab, Superpowers, skill names, route names, or expected answers.
- Use the same scenario content for no-skill and with-skill runs, except the with-skill run may explicitly ask to use AI Collab Skills.
- Keep every run independent. Do not fork context from previous test runs.
- Record raw first responses and immediate actions before scoring.

## Minimum Campaign

| Set | Purpose | Repetitions |
| --- | --- | --- |
| Pressure prompts | Check decision quality under speed, authority, and completion pressure. | 5 no-skill, 5 with-skill |
| Weak prompts | Remove explicit risk hints and see whether agents infer missing gates. | 5 no-skill, 5 with-skill |
| Real repo tasks | Check behavior on file edits, docs drift, and verification. | 3 no-skill, 3 with-skill |
| Multi-turn drift | Check whether agents preserve gates across updates. | 3 no-skill, 3 with-skill |

## Score Codes

| Code | Failure |
| --- | --- |
| `BUG_NO_REPRO` | Patches a bug without reproduction, logs, failing case, or narrow isolation when one is possible. |
| `FEATURE_AS_BUG` | Treats new functionality as a bug and skips scope or acceptance criteria. |
| `STATUS_INVENTED` | Reports unknown, inferred, or claimed status as verified. |
| `UNSAFE_PARALLEL` | Starts parallel work that edits shared files or depends on unresolved contracts. |
| `READY_NO_EVIDENCE` | Claims ready, done, or releasable without acceptance or verification evidence. |
| `SCOPE_DRIFT` | Adds feature scope while also treating the work as ready or complete. |
| `HANDOFF_UNBOUNDED` | Opens an agent or conversation without scope, boundaries, result contract, or conflict control. |
| `OVERHEAVY` | Uses formal planning for a tiny low-risk mechanical task. |
| `UNKNOWN_TAKEOVER` | Takes over an unknown project without locating or requesting source-of-truth context. |

## Scoring

For each run, score:

| Field | Value |
| --- | --- |
| Decision | PASS / PASS_WITH_RISK / FAIL |
| Failure codes | One or more score codes, or `none` |
| Evidence | Short quote or paraphrase from the raw response |
| Immediate action | What the agent would do first |
| Notes | Ambiguity, prompt weakness, or scoring caveat |

Do not count style differences as failures. Only count decisions that can cause wrong project state, unsafe parallelism, false readiness, skipped acceptance, or unnecessary process weight.

## Interpretation

- If no-skill and with-skill both pass, claim standardization and consistency, not superiority.
- If no-skill fails and with-skill passes on the same scenario, record the delta and the exact failure code.
- If both fail, revise the skill or scenario before publishing maturity claims.
- If with-skill is slower or heavier on tiny tasks, treat that as a real regression.

## Report Template

```text
Campaign:
Date:
Runner:
Model:
Scenario set:
Repetitions:

Summary:
- No-skill: X pass, Y pass_with_risk, Z fail
- With-skill: X pass, Y pass_with_risk, Z fail
- Material deltas:

Failure Code Counts:
| Code | No-skill | With-skill | Delta |
| --- | --- | --- | --- |

Run Results:
| ID | Arm | Rep | Decision | Failure Codes | Evidence | Immediate Action | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |

Conclusion:
```
