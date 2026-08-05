# 登录会话 API

> 路由前缀：`/api/user/sessions`，挂在 `selfRoute(UserAuth)` 下并附加 `DisableCache`。所有端点要求浏览器登录会话身份（PAT 调用会返回 `AUTH_SESSION_REQUIRED`）。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [查询登录会话列表.md](./查询登录会话列表.md) | GET | `/api/user/sessions` | 列出当前用户所有活跃会话 |
| [删除指定会话.md](./删除指定会话.md) | DELETE | `/api/user/sessions/:sid` | 吊销指定会话 |
| [吊销其他会话.md](./吊销其他会话.md) | POST | `/api/user/sessions/revoke-others` | 吊销除当前外的所有会话 |
