# Passkey 与无密码认证

## 职责

基于 WebAuthn 的 Passkey 无密码认证，处理注册/登录会话与凭据管理；含 TOTP 两步验证。

## 契约（开放能力）

- **Passkey 注册与登录会话能力**：发起并完成 WebAuthn 注册/登录的两阶段会话。
- **凭据管理能力**：增删查用户 Passkey 凭据。
- **TOTP 两步验证能力**：基于 TOTP 的二次验证与备份码。

## 覆盖代码

`server/internal/service/passkey/`（WebAuthn 实例构建、注册/登录会话）

## 依赖（内部逻辑模块）

- 数据访问（用户凭据）
- 配置（系统设置中的 Passkey 配置）
- 通用工具（加密）
