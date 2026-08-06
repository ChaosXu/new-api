# controller

- **路径**：`./controller`
- **职责**：HTTP API 控制器层，处理用户、渠道、令牌、日志、计费、充值、订阅、支付、任务、Passkey 等各业务接口的请求逻辑；含审计 action 模板渲染

## 直接依赖（内部）

- common
- constant
- dto
- i18n
- logger
- middleware
- model
- oauth
- pkg/billingexpr
- pkg/ionet
- pkg/perf_metrics
- relay
- relay/channel
- relay/channel/advancedcustom
- relay/channel/ai360
- relay/channel/codex
- relay/channel/gemini
- relay/channel/lingyiwanwu
- relay/channel/minimax
- relay/channel/moonshot
- relay/channel/ollama
- relay/common
- relay/constant
- relay/helper
- relaykit/dto
- relaykit/types
- service
- service/authz
- service/passkey
- setting
- setting/billing_setting
- setting/console_setting
- setting/model_setting
- setting/operation_setting
- setting/ratio_setting
- setting/system_setting
- types
