# log 日志端点

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/log/` | GET | AdminAuth | 全局日志列表 | [全局日志列表.md](全局日志列表.md) |
| `/api/log/search` | GET | AdminAuth | 已废弃 | [全局日志搜索.md](全局日志搜索.md) |
| `/api/log/stat` | GET | AdminAuth | 全局日志统计 | [日志统计.md](日志统计.md) |
| `/api/log/channel_affinity_usage_cache` | GET | AdminAuth | 渠道亲和用量缓存统计 | [渠道亲和缓存统计.md](渠道亲和缓存统计.md) |
| `/api/log/self` | GET | UserAuth | 当前用户日志 | [用户日志.md](用户日志.md) |
| `/api/log/self/search` | GET | UserAuth + SearchRateLimit | 已废弃 | [用户日志搜索.md](用户日志搜索.md) |
| `/api/log/self/stat` | GET | UserAuth | 当前用户日志统计 | [用户日志统计.md](用户日志统计.md) |
| `/api/log/token` | GET | TokenAuthReadOnly | 按令牌查询日志 | [按Key查询日志.md](按Key查询日志.md) |
