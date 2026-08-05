# Pricing API

> 路由前缀：`/api/pricing`，经 `HeaderNavModuleAuth("pricing")` 鉴权（顶栏「定价」模块需启用）。响应为非标准信封。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [获取定价](./获取定价.md) | GET | /api/pricing | 返回过滤后的模型定价、分组倍率、可用分组与供应商 |
