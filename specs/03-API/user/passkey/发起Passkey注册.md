# 发起 Passkey 注册

> `POST /api/user/passkey/register/begin`

- **鉴权**：`UserAuth`，附加 `DisableCache`
- **用途**：为已登录用户发起 Passkey 注册流程，返回 WebAuthn 创建选项与流程令牌。若用户已启用 2FA，需先完成安全验证（`scope=passkey.register`）。

## 请求

无 Body。

> 若用户启用了 2FA，路由层 `RequireSecurityProof` 会要求请求带 `X-Security-Proof` 头（2FA 方式）。

## 响应

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | 空 |
| data.options | object | WebAuthn `PublicKeyCredentialCreationOptions` |
| data.flow_token | string | 注册流程令牌 |
| data.expires_at | int64 | 过期时间（Unix 秒） |

```json
{
  "success": true,
  "message": "",
  "data": {
    "options": { "publicKey": { "challenge": "...", "rp": { ... }, "user": { ... }, "pubKeyCredParams": [...] } },
    "flow_token": "fl_passkey_register",
    "expires_at": 1700000000
  }
}
```

## 错误码

| 场景 | message |
|---|---|
| 管理员未启用 Passkey | `管理员未启用 Passkey 登录` |
| 未登录 / 被禁用 | `未登录` / `该用户已被禁用` |
| 需 2FA 安全验证（缺 `X-Security-Proof`） | 由 `RequireSecurityProof` 返回 |
