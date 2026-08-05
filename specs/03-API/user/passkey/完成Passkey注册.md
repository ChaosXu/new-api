# 完成 Passkey 注册

> `POST /api/user/passkey/register/finish`

- **鉴权**：`UserAuth`，附加 `DisableCache`
- **用途**：用注册流程令牌与认证器创建响应完成 Passkey 绑定，推进会话鉴权版本并返回新令牌。

## 请求

Body（JSON）：

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| flow_token | string | 是 | 发起注册返回的流程令牌 |
| credential | object/raw | 是 | WebAuthn 创建响应（`navigator.credentials.create` 原样 JSON） |

```json
{
  "flow_token": "fl_passkey_register",
  "credential": { "id": "...", "rawId": "...", "response": { "attestationObject": "...", "clientDataJSON": "..." }, "type": "public-key" }
}
```

## 响应

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | `Passkey 注册成功` |
| data.access_token | string | 新访问令牌（鉴权版本推进） |
| data.token_type | string | `Bearer` |
| data.access_expires_at | int64 | 过期时间（Unix 秒） |
| data.session | object | 当前会话视图 |

```json
{
  "success": true,
  "message": "Passkey 注册成功",
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
| 管理员未启用 Passkey | `管理员未启用 Passkey 登录` |
| 流程参数不完整 | `Passkey 流程参数不完整` |
| 未登录 / 被禁用 | `未登录` / `该用户已被禁用` |
| 当前认证方式不支持安全验证 | 硬编码错误 |
| 无法创建凭证 | `无法创建 Passkey 凭证` |
