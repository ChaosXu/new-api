# Ollama 拉取模型

> `POST /api/channel/ollama/pull`

- **鉴权**：AdminAuth + RequirePermission(ChannelSensitiveWrite)
- **用途**：向指定的 Ollama 渠道发起模型拉取（阻塞直到完成）。

## 请求

请求体 JSON：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| channel_id | int | 是 | Ollama 渠道 ID |
| model_name | string | 是 | 待拉取的模型名称 |

## 响应

```json
{
  "success": true,
  "message": "Model llama3 pulled successfully"
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 400 | 参数缺失/无效、渠道非 Ollama 类型 |
| 404 | 渠道不存在 |
| 500 | 拉取失败 |
