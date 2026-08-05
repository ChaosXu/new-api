# 实时对话端点

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1/realtime` | GET（WebSocket） | TokenAuth + ModelRequestRateLimit + Distribute | OpenAI Realtime 实时对话 | [实时对话.md](实时对话.md) |

## 网关特殊行为
- **不走统一响应信封**：使用 OpenAI Realtime 原生事件协议。
- **WebSocket 子协议**：握手必须声明 `Sec-WebSocket-Protocol: realtime`，网关 `CheckOrigin` 允许跨域。
- **计费**：基于 Realtime usage（音频/输入/输出 token）结算。
- **多渠道重试**：握手/连接失败时按策略切换渠道（仅握手阶段）。
- **透传**：连接建立后网关双向透传音频/事件帧。
