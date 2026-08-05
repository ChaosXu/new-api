# 完成 Passkey 验证

> `POST /api/user/passkey/verify/finish`

- **鉴权**：`UserAuth`，附加 `DisableCache`
- **用途**：用流程令牌与认证器断言完成 Passkey 二次验证，签发用于敏感操作的 `proof_token`。

## 请求

Body（JSON）：

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| flow_token | string | 是 | 发起验证返回的流程令牌 |
| credential | object/raw | 是 | WebAuthn 断言响应 |

```json
{
  "flow_token": "fl_passkey_stepup",
  "credential": { "id": "...", "rawId": "...", "response": { "authenticatorData": "...", "clientDataJSON": "...", "signature": "..." }, "type": "public-key" }
}
```

## 响应

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | `Passkey 验证成功` |
| data.proof_token | string | 安全验证凭证，放入后续敏感请求的 `X-Security-Proof` 头 |
| data.expires_at | int64 | proof_token 过期时间（Unix 秒） |
| data.method | string | 验证方式（`passkey`） |
| data.scope | string | 验证范围 |

```json
{
  "success": true,
  "message": "Passkey 验证成功",
  "data": {
    "proof_token": "proof_xxx",
    "expires_at": 1700000300,
    "method": "passkey",
    "scope": "channel.key.read"
  }
}
```

## 错误码

| 场景 | message |
|---|---|
| 管理员未启用 Passkey | `管理员未启用 Passkey 登录` |
| 流程参数不完整 | `Passkey 流程参数不完整` |
| 未登录 / 被禁用 | `未登录` / `该用户已被禁用` |
| 未绑定 Passkey | `该用户尚未绑定 Passkey` |
| 当前认证方式不支持安全验证 | 硬编码错误 |
