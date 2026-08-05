# 用户自助 API

> 路由前缀：`/api/user/self`、`/api/user/*`（个人资料、分组、模型、令牌、邀请码、偏好）。鉴权：`UserAuth`（已登录用户）。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [获取当前用户信息.md](./获取当前用户信息.md) | GET | `/api/user/self` | 返回 buildSelfUserData DTO + 权限矩阵 |
| [更新个人资料.md](./更新个人资料.md) | PUT | `/api/user/self` | 三种模式：侧栏/语言/资料改密 |
| [注销当前用户.md](./注销当前用户.md) | DELETE | `/api/user/self` | 当前用户软删除（超管不可） |
| [查询可用分组.md](./查询可用分组.md) | GET | `/api/user/self/groups`、`/api/user/groups` | 可用分组 + 倍率 + 描述 |
| [查询可用模型.md](./查询可用模型.md) | GET | `/api/user/models` | 当前用户可用模型（可按 group 过滤） |
| [生成访问令牌.md](./生成访问令牌.md) | GET | `/api/user/token` | 生成/覆盖个人 PAT |
| [查询邀请码.md](./查询邀请码.md) | GET | `/api/user/aff` | 获取/生成邀请码 |
| [更新偏好设置.md](./更新偏好设置.md) | PUT | `/api/user/setting` | 额度预警通知/webhook/Bark/Gotify 偏好 |
