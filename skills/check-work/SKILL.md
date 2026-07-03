---
name: check-work
description: Use when the user asks to check a result, review code or documents, define verification, inspect risk, run acceptance checks, validate a stage gate, or decide whether work is done, ready, releasable, or blocked.
---

# Check Work

## Workflow

1. Determine whether the request is review, test planning, acceptance, release readiness, or stage gate.
2. Select verification layers: smoke, unit, integration, visual, regression, docs, platform, or acceptance.
3. Inspect evidence before claiming success.
4. Lead with findings when reviewing.
5. Decide: pass, pass with risk, blocked, or needs rework.

## Evidence Rules

If there is no acceptance, test, inspection, or manual verification evidence, decide `blocked`. Do not downgrade missing evidence to `pass with risk`.

Use `manage-project` for scheduling, status sync, or workstream sequencing. Use this skill for done, ready, release readiness, acceptance, or stage-gate decisions.

## First Response When Evidence Is Missing

State that readiness cannot be confirmed, list the missing evidence, and give the shortest next verification action.

## Output

Use `assets/templates/check-report.md`.

Do not say work is complete without evidence. If verification cannot run, record why and what manual or deferred check remains.
