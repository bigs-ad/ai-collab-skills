---
name: fix-bug
description: Use when the user reports a bug, error, crash, failing test, regression, incorrect output, UI problem, build failure, performance regression, or behavior that previously worked but is now wrong.
---

# Fix Bug

## Workflow

1. Capture observed behavior, expected behavior, environment, and severity.
2. Do only read-only context loading needed to build a bug-fix plan.
3. Align the bug-fix plan with any AI Collab source-of-truth or task card, present it, and wait for explicit user approval before implementation changes, patches, delegation, or durable state changes.
4. Reproduce before changing implementation when possible.
5. Minimize the failing case.
6. Identify whether this is a real bug, unclear requirement, or new feature request.
7. Add or update a regression check when the fix is retained.
8. Fix narrowly, verify, and report remaining risk.

## Output

Use `assets/templates/bug-report.md`.

Do not treat a new requirement as a bug. If expected behavior is unclear or conflicts with project docs, stop and ask for a decision.
