# Playground 在线对话端点

面向登录用户的在线 Playground 对话，内部复用 relay 对话流程。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/pg/chat/completions` | POST | UserAuth + Distribute | Playground 对话（可带 group 切分组） | [Playground对话.md](Playground对话.md) |

## 网关特殊行为
- **不走统一响应信封**：使用 OpenAI 原生协议。
- **用户鉴权**：使用 `UserAuth`（用户登录态），**非 TokenAuth**；不支持 access token。
- **分组切换**：请求体 `group` 可指定计费分组；网关以该分组构造临时令牌上下文。
- **仍计费**：与正式对话一致走预扣计费、按实际 usage 结算。
- **多渠道重试 + 流式 SSE**：同 `/v1/chat/completions`。
