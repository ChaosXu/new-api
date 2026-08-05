# 刷新 Codex 凭证

> `POST /api/channel/:id/codex/refresh`

- **鉴权**：AdminAuth + RequirePermission(ChannelSensitiveWrite)
- **用途**：刷新 Codex 类型渠道的 OAuth 凭证（使用 refresh_token 换取新 token 并落库）。

## 请求

路径参数：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| id | int | 渠道 ID（需为 Codex 类型） |

## 响应

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| expires_at | string | 新 token 过期时间（RFC3339） |
| last_refresh | string | 本次刷新时间（RFC3339） |
| account_id | string | 账号 ID |
| email | string | 账号邮箱 |
| channel_id | int | 渠道 ID |
| channel_type | int | 渠道类型 |
| channel_name | string | 渠道名称 |

```json
{
  "success": true,
  "message": "refreshed",
  "data": {
    "expires_at": "2026-08-04T12:00:00Z",
    "last_refresh": "2026-08-04T11:00:00Z",
    "account_id": "acct_xxx",
    "email": "u@example.com",
    "channel_id": 10,
    "channel_type": 50,
    "channel_name": "Codex"
  }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 200(success=false) | 渠道 ID 无效、刷新凭证失败 |
