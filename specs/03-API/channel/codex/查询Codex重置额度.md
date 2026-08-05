# 查询 Codex 重置额度

> `GET /api/channel/:id/codex/usage/reset-credits`

- **鉴权**：AdminAuth + RequirePermission(ChannelRead)
- **用途**：查询 Codex 渠道可用的用量重置次数详情。

## 请求

路径参数：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| id | int | 渠道 ID（需为 Codex 类型，且非多密钥） |

## 响应

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| upstream_status | int | 上游 HTTP 状态码 |
| data | any | 上游返回的重置额度数据 |

```json
{
  "success": true,
  "message": "",
  "upstream_status": 200,
  "data": { "reset_credits": 2 }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 200(success=false) | 渠道不存在、非 Codex 类型、多密钥不支持、凭证缺失、获取重置额度失败 |
