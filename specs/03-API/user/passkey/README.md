# Passkey API

> 路由前缀：`/api/user/passkey/*`（注册在 `selfRoute(UserAuth)` 下，实际路径为 `/api/user/passkey/*`，非 `/api/user/self/passkey`）。登录流程为公开；状态/注册/验证/删除需 `UserAuth`；管理员重置需 `AdminAuth`。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [发起Passkey登录.md](./发起Passkey登录.md) | POST | `/api/user/passkey/login/begin` | 发起可发现 Passkey 登录 |
| [完成Passkey登录.md](./完成Passkey登录.md) | POST | `/api/user/passkey/login/finish` | 完成断言并登录 |
| [查询Passkey状态.md](./查询Passkey状态.md) | GET | `/api/user/passkey` | 查询是否绑定 + 最近使用 |
| [发起Passkey注册.md](./发起Passkey注册.md) | POST | `/api/user/passkey/register/begin` | 发起注册（启 2FA 需安全验证） |
| [完成Passkey注册.md](./完成Passkey注册.md) | POST | `/api/user/passkey/register/finish` | 完成绑定，推进会话版本 |
| [发起Passkey验证.md](./发起Passkey验证.md) | POST | `/api/user/passkey/verify/begin` | 发起 step-up 二次验证 |
| [完成Passkey验证.md](./完成Passkey验证.md) | POST | `/api/user/passkey/verify/finish` | 签发 proof_token |
| [删除Passkey.md](./删除Passkey.md) | DELETE | `/api/user/passkey` | 解绑 Passkey（需安全验证） |
| [管理员重置用户Passkey.md](./管理员重置用户Passkey.md) | DELETE | `/api/user/:id/reset_passkey` | AdminAuth 强制重置 |
