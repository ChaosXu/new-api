# 发起 Passkey 验证

> `POST /api/user/passkey/verify/begin`

- **鉴权**：`UserAuth`，附加 `DisableCache`
- **用途**：已登录用户发起 Passkey 二次验证（step-up），用于敏感操作授权。返回断言选项与流程令牌。

## 请求

Body（JSON）：

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| scope | string | 是 | 安全验证范围，须为白名单值（如 `channel.key.read`、`passkey.register`、`passkey.delete`） |

```json
{ "scope": "channel.key.read" }
```

## 响应

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | 空 |
| data.options | object | WebAuthn 断言选项 |
| data.flow_token | string | 验证流程令牌 |
| data.expires_at | int64 | 过期时间（Unix 秒） |

```json
{
  "success": true,
  "message": "",
  "data": {
    "options": { "publicKey": { "challenge": "...", "allowCredentials": [...] } },
    "flow_token": "fl_passkey_stepup",
    "expires_at": 1700000000
  }
}
```

## 错误码

| 场景 | message |
|---|---|
| 管理员未启用 Passkey | `管理员未启用 Passkey 登录` |
| 未登录 / 被禁用 | `未登录` / `该用户已被禁用` |
| 请求非法 | `无效的 Passkey 验证请求` |
| scope 不在白名单 | `不支持的安全验证范围` |
| 用户未绑定 Passkey | `该用户尚未绑定 Passkey` |
