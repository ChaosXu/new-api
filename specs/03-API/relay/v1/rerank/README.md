# 重排序端点

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1/rerank` | POST | TokenAuth + ModelRequestRateLimit + Distribute | 文档重排序（Cohere 风格） | [重排序.md](重排序.md) |

## 网关特殊行为
- **不走统一响应信封**：使用 Cohere 原生协议。
- **预扣计费**：按 query + documents 估算 token 预扣，失败退还，成功按实际 usage 结算。
- **多渠道重试**：可重试错误触发渠道切换。
- **非流式**：rerank 不支持流式。
