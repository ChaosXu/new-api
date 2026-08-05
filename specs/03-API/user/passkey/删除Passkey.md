# 删除 Passkey

> `DELETE /api/user/passkey`

- **鉴权**：`UserAuth`，附加 `DisableCache`
- **用途**：解绑当前用户的 Passkey。若已启用 2FA 需先 2FA 安全验证；否则需 Passkey 安全验证（`scope=passkey.delete`）。

## 请求

无 Body。

> 路由层会要求 `X-Security-Proof` 头：2FA 启用时用 2FA 验证，未启用 2FA 时用 Passkey 验证。

## 响应

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | `Passkey 已解绑` |
| data.access_token | string | 新访问令牌（鉴权版本推进） |
| data.token_type | string | `Bearer` |
| data.access_expires_at | int64 | 过期时间（Unix 秒） |
| data.session | object | 当前会话视图 |

```json
{
  "success": true,
  "message": "Passkey 已解绑",
  "data": {
    "access_token": "eyJ...",
    "token_type": "Bearer",
    "access_expires_at": 1700000000,
    "session": { "sid": "sess_abc", "current": true }
  }
}
```

## 错误码

| 场景 | message |
|---|---|
| 未登录 / 被禁用 | `未登录` / `该用户已被禁用` |
| 未绑定 Passkey | `该用户尚未绑定 Passkey` |
| 当前认证方式不支持安全验证 | 硬编码错误 |
