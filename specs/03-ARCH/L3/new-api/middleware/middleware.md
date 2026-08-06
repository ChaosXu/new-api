# middleware

- **路径**：`./middleware`
- **职责**：Gin 中间件层，提供鉴权、CORS、限流、缓存、审计、请求体限制、gzip、recover、turnstile 校验、i18n 等请求处理链

## 直接依赖（内部）

- common
- common/limiter
- constant
- dto
- i18n
- logger
- model
- relay/constant
- relaykit/dto
- relaykit/types
- service
- service/authz
- setting
- setting/ratio_setting
