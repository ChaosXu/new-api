# 计费结算

- **职责**：用户请求的配额预扣费、实际用量结算、差额退还、违规扣费等完整计费链路。支持按比例计费与分层表达式计费两种模式，贯穿中继与异步任务两类请求。
- **覆盖代码**：`service/billing.go`、`service/billing_session.go`、`service/billing_usage.go`、`service/quota.go`、`service/text_quota.go`、`service/tiered_settle.go`、`service/violation_fee.go`、`service/task_billing.go`、`common/quota.go`、`common/quota_math.go`、`service/log_info_generate.go`（含配额饱和审计）
- **关键契约**：`BillingSettler`（relay/common，计费会话）、`common.QuotaFromFloat`/`QuotaRound`/`QuotaFromDecimal`（配额换算，防溢出）

## 内部子能力

- 配额计算与换算：`common/quota_math.go`（饱和取整，int32 上限，防负扣费）
- 预扣费与结算差额：billing_session/billing_usage
- 分层表达式结算：tiered_settle（配合计费表达式引擎）
- 任务计费：task_billing（异步任务的预扣/结算）

## 依赖（内部逻辑模块）

- 计费表达式引擎（pkg/billingexpr，分层计费）
- 数据访问（用户/令牌/日志的配额读写）
- 中继上下文（操作 BillingSettler）
- 配置（计费倍率、计费模式）

## 项目约束

- **计费安全铁律**：配额计算永不产生负扣费；所有用户可控乘数（image n、video seconds 等）必须有界校验；配额换算必须用 `common/quota_math.go` 的饱和函数，禁止裸 `int()` 转换；饱和事件须经 `*Checked` 变体捕获并审计到日志的 `admin_info.quota_saturation`。
