# 对话端点

OpenAI 兼容的对话/文本/审核接口，RelayFormat=OpenAI。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1/chat/completions` | POST | TokenAuth + ModelRequestRateLimit + Distribute | 对话补全 | [对话补全.md](对话补全.md) |
| `/v1/completions` | POST | TokenAuth + ModelRequestRateLimit + Distribute | 文本补全 | [文本补全.md](文本补全.md) |
| `/v1/moderations` | POST | TokenAuth + ModelRequestRateLimit + Distribute | 内容审核 | [内容审核.md](内容审核.md) |

## 网关特殊行为
- **不走统一响应信封**：使用 OpenAI 原生协议。
- **预扣计费**：请求前按估算 token 与模型倍率预扣额度；失败时退还，成功后按实际 usage 结算。
- **多渠道重试**：下游失败（且错误可重试）时按重试策略切换渠道，日志记录 `重试：a->b`。
- **流式 SSE**：`stream=true` 时以 `text/event-stream` 逐块返回。
- **敏感词检查**：启用时对 prompt 文本做敏感词拦截。
- **令牌/请求体大小限制**：超大请求体返回 413。
