# 双因素认证 (2FA) API

> 路由前缀：`/api/user/2fa/*`，挂在 `selfRoute(UserAuth)` 下。用户自管理需 `UserAuth`；统计与强制禁用需 `AdminAuth`。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [查询2FA状态.md](./查询2FA状态.md) | GET | `/api/user/2fa/status` | enabled/locked/备用码剩余 |
| [生成2FA密钥.md](./生成2FA密钥.md) | POST | `/api/user/2fa/setup` | 初始化密钥+二维码+备用码 |
| [启用2FA.md](./启用2FA.md) | POST | `/api/user/2fa/enable` | 验证码确认启用，推进会话版本 |
| [禁用2FA.md](./禁用2FA.md) | POST | `/api/user/2fa/disable` | TOTP/备用码禁用 |
| [重新生成备用码.md](./重新生成备用码.md) | POST | `/api/user/2fa/backup_codes` | TOTP 确认后重发备用码 |
| [2FA启用统计.md](./2FA启用统计.md) | GET | `/api/user/2fa/stats` | AdminAuth 全平台统计 |
| [强制禁用用户2FA.md](./强制禁用用户2FA.md) | DELETE | `/api/user/:id/2fa` | AdminAuth 强制禁用并吊销会话 |
