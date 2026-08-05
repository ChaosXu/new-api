# data 配额统计端点

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/data/` | GET | AdminAuth | 全局额度按日统计 | [全局配额统计.md](全局配额统计.md) |
| `/api/data/users` | GET | AdminAuth | 额度按用户分组统计 | [按用户配额统计.md](按用户配额统计.md) |
| `/api/data/self` | GET | UserAuth | 当前用户额度按日统计 | [用户配额统计.md](用户配额统计.md) |
| `/api/data/flow` | GET | AdminAuth | 全局流量额度统计 | [全局流量配额.md](全局流量配额.md) |
| `/api/data/flow/self` | GET | UserAuth | 当前用户流量额度统计 | [用户流量配额.md](用户流量配额.md) |
