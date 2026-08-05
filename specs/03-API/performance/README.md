# performance 性能端点（超级管理员）

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/performance/stats` | GET | RootAuth | 获取性能统计 | [性能统计.md](性能统计.md) |
| `/api/performance/disk_cache` | DELETE | RootAuth | 清理不活跃磁盘缓存 | [清理磁盘缓存.md](清理磁盘缓存.md) |
| `/api/performance/reset_stats` | POST | RootAuth | 重置性能统计计数 | [重置性能统计.md](重置性能统计.md) |
| `/api/performance/gc` | POST | RootAuth | 强制垃圾回收 | [强制GC.md](强制GC.md) |
| `/api/performance/logs` | GET | RootAuth | 列出日志文件 | [日志文件列表.md](日志文件列表.md) |
| `/api/performance/logs` | DELETE | RootAuth | 按数量/天数清理日志 | [清理日志文件.md](清理日志文件.md) |
