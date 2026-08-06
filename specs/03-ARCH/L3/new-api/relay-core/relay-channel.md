# relay/channel

- **路径**：`./relay/channel`
- **职责**：渠道适配器框架，定义统一的 Adaptor 接口（Init/GetRequestURL/ConvertOpenAIRequest/ConvertImage 等）及 API 请求执行与注册逻辑

## 直接依赖（内部）

- common
- dto
- logger
- model
- relay/common
- relay/constant
- relay/helper
- relaykit/dto
- relaykit/types
- service
- setting/operation_setting
