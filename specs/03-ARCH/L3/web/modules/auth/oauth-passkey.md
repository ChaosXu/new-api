# OAuth 与 Passkey 免密登录

## 职责

第三方 OAuth 登录（GitHub、Discord、OIDC、LinuxDO、Telegram、WeChat、自定义 OAuth）与 Passkey（WebAuthn）免密登录/注册/管理；以及账号绑定（邮箱验证码、WeChat、Telegram bind）。

## 契约（开放能力）

- **OAuth 第三方登录能力**：构造各 OAuth 提供商的授权 URL、处理 OAuth 回调（`/oauth/$provider`）、完成登录或绑定流程
- **自定义 OAuth 提供商能力**：支持管理员配置的自定义 OAuth 提供商登录
- **Passkey 免密登录能力**：beginPasskeyLogin/finishPasskeyLogin 完成 WebAuthn 断言验证登录
- **Passkey 管理能力**：注册/删除/验证 Passkey 凭据（base64url↔ArrayBuffer 编解码）
- **账号绑定能力**：邮箱验证码绑定、WeChat 绑定、Telegram bind 流程
- **Telegram 登录能力**：Telegram Login Widget 集成与回调

## 覆盖代码

`web/src/features/auth/components/`（oauth-providers、telegram-login-dialog、oauth-callback-screen）、`web/src/features/auth/passkey/`（api、types、hooks/use-passkey-management）、`web/src/features/auth/lib/`（oauth、telegram-login、oauth-bind-window）、`web/src/lib/oauth.ts`、`web/src/lib/passkey.ts`

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [全局状态与系统配置缓存](infra/global-state.md)
- [通用工具库](infra/utils.md)
