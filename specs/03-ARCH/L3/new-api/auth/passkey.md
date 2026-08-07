# Passkey 与无密码认证

- **职责**：基于 WebAuthn 的 Passkey 无密码认证，处理注册/登录会话与凭据管理；含 TOTP 两步验证。
- **覆盖代码**：`service/passkey/`（WebAuthn 实例构建、注册/登录会话）
- **关键契约**：WebAuthn 实例工厂、Passkey 注册/登录会话、凭据存储

## 依赖（内部逻辑模块）

- 数据访问（用户凭据）
- 配置（系统设置中的 Passkey 配置）
- 通用工具（加密）
