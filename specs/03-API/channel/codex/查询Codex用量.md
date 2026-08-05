# 查询 Codex 用量

> `GET /api/channel/:id/codex/usage`

- **鉴权**：AdminAuth + RequirePermission(ChannelRead)
- **用途**：查询 Codex 渠道的上游用量信息（经 wham 接口，token 失效时自动刷新重试）。

## 请求

路径参数：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| id | int | 渠道 ID（需为 Codex 类型，且非多密钥） |

## 响应

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| upstream_status | int | 上游 HTTP 状态码 |
| data | any | 上游返回的用量数据（解析失败时为原始字符串） |

```json
{
  "success": true,
  "message": "",
  "upstream_status": 200,
  "data": { "usage": { "tokens": 12345 } }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 200(success=false) | 渠道不存在、非 Codex 类型、多密钥不支持、凭证缺失、获取用量失败 |
