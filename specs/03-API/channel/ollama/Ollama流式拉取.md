# Ollama 流式拉取

> `POST /api/channel/ollama/pull/stream`

- **鉴权**：AdminAuth + RequirePermission(ChannelSensitiveWrite)
- **用途**：以 SSE（Server-Sent Events）流式拉取 Ollama 模型，实时返回拉取进度。

## 请求

请求体 JSON：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| channel_id | int | 是 | Ollama 渠道 ID |
| model_name | string | 是 | 待拉取的模型名称 |

## 响应

SSE 流，响应头 `Content-Type: text/event-stream`。每条事件为 `data: <json>\n\n`：

- 进度事件：`data: {...OllamaPullResponse...}`
- 出错事件：`data: { "error": "..." }`
- 完成事件：`data: { "message": "Model xxx pulled successfully" }`
- 结束标志：`data: [DONE]`

## 错误码

| 状态 | 说明 |
| --- | --- |
| 400 | 参数缺失/无效、渠道非 Ollama 类型 |
| 404 | 渠道不存在 |
| SSE error 事件 | 拉取过程中的错误 |
