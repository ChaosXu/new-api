# 敏感操作二次验证

## 职责

对敏感操作执行二次安全验证（Secure Verification）：以 2FA 或 Passkey 作为 Security Proof，覆盖 `passkey.register`、`passkey.delete`、`channel.key.read` 等作用域，提供统一的验证对话框组件。

## 契约（开放能力）

- **作用域驱动的安全验证能力**：按作用域（passkey.register/delete、channel.key.read 等）要求用户提供 2FA OTP 或 Passkey 断言作为 Security Proof
- **统一验证对话框能力**：提供 `secure-verification-dialog` 组件，由各业务模块按需触发
- **安全验证 token 获取与传递能力**：完成验证后获取 verification token 并传递给后续敏感操作请求

## 覆盖代码

`web/src/features/auth/secure-verification/`（index、types、api、components/secure-verification-dialog）、`web/src/lib/secure-verification.ts`

## 依赖（内部逻辑模块）

- [OAuth 与 Passkey 免密登录](auth/oauth-passkey.md)
- [HTTP 与认证会话底座](infra/http-auth-base.md)

## 备注

本模块是"安全验证能力"的统一提供者，被渠道密钥查看、API Key 明文查看、Passkey 注册/删除等敏感操作消费。
