# 发起 Passkey 登录

> `POST /api/user/passkey/login/begin`

- **鉴权**：无（公开），经过 `CriticalRateLimit` + `DisableCache` + 请求体大小限制
- **用途**：发起可发现 Passkey 登录流程，返回 WebAuthn 断言选项与会话流程令牌。

## 请求

无 Body。

## 响应

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | 空 |
| data.options | object | WebAuthn `PublicKeyCredentialRequestOptions`（含 challenge 等） |
| data.flow_token | string | Passkey 登录流程令牌 |
| data.expires_at | int64 | 过期时间（Unix 秒） |

```json
{
  "success": true,
  "message": "",
  "data": {
    "options": { "publicKey": { "challenge": "...", "allowCredentials": [] } },
    "flow_token": "fl_passkey_login",
    "expires_at": 1700000000
  }
}
```

## 错误码

| 场景 | message |
|---|---|
| 管理员未启用 Passkey | `管理员未启用 Passkey 登录` |
| WebAuthn 构建失败 | 透传错误 |
