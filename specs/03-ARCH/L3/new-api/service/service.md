# service

- **路径**：`./service`
- **职责**：业务服务层，承载计费结算、渠道选择、令牌计数、任务轮询、敏感词、订阅重置、HTTP 客户端、Codex 凭证等核心业务逻辑

## 直接依赖（内部）

- common
- constant
- dto
- logger
- model
- pkg/billingexpr
- pkg/cachex
- pkg/perf_metrics
- relay/channel/task/taskcommon
- relay/common
- relay/constant
- relaykit/dto
- relaykit/relayconvert
- relaykit/types
- setting
- setting/model_setting
- setting/operation_setting
- setting/ratio_setting
- setting/system_setting
- types
