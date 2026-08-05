# 订阅管理

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/subscription/admin/plans` | GET | AdminAuth | 获取全部订阅计划 | [计划列表.md](计划列表.md) |
| `/api/subscription/admin/plans` | POST | AdminAuth | 创建订阅计划 | [创建计划.md](创建计划.md) |
| `/api/subscription/admin/plans/:id` | PUT | AdminAuth | 更新订阅计划 | [更新计划.md](更新计划.md) |
| `/api/subscription/admin/plans/:id` | PATCH | AdminAuth | 更新计划启用状态 | [更新计划状态.md](更新计划状态.md) |
| `/api/subscription/admin/bind` | POST | AdminAuth | 为用户绑定订阅（免支付） | [绑定订阅.md](绑定订阅.md) |
| `/api/subscription/admin/plans/:id/subscriptions/reset` | POST | AdminAuth | 重置计划下所有用户订阅额度 | [重置计划订阅.md](重置计划订阅.md) |
| `/api/subscription/admin/users/:id/subscriptions` | GET | AdminAuth | 查询用户全部订阅 | [查询用户订阅.md](查询用户订阅.md) |
| `/api/subscription/admin/users/:id/subscriptions` | POST | AdminAuth | 为用户创建订阅 | [创建用户订阅.md](创建用户订阅.md) |
| `/api/subscription/admin/users/:id/subscriptions/reset` | POST | AdminAuth | 按计划重置用户订阅额度 | [重置用户订阅.md](重置用户订阅.md) |
| `/api/subscription/admin/user_subscriptions/:id/invalidate` | POST | AdminAuth | 使订阅立即失效 | [使订阅失效.md](使订阅失效.md) |
| `/api/subscription/admin/user_subscriptions/:id` | DELETE | AdminAuth | 删除用户订阅 | [删除用户订阅.md](删除用户订阅.md) |

> 除「计划列表」「重置计划订阅」「查询用户订阅」「使订阅失效」「删除用户订阅」外，其余写操作均要求管理员先确认支付合规。
