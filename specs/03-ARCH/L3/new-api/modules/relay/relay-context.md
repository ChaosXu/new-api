# 中继上下文

- **职责**：承载一次中继请求贯穿全链路的状态容器与计费会话抽象。把请求的元信息、计费状态、流式状态、请求转换上下文聚合在一个结构里，在编排/适配/计费间传递。
- **覆盖代码**：`relay/common/`（RelayInfo、BillingSettler、relay_info.go、billing.go 等）
- **关键契约**：`RelayInfo` struct（一次中继的全链路状态：渠道类型/模型/密钥/流式/计费等）、`BillingSettler` interface（计费会话：预扣费/结算/退款）、`TaskRelayInfo` struct（异步任务中继状态）

## 依赖（内部逻辑模块）

- 通用工具（Redis/加密/配额计算等基础设施）
- 常量定义（渠道类型、API 类型）
- 配置（模型设置、运营设置）
- 计费表达式引擎（分层计费）
- 协议转换（用 convmeta 的 Meta 接口）
