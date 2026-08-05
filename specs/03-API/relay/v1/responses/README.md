# Responses API 端点

OpenAI Responses API 及 Codex 压缩变体。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1/responses` | POST | TokenAuth + ModelRequestRateLimit + Distribute | Responses API | [Responses API.md](Responses%20API.md) |
| `/v1/responses/compact` | POST | TokenAuth + ModelRequestRateLimit + Distribute | Responses 压缩（模型追加 `-openai-compact`） | [Responses压缩.md](Responses压缩.md) |

## 网关特殊行为
- **不走统一响应信封**：使用 OpenAI Responses 原生协议。
- **模型后缀路由**：compact 接口自动给模型名追加 `-openai-compact` 后缀，命中独立的压缩计费倍率配置。
- **预扣计费**：按估算 token 预扣，失败退还；成功按实际 usage（含缓存命中）结算。
- **多渠道重试**：可重试错误触发渠道切换。
- **流式 SSE**：`stream=true` 时返回 Responses 事件流。
- **字段过滤**：`service_tier`/`safety_identifier` 等默认过滤，需渠道设置开启。
