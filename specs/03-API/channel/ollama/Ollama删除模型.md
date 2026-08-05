# Ollama 删除模型

> `DELETE /api/channel/ollama/delete`

- **鉴权**：AdminAuth + RequirePermission(ChannelSensitiveWrite)
- **用途**：从指定的 Ollama 渠道删除已拉取的模型。

## 请求

请求体 JSON（DELETE 携带 body）：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| channel_id | int | 是 | Ollama 渠道 ID |
| model_name | string | 是 | 待删除的模型名称 |

## 响应

```json
{
  "success": true,
  "message": "Model llama3 deleted successfully"
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 400 | 参数缺失/无效、渠道非 Ollama 类型 |
| 404 | 渠道不存在 |
| 500 | 删除失败 |
