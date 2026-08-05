# 第三方账号绑定与解绑

路由前缀：覆盖 `/api/oauth/*`（绑定发起）与 `/api/user/*`（绑定查询/解绑，含管理员）。本目录描述将第三方账号关联到已有用户的端点。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
| --- | --- | --- | --- |
| 绑定邮箱.md | POST | /api/oauth/email/bind | 当前用户绑定邮箱（验证码） |
| 绑定微信.md | POST | /api/oauth/wechat/bind | 当前用户绑定微信 |
| 发起Telegram绑定.md | POST | /api/oauth/telegram/bind/start | 发起 Telegram 绑定流程 |
| 完成Telegram绑定.md | GET | /api/oauth/telegram/bind/:flow_token | Telegram 绑定回调（302） |
| 查询已绑定第三方账号.md | GET | /api/user/oauth/bindings | 查询当前用户自定义 OAuth 绑定 |
| 解绑第三方账号.md | DELETE | /api/user/oauth/bindings/:provider_id | 当前用户解绑 |
| 管理员查看用户绑定.md | GET | /api/user/:id/oauth/bindings | 管理员查看指定用户绑定 |
| 管理员解绑用户账号.md | DELETE | /api/user/:id/oauth/bindings/:provider_id | 管理员解绑 |
| 管理员清除用户绑定.md | DELETE | /api/user/:id/bindings/:binding_type | 管理员按内置绑定类型（email/github/discord/oidc/wechat/telegram/linuxdo）清除 |
