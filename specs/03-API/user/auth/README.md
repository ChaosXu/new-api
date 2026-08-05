# 用户认证 API

> 路由前缀：`/api/user/*`（登录、注册、重置密码为公开；其余在 `selfRoute(UserAuth)` 下）。`CriticalRateLimit` 与 `TurnstileCheck` 在路由层附加。登出与刷新在 `SessionCookieOriginGuard` + `CriticalRateLimit` + `DisableCache` 下。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [用户名密码登录.md](./用户名密码登录.md) | POST | `/api/user/login` | 用户名密码登录，启用 2FA 时返回 require_2fa 流程 |
| [完成双因素登录.md](./完成双因素登录.md) | POST | `/api/user/login/2fa` | 用验证码 + flow_token 完成 2FA 登录 |
| [用户名密码注册.md](./用户名密码注册.md) | POST | `/api/user/register` | 用户名 + 密码注册新账户 |
| [重置密码.md](./重置密码.md) | POST | `/api/user/reset` | 凭邮件重置令牌重置密码并返回新密码 |
| [退出登录.md](./退出登录.md) | POST | `/api/user/auth/logout` | 吊销当前会话并清除刷新令牌 Cookie |
| [刷新登录态.md](./刷新登录态.md) | POST | `/api/user/auth/refresh` | 凭刷新令牌轮换访问令牌并续期会话 |
