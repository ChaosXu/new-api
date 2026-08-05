# 查询 2FA 状态

> `GET /api/user/2fa/status`

- **鉴权**：`UserAuth`
- **用途**：查询当前用户的 2FA 启用与锁定状态，及剩余备用码数量（启用时）。

## 请求

无参数。

## 响应

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | 空 |
| data.enabled | bool | 是否已启用 2FA |
| data.locked | bool | 是否被锁定（多次失败后） |
| data.backup_codes_remaining | int | 剩余未使用备用码数量（仅 `enabled=true` 时返回） |

```json
{
  "success": true,
  "message": "",
  "data": { "enabled": true, "locked": false, "backup_codes_remaining": 8 }
}
```

## 错误码

无业务错误码（数据库错误透传）。
