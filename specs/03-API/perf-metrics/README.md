# Perf-Metrics API

> 路由前缀：`/api/perf-metrics`，整组经 `HeaderNavModulePublicOrUserAuth("pricing")` 鉴权（模块未关闭时公开可读；已登录用户可获得更完整数据）。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [获取性能概览](./获取性能概览.md) | GET | /api/perf-metrics/summary | 所有模型的性能汇总（近 N 小时） |
| [查询模型性能](./查询模型性能.md) | GET | /api/perf-metrics | 单模型按分组拆分的性能时序（model 必填） |
