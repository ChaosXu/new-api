# system-info 系统实例端点（超级管理员）

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/system-info/instances` | GET | RootAuth | 列出全部系统实例 | [实例列表.md](实例列表.md) |
| `/api/system-info/stale-instances` | DELETE | RootAuth | 删除全部过期实例 | [删除过期实例.md](删除过期实例.md) |
| `/api/system-info/instances/:node_name` | DELETE | RootAuth | 删除指定过期实例 | [删除指定实例.md](删除指定实例.md) |
