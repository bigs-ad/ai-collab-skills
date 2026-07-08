# AI Collab Skills 中文说明

[English README](README.md)

AI Collab Skills 是一组面向 Codex 的项目协作技能，用来处理项目启动、计划拆解、进度总控、任务执行、Bug 修复、新需求、委派交接和验收审查。

它的目标不是替代具体工程技能，而是给 AI 一套跨项目可复用的协作治理方式：什么时候该快速处理，什么时候该正式计划，什么时候必须停下来补证据，什么时候可以把任务交给别的对话或 subagent。

## 解决什么问题

- 降低用户学习成本：大多数时候只需要调用 `ai-collab`。
- 降低跑偏风险：把假设、证据、阻塞、下一步显式写出来，让偏移更早暴露。
- 避免流程过重：按任务风险选择 QuickProbe、Candidate、Formalize、GateReview。
- 管理多条工作线：用 `manage-project` 同步状态、优先级、依赖和下一步。
- 规范委派：用 `delegate-work` 生成边界清楚的 handoff brief。
- 防止“未验证就完成”：用 `check-work` 做证据驱动的验收。
- 防止直接开工：修改、Bug、新需求和委派执行前，必须先给计划并等用户明确批准。

## 通用治理内核

这套技能把通用项目协作抽象成：

```text
事实源 / 证据
-> 状态机
-> Pipeline
-> 任务卡
-> 门禁
-> 验收与回写
```

- 状态机：让工作停在 intake、classified、planned、implementing、verifying、ready、done、blocked 等明确状态。
- Pipeline：按任务类型和执行模式选择最轻但足够安全的流程。
- 任务卡：把可保留工作写清目标、不做范围、允许范围、禁止范围、检查项和回写项。
- 门禁：遇到范围、架构、平台、预算、发布、不可逆操作或缺证据时，停下来等负责人决策。

## 计划批准门禁与 PM Control Mode

凡是用户要求修改、修 Bug、提出新需求或变更需求，技能都只能先读取必要上下文并形成计划。计划展示给用户并获得明确批准后，才能实施、改文件、启动 subagent 或做其他持久状态变更。

PM Control Mode 用在用户希望当前对话充当 PM、项目经理、PM-agent 或多 agent 总控时。当前对话只负责收集需求、维护源文档、写计划、控门禁、同步状态和汇总结果；实际执行交给经过批准的委派对话或 subagent。只有当范围互不冲突、只读，或被明确门禁串起来时，才允许多 subagent 并行。

## 安装

推荐直接安装全部技能：

```bash
git clone https://github.com/bigs-ad/ai-collab-skills.git
cd ai-collab-skills
./scripts/install.sh
```

默认会把 `skills/` 下的所有技能软链接到 `${CODEX_HOME:-$HOME/.codex}/skills`。

常用选项：

```bash
./scripts/install.sh --dry-run
./scripts/install.sh --copy
./scripts/install.sh --target /path/to/codex/skills
./scripts/install.sh --force
```

不要只安装 `ai-collab`。它是总路由技能，执行时会继续加载子技能；只安装路由会导致后续技能不可用。

## 最简单用法

安装后，优先这样对 Codex 说：

```text
请使用 ai-collab 处理这个任务，并告诉我下一步应该做什么。
```

如果已经知道任务类型，也可以直接调用子技能：

```text
请使用 plan-work 把这个需求拆成实施计划。
请使用 manage-project 同步当前项目进度和阻塞。
请使用 fix-bug 诊断并修复这个问题。
请使用 delegate-work 生成一个可以交给新对话的任务 brief。
```

## 技能列表

| 技能 | 适用场景 |
| --- | --- |
| `ai-collab` | 总入口。根据请求自动选择一个最合适的子技能。 |
| `start-project` | 从模糊想法启动项目，形成项目 brief、范围和第一批工作线。 |
| `plan-work` | 把已批准目标拆成执行计划、依赖、门禁和验证方式。 |
| `manage-project` | 同步进度、阻塞、优先级、工作线顺序和下一步动作。 |
| `run-task` | 处理边界不清的一般任务，并选择合适执行模式。 |
| `fix-bug` | 复现、诊断、修复并验证已有行为的问题。 |
| `add-feature` | 处理新需求，明确验收标准、影响范围和实施入口。 |
| `delegate-work` | 给新对话、协作者或 subagent 生成安全的任务交接 brief。 |
| `check-work` | 基于证据做审查、验收、阻塞或要求返工。 |

## 执行模式

| 模式 | 作用 | 典型场景 |
| --- | --- | --- |
| QuickProbe | 快速探查，不强制产出正式文档。 | 不确定可行性、先看代码、短时间定位问题。 |
| Candidate | 产出可审查候选结果。 | 草拟文档、提出方案、做第一版实现。 |
| Formalize | 把已确认方向沉淀为正式源文档或生产代码。 | 已批准功能、已确认规范、需要保留的修复。 |
| GateReview | 停下来等用户或负责人决策。 | 影响范围、架构、预算、发布、不可逆操作。 |

## 推荐项目流程

1. 项目还不清楚时，用 `start-project` 收敛项目 brief 和第一批工作线。
2. 范围或目标已批准后，用 `plan-work` 拆执行计划。
3. 多条线并行时，用 `manage-project` 做总控和进度同步。
4. 某条线可以交出去时，用 `delegate-work` 写 handoff brief。
5. 任务完成后，用 `check-work` 根据证据验收。
6. 遇到 Bug 用 `fix-bug`，遇到新需求用 `add-feature`，一般小任务用 `run-task`。

如果使用 PM Control Mode，主对话保持 PM 视角，不直接做实现；实现工作在用户批准计划后交给有边界的 delegate 或 subagent。

## 治理原则

- 源文档、临时笔记、实现代码、验证证据要分开。
- 状态不能靠猜：未知就是未知，缺证据就是缺证据。
- 长任务要时间盒：超过阈值要说明为什么慢、卡在哪里、下一步是什么。
- 并行任务必须有边界：共享文件、共享状态、未定接口不能盲目并行。
- 验收必须看证据：不能只因为 agent 声称完成就批准。

## 与其他技能的关系

AI Collab Skills 更像项目协作层。它负责判断当前阶段、选择流程、安排委派和控制验收。

Superpowers、Matt Pocock skills 或其他工程技能更像专项能力层，适合处理 TDD、系统调试、代码架构、issue 拆分等具体方法。

实际使用时可以组合：先用 `ai-collab` 判断任务和阶段，再让它调用更具体的技能。

## 当前状态

本仓库使用 MIT License，当前适合本地安装和迭代试用。

验证记录见：

- `docs/releases/v0.1.md`
- `tests/validation-results.md`
- `tests/forward-test-matrix.md`
- `tests/no-skill-baseline-protocol.md`
- `tests/real-repo-baseline-tasks.md`
- `tests/drift-guard-multiturn-baseline.md`

当前发布定位是 `v0.1 candidate`：可以本地安装、试用、评估，但不能宣称已经成熟、无懈可击、已证明能在生产环境减少 AI 跑偏，或已证明显著优于强通用 AI 助手。

当前证据只能支持这些保守结论：这套技能能提供结构化协作入口、显式证据门禁，并让假设、证据、阻塞、下一步更稳定地出现在输出中。更强结论需要真实仓库长上下文恢复、未知项目接手和重复无技能对照测试。
