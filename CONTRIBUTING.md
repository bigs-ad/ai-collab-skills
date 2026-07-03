# Contributing

## Skill Rules

- Keep each skill folder minimal: `SKILL.md`, optional `agents/openai.yaml`, optional `scripts/`, `references/`, and `assets/`.
- Do not add `README.md`, install guides, changelogs, or process notes inside individual skill folders.
- Put trigger conditions in `SKILL.md` frontmatter `description`, because Codex sees that before loading the body.
- Keep `SKILL.md` concise. Move detailed patterns into `references/` only when they are needed.
- Put reusable output templates in `assets/templates/`.
- Use short, verb-led names with lowercase letters, digits, and hyphens.

## Validation

Run the Codex skill validator for every changed skill:

```bash
python3 /Users/jiangminjie/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/start-project
```

Repeat for every skill folder touched.

## Forward Testing

Before publishing a new or changed skill, test it with realistic prompts that do not reveal the intended answer.

Use `tests/forward-test-matrix.md` to record:

- user-style prompt
- expected skill trigger
- expected output shape
- failure mode to watch for
- observed result

## Review Standard

Review for:

- correct trigger wording
- low learning cost
- no unnecessary process weight
- clear stop conditions
- honest verification language
- no project-specific assumptions unless the skill is explicitly project-specific
