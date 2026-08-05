# user 用户管理端点

管理员（AdminAuth）用户 CRUD 与管理接口。标准响应信封 `{success, message, data}`。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/user/` | GET | AdminAuth | 分页查询用户列表 | [用户列表.md](用户列表.md) |
| `/api/user/search` | GET | AdminAuth | 按关键字/分组/角色/状态搜索用户 | [搜索用户.md](搜索用户.md) |
| `/api/user/:id` | GET | AdminAuth | 获取用户详情 | [获取用户详情.md](获取用户详情.md) |
| `/api/user/` | POST | AdminAuth | 创建用户 | [创建用户.md](创建用户.md) |
| `/api/user/` | PUT | AdminAuth | 更新用户 | [更新用户.md](更新用户.md) |
| `/api/user/manage` | POST | AdminAuth | 管理（禁用/启用/删除/升降级/调额度） | [管理用户.md](管理用户.md) |
| `/api/user/:id` | DELETE | AdminAuth | 硬删除用户 | [删除用户.md](删除用户.md) |
