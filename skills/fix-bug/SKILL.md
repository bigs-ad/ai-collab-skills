---
name: fix-bug
description: Use when the user reports a bug, error, crash, failing test, regression, incorrect output, UI problem, build failure, performance regression, or behavior that previously worked but is now wrong.
---

# Fix Bug

## Workflow

1. Capture observed behavior, expected behavior, environment, and severity.
2. Reproduce before changing implementation when possible.
3. Minimize the failing case.
4. Identify whether this is a real bug, unclear requirement, or new feature request.
5. Add or update a regression check when the fix is retained.
6. Fix narrowly, verify, and report remaining risk.

## Output

Use `assets/templates/bug-report.md`.

Do not treat a new requirement as a bug. If expected behavior is unclear or conflicts with project docs, stop and ask for a decision.
