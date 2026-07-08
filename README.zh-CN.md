# AI Collab Skills 中文说明

[English README](README.md)

AI Collab Skills 是一组面向 Codex 的项目协作治理技能，用来处理项目启动、计划拆解、路由分流、委派执行、过程总控、Bug 修复、新需求和验收审查。

它不替代具体工程、设计或内容技能，而是放在这些专项能力之上，提供一套跨项目可复用的协作模型：什么时候该先计划，什么时候必须等批准，什么时候可以委派，什么时候要停下来补证据，什么时候才能说完成。

## 解决什么问题

- 降低入口复杂度：大多数时候只需要调用 `ai-collab`。
- 按状态、证据和风险路由任务，避免所有任务都套重流程。
- 区分源文档、临时笔记、实现产物和验证证据，减少上下文污染。
- 防止直接开工：修改、Bug、新需求、source-of-truth 更新、项目状态变更和委派执行前，必须先给计划并等用户明确批准。
- 支持 PM Control Mode：主对话做项目经理，负责需求、文档、计划、门禁、状态和汇总；执行交给批准后的 delegate/subagent。
- 规范并行委派：只允许边界清楚、互不冲突、只读或被门禁串起来的工作并行。
- 降低跑偏风险：把假设、证据、阻塞和下一步显式写出来，让偏移更早暴露。

## 通用治理内核

这套技能把通用项目协作抽象成：

```text
事实源 / 证据
-> 状态机
-> 计划批准
-> Pipeline / 任务卡
-> 受控执行或委派
-> 验收与回写
```

- 事实源 / 证据：不要把记忆、压力、口头说法或团队声称当成已验证状态。
- 状态机：让工作停在 intake、classified、planned、implementing、verifying、ready、done、blocked 等明确状态。
- 计划批准：凡是会产生持久变化或委派执行的工作，都要先展示计划并等用户明确批准。
- Pipeline / 任务卡：按任务类型选择最轻但足够安全的流程，并把可保留工作写清目标、不做范围、允许范围、禁止范围、检查项和回写项。
- 受控执行或委派：主对话拥有需求、范围、门禁、集成和最终状态；delegate 只在批准 brief 内执行。
- 验收与回写：记录证据、未跑检查、剩余风险，以及需要回写的源文档。

## 核心协作规则

可以先读取必要上下文来理解任务，但持久变化必须过门禁。

- 计划批准门禁：修改、Bug 修复、新需求或需求变更、source-of-truth 更新、项目状态变更和委派执行，都必须先展示计划，并在用户明确批准后才能继续。
- PM Control Mode：当前对话可以作为 PM，负责需求收集、源文档维护、计划、门禁、状态同步和结果汇总。
- 委派边界：delegate/subagent 可以修改批准 brief 内的执行产物，但不能擅自改变项目方向、批准范围、门禁或最终状态。
- 证据纪律：完成、ready、发布和验收判断必须基于检查或证据，不能只听 agent 或团队声称。

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
| `plan-work` | 把已批准目标拆成执行计划、依赖、门禁、委派候选和验证方式。 |
| `manage-project` | 同步进度、阻塞、优先级、源文档更新、工作线顺序和下一步动作。 |
| `run-task` | 处理边界不清的一般任务，选择执行模式，计划门禁工作，批准后执行并报告。 |
| `fix-bug` | 复现、诊断、修复并验证已有行为的问题。 |
| `add-feature` | 处理新需求，明确验收标准、影响范围和实施入口。 |
| `delegate-work` | 给新对话、协作者或 subagent 生成安全 brief，并协调批准后的委派执行。 |
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
4. 某条线已经批准且边界清楚时，用 `delegate-work` 写 handoff brief 并协调委派。
5. 任务完成、ready 或准备发布前，用 `check-work` 根据证据验收。
6. 遇到 Bug 用 `fix-bug`，遇到新需求用 `add-feature`，一般小任务用 `run-task`。

如果使用 PM Control Mode，主对话保持 `manage-project` / `plan-work` / `delegate-work` 的协调视角，不直接做实现；实现工作在用户批准计划后交给有边界的 delegate 或 subagent，再用 `check-work` 检查返回证据。

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
- `tests/pressure-scenarios.md`
- `tests/no-skill-baseline-protocol.md`
- `tests/real-repo-baseline-tasks.md`
- `tests/drift-guard-multiturn-baseline.md`

当前发布定位是 `v0.1 candidate`：可以本地安装、试用、评估，但不能宣称已经成熟、无懈可击、已证明能在生产环境减少 AI 跑偏，或已证明显著优于强通用 AI 助手。

当前证据只能支持这些保守结论：这套技能能提供结构化协作入口、显式批准与证据门禁、有边界的委派协作，并让假设、证据、阻塞、下一步更稳定地出现在输出中。更强结论需要真实仓库长上下文恢复、未知项目接手和重复无技能对照测试。
