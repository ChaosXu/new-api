# 计费结算

## 职责

用户请求的配额预扣费、实际用量结算、差额退还、违规扣费等完整计费链路。支持按比例计费与分层表达式计费两种模式，贯穿中继与异步任务两类请求。

## 契约（开放能力）

- **配额预扣与结算退还能力**：提供请求前预扣、请求后按实际用量结算差额、退还/补扣、违规扣费的完整计费会话操作。
- **防溢出配额换算能力**：以饱和取整（int32 上限、防负扣费）方式在浮点/十进制配额与整数列间换算。
- **分层表达式计费能力**：配合计费表达式引擎执行按表达式定价的结算。
- **计费饱和审计能力**：捕获饱和事件并审计到日志的 admin_info.quota_saturation。

## 覆盖代码

`server/internal/service/billing.go`、`server/internal/service/billing_session.go`、`server/internal/service/billing_usage.go`、`server/internal/service/quota.go`、`server/internal/service/text_quota.go`、`server/internal/service/tiered_settle.go`、`server/internal/service/violation_fee.go`、`server/internal/service/task_billing.go`、`server/internal/common/quota.go`、`server/internal/common/quota_math.go`、`server/internal/service/log_info_generate.go`（含配额饱和审计）

## 内部子能力

- 配额计算与换算：`server/internal/common/quota_math.go`（饱和取整，int32 上限，防负扣费）
- 预扣费与结算差额：billing_session/billing_usage
- 分层表达式结算：tiered_settle（配合计费表达式引擎）
- 任务计费：task_billing（异步任务的预扣/结算）

## 依赖（内部逻辑模块）

- 计费表达式引擎（server/pkg/billingexpr，分层计费）
- 数据访问（用户/令牌/日志的配额读写）
- 中继上下文（操作 BillingSettler）
- 配置（计费倍率、计费模式）

## 项目约束

- **计费安全铁律**：配额计算永不产生负扣费；所有用户可控乘数（image n、video seconds 等）必须有界校验；配额换算必须用 `server/internal/common/quota_math.go` 的饱和函数，禁止裸 `int()` 转换；饱和事件须经 `*Checked` 变体捕获并审计到日志的 `admin_info.quota_saturation`。
