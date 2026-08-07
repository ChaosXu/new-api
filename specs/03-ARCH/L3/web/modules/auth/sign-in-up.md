# 登录与注册

## 职责

统一处理用户身份认证入口：用户名密码登录/注册、双因子（2FA OTP）、密码找回与重置、邀请码存储、Turnstile 人机校验、登出与会话失效恢复。

## 契约（开放能力）

- **密码登录与注册能力**：用户名密码登录、注册（含邀请码 affiliate code 存储）
- **双因子认证登录能力**：登录成功后若 `require_2fa=true` 跳转 OTP 页，调用 `login2fa` 完成二次验证
- **密码找回能力**：通过邮件重置链接找回密码、重置密码确认
- **Turnstile 人机校验能力**：集成 Cloudflare Turnstile，按系统配置开关
- **登出与会话恢复能力**：登出清理、AUTH_SESSION_MISMATCH 409 会话失效恢复
- **登录后重定向能力**：按 `redirect` 参数在登录后跳回原页面

## 覆盖代码

`web/src/features/auth/sign-in/`、`web/src/features/auth/sign-up/`、`web/src/features/auth/forgot-password/`、`web/src/features/auth/otp/`、`web/src/features/auth/reset-password-confirm/`、`web/src/features/auth/hooks/`（use-turnstile、use-auth-redirect、use-email-verification）、`web/src/features/auth/lib/`（validation、auth-redirect、storage）

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [全局状态与系统配置缓存](infra/global-state.md)
- [OAuth 与 Passkey 免密登录](auth/oauth-passkey.md)
