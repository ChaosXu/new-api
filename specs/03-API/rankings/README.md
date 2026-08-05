# Rankings API

> 路由前缀：`/api/rankings`，经 `HeaderNavModuleAuth("rankings")` 鉴权（顶栏「排行」模块需启用）。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [获取模型排行](./获取模型排行.md) | GET | /api/rankings | 模型/厂商用量排行、涨跌幅、历史时序（period 默认 week） |
