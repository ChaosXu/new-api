# 计费表达式引擎

- **职责**：基于 expr-lang 的分层/动态计费表达式引擎，编译并执行表达式形式的定价规则，支持表达式版本化。供计费结算链路做按表达式定价。
- **覆盖代码**：`pkg/billingexpr/`（compile.go/round.go 等）、设计文档 `pkg/billingexpr/expr.md`
- **关键契约**：表达式编译/执行 API、`billingexpr.QuotaRound`（委托 common.QuotaRound）、表达式版本机制

## 项目约束

- 改动前**必须先读 `pkg/billingexpr/expr.md`**（设计哲学、表达式语言、架构、token 归一化、配额换算、版本化）。

## 依赖（内部逻辑模块）

- 通用工具（配额换算、JSON）
