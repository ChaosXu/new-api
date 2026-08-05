# Codex 网页搜索端点

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1/alpha/search` | POST | TokenAuth + ModelRequestRateLimit + Distribute | Codex 网页搜索（原始 body 透传） | [Codex网页搜索.md](Codex网页搜索.md) |

## 网关特殊行为
- **不走统一响应信封**：使用 Codex 网页搜索原生协议。
- **原始 body 透传**：保留请求体未知字段完整转发。
- **预扣计费**：按整段请求体估算 token 预扣，失败退还；成功按实际 usage 结算。
- **内置工具用量**：自动统计 `web_search_preview` 调用次数用于计费。
- **多渠道重试**：可重试错误触发渠道切换。
