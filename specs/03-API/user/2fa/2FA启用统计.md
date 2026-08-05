# 2FA 启用统计

> `GET /api/user/2fa/stats`

- **鉴权**：`AdminAuth`（管理员）
- **用途**：返回全平台 2FA 启用情况统计。

## 请求

无参数。

## 响应

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | 空 |
| data.total_users | int | 总用户数 |
| data.enabled_users | int | 已启用 2FA 的用户数 |
| data.enabled_rate | string | 启用率（如 `"23.5%"`） |

```json
{
  "success": true,
  "message": "",
  "data": { "total_users": 1000, "enabled_users": 235, "enabled_rate": "23.5%" }
}
```

## 错误码

无业务错误码（数据库错误透传）。
