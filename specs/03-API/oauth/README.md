# OAuth 登录

路由前缀：`/api/oauth`（绑定相关端点见 [bind](./bind/)）。本目录覆盖第三方账号的登录入口与标准 OAuth 回调。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
| --- | --- | --- | --- |
| 生成OAuth状态.md | POST | /api/oauth/state | 生成登录/绑定流程的 state/flow_token |
| 标准OAuth回调.md | GET | /api/oauth/:provider | 标准 OAuth 提供商授权回调 |
| 微信登录.md | GET | /api/oauth/wechat | 微信 code 登录 |
| Telegram登录.md | GET | /api/oauth/telegram/login | Telegram Login Widget 登录 |
