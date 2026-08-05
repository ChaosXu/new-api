# Gemini 端点

Gemini 原生/兼容路径透传接口。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1beta/models/*path` | POST | TokenAuth + ModelRequestRateLimit + Distribute | Gemini 原生接口（`{model}:{action}`） | [Gemini原生接口.md](Gemini原生接口.md) |
| `/v1/engines/:model/embeddings` | POST | TokenAuth + ModelRequestRateLimit + Distribute | Gemini 引擎嵌入 | [Gemini引擎嵌入.md](Gemini引擎嵌入.md) |
| `/v1/models/*path` | POST | TokenAuth + ModelRequestRateLimit + Distribute | Gemini 兼容路径 | [Gemini兼容路径.md](Gemini兼容路径.md) |

## 网关特殊行为
- **不走统一响应信封**：使用 Gemini 原生协议。
- **路径动作分流**：路径含 `embed` 走嵌入处理器，否则走内容生成处理器。
- **预扣计费**：按 contents/generationConfig 估算 token 预扣，失败退还，成功按 `usageMetadata` 结算。
- **多渠道重试**：可重试错误触发渠道切换。
- **流式**：`streamGenerateContent` 分块返回。
