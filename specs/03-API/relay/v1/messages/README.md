# Claude 对话端点

Anthropic Messages API，RelayFormat=Claude。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1/messages` | POST | TokenAuth + ModelRequestRateLimit + Distribute | Claude 对话 | [Claude对话.md](Claude对话.md) |

## 网关特殊行为
- **不走统一响应信封**：使用 Anthropic 原生协议。
- **错误格式**：下游错误统一归一化为 Claude 错误结构 `{type:"error",error:{...}}`。
- **预扣计费**：按估算 token（含 system/messages/tools）预扣，失败退还，成功按实际 usage 结算；支持 prompt 缓存计费字段。
- **多渠道重试**：可重试错误触发渠道切换。
- **流式 SSE**：`stream=true` 时返回 Anthropic 事件流。
- **敏感词检查**：启用时对 prompt 文本拦截。
- **字段过滤**：`service_tier`/`inference_geo`/`speed` 等默认过滤，需渠道设置开启。
