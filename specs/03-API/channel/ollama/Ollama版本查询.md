# Ollama 版本查询

> `GET /api/channel/ollama/version/:id`

- **鉴权**：AdminAuth + RequirePermission(ChannelSensitiveWrite)
- **用途**：查询指定 Ollama 渠道服务的版本信息。

## 请求

路径参数：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| id | int | Ollama 渠道 ID |

## 响应

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| version | string | Ollama 服务版本 |

```json
{
  "success": true,
  "data": {
    "version": "0.1.32"
  }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 400 | 渠道 ID 无效、渠道非 Ollama 类型 |
| 404 | 渠道不存在 |
| 200(success=false) | 获取版本失败 |
