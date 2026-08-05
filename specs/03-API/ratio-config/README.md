# Ratio-Config API

> 路由前缀：`/api/ratio_config`，无登录鉴权，叠加 `CriticalRateLimit`（严格限流）。仅当管理员启用「对外暴露倍率」时可用。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [获取倍率配置](./获取倍率配置.md) | GET | /api/ratio_config | 公开返回模型/补全/缓存/价格倍率（未启用返回 403） |
