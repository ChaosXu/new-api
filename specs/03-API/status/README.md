# Status API

> 路由前缀：`/api`。`GetStatus` / `GetUptimeKumaStatus` 为公开接口；`TestStatus` 需 AdminAuth。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [获取系统状态](./获取系统状态.md) | GET | /api/status | 获取前端运行所需的全部系统配置 |
| [获取 Uptime 监控状态](./获取Uptime监控状态.md) | GET | /api/uptime/status | 聚合 Uptime Kuma 监控分组状态 |
| [测试数据库连接](./测试数据库连接.md) | GET | /api/status/test | 探测数据库连接并返回 HTTP 统计（AdminAuth） |
