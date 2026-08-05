# 完成 Passkey 登录

> `POST /api/user/passkey/login/finish`

- **鉴权**：无（公开），经过 `CriticalRateLimit` + `DisableCache` + 请求体大小限制
- **用途**：用「发起 Passkey 登录」返回的 `flow_token` 与认证器签发的断言完成可发现凭据登录，成功后等同普通登录。

## 请求

Body（JSON）：

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| flow_token | string | 是 | 发起登录返回的流程令牌 |
| credential | object/raw | 是 | WebAuthn 断言响应（`navigator.credentials.get` 的原样 JSON） |

```json
{
  "flow_token": "fl_passkey_login",
  "credential": { "id": "...", "rawId": "...", "response": { "authenticatorData": "...", "clientDataJSON": "...", "signature": "...", "userHandle": "..." }, "type": "public-key" }
}
```

## 响应

校验通过后等同普通登录成功响应：

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | 空 |
| data.access_token | string | 访问令牌 |
| data.token_type | string | `Bearer` |
| data.access_expires_at | int64 | 过期时间（Unix 秒） |
| data.session | object | 当前会话视图（`login_method=passkey`） |
| data.user | object | 用户信息 DTO |

```json
{
  "success": true,
  "message": "",
  "data": {
    "access_token": "eyJ...",
    "token_type": "Bearer",
    "access_expires_at": 1700000000,
    "session": { "sid": "sess_abc", "current": true, "login_method": "passkey" },
    "user": { "id": 1, "username": "alice", "role": 1 }
  }
}
```

## 错误码

| 场景 | message |
|---|---|
| 管理员未启用 Passkey | `管理员未启用 Passkey 登录` |
| 流程参数不完整 | `Passkey 流程参数不完整` |
| 凭证未找到 / 用户被禁用 / 句柄不匹配 | 透传错误（`未找到 Passkey 凭证` / `该用户已被禁用` / `用户句柄与凭证不匹配`） |
| 登录状态异常 | `Passkey 登录状态异常` |
