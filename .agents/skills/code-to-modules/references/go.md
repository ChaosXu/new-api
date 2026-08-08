# Go 技术栈规则

适用范围：组件根目录下存在 `go.mod`。本文件被 SKILL.md 在识别到 Go 技术栈时按需读取，提供 Go 专属的**代码理解切入点**（看什么标志判断职责/契约/内聚）。通用概念（逻辑模块定义、判定信号、粒度）见 SKILL.md。

## 核心原则

**Go package 是覆盖代码的粒度，不是模块粒度。** 一个逻辑模块可覆盖多个 package；多个内聚的 package 也可归为一个逻辑模块。不要"每 package = 一模块"。

## 代码理解切入点

提炼逻辑模块时，按这些标志判断职责与边界：

| 标志 | 说明 | 用法 |
| --- | --- | --- |
| `package` 声明 + 包注释/doc.go | 包的职责自述 | 理解每个 package 做什么，作为归类的输入 |
| `type X interface` | 对外契约 | 一个 interface 常定义一个逻辑模块的边界（如 `Adaptor` 定义"渠道适配框架"模块） |
| `type X struct`（导出） | 核心数据载体 | 跨多个 package 共用的核心 struct 常标志一个模块（如 `RelayInfo` 标志"中继上下文"） |
| 调用链（谁调用谁） | 内聚性证据 | 一组互相调用、共同实现某能力的 package 归为一个模块 |
| `func main` / 路由注册 | 入口与编排 | 编排层（如 `relay/` 根包的 `GetAdaptor`）是独立模块 |

## 完整性程序（强制，配合 SKILL.md 第 3/12 步）

"通读理解"不能替代枚举。按以下程序确保每个 package / 子 module 都被考虑：

1. **枚举所有 package**：`go list ./...`（在组件根执行），列出全部 import path。
2. **枚举所有子 module**：`find . -name go.mod`（含 `replace` 指向的本地路径，如 `relaykit`）。
3. **每个结果必须在「源码覆盖矩阵」占一行**（covered / new-module / dont-list），不得遗漏。`dont-list` 须填一句理由（如"仅类型定义""构建产物"）。

## Go 特定的归类模式

### 一个 interface + 多个实现 = 一个模块（有条件合并）

实现同一 interface 的多个 package（如 39 个 `relay/channel/*` 都实现 `Adaptor`），归为一个逻辑模块（"渠道适配框架"）的**条件**：实现间共享相同的开放能力集合与相同的依赖图。**若某实现暴露独有能力（流式、异步、退款）或依赖显著不同的外部系统，必须拆为独立模块或显式子能力**。各实现作为该模块的覆盖代码列出，不要每个实现单列。

### 跨 package 内聚 = 合并为一个模块

分散在多个 package 但共同实现一个能力的代码，合并。例：
- "鉴权" = `middleware/`（鉴权中间件部分）+ `oauth/` + `service/authz` + `service/passkey`
- "计费结算" = `service/`（计费函数）+ `relay/common`（`BillingSettler`）+ `pkg/billingexpr`

### 子 module（纯库）

有独立 `go.mod`、无运行入口、被宿主以 `require` + `replace` 引入的纯库（如 `relaykit`），视为一个独立的逻辑模块（或归入其支撑的功能域）。注意它**不是第三方依赖**。

### 运维入口（单文件也列出）

`cmd/`、`scripts/` 下的运维类入口（migrator/seeder/backfill）即使单文件也归入「运维入口」域列出——它们是 runbook 单元，**不适用"单工具目录不单列"**（该绝对规则已删除）。

## 流程入口扫描命令（配合 SKILL.md 第 8 步 7 类入口族）

| 入口族 | Go 扫描命令/标志 |
| --- | --- |
| HTTP handler | `grep -rn "router\.\(GET\|POST\|Any\|Group\)" router/` |
| gRPC/WebSocket/SSE | `grep -rn "RegisterServer\|Upgrade\|text/event-stream"` |
| 启动入口/CLI 子命令 | `find . -name main.go`（多个 cmd/ 都要扫）；`grep -rn "func main"` |
| 后台 goroutine/worker | `grep -rn "go .*(" main.go service/`；`grep -rn "Start.*\(\)"` |
| 定时任务 | `grep -rn "cron\|time.Ticker\|time.After"` |
| Webhook/回调 | `grep -rn "webhook\|callback\|notify"` router/ controller/ |
| 信号/文件监听 | `grep -rn "signal.Notify\|fsnotify"` |

## 覆盖代码的标注

每个逻辑模块的"覆盖代码"列用 package 路径标注（相对组件根），例：
- `relay/channel/`（框架 + 39 实现的单个 `relay/channel/*` 用通配 `relay/channel/*/`）
- `relaykit/`（整个子 module）
- `service/`、`relay/common/`（计费模块跨此二者）

## 排除项

不计入任何模块的代码：`vendor/`（第三方）、构建产物目录（`dist/`/`build/`/`out/`）、测试固件。
