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

## Go 特定的归类模式

### 一个 interface + 多个实现 = 一个模块

实现同一 interface 的多个 package（如 39 个 `relay/channel/*` 都实现 `Adaptor`），**归为一个逻辑模块**（"渠道适配框架"），各实现作为该模块的覆盖代码列出。**不要**每个实现单列为模块。

### 跨 package 内聚 = 合并为一个模块

分散在多个 package 但共同实现一个能力的代码，合并。例：
- "鉴权" = `middleware/`（鉴权中间件部分）+ `oauth/` + `service/authz` + `service/passkey`
- "计费结算" = `service/`（计费函数）+ `relay/common`（`BillingSettler`）+ `pkg/billingexpr`

### 子 module（纯库）

有独立 `go.mod`、无运行入口、被宿主以 `require` + `replace` 引入的纯库（如 `relaykit`），视为一个独立的逻辑模块（或归入其支撑的功能域）。注意它**不是第三方依赖**。

## 覆盖代码的标注

每个逻辑模块的"覆盖代码"列用 package 路径标注（相对组件根），例：
- `relay/channel/`（框架 + 39 实现的单个 `relay/channel/*` 用通配 `relay/channel/*/`）
- `relaykit/`（整个子 module）
- `service/`、`relay/common/`（计费模块跨此二者）

## 排除项

不计入任何模块的代码：`vendor/`（第三方）、构建产物目录（`dist/`/`build/`/`out/`）、测试固件。
