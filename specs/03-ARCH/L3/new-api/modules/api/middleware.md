# 中间件

- **职责**：Gin 请求处理链的非鉴权中间件——CORS、gzip、限流、缓存、审计、请求体限制、recover、turnstile 校验、i18n 语言解析、请求分发（distributor）。
- **覆盖代码**：`middleware/`（除 auth.go/auth_origin.go 外的中间件文件：cors.go/gzip.go/cache.go/audit.go/distributor.go/turnstile.go 等）
- **关键契约**：各中间件函数、限流器接入

> 注：鉴权中间件（auth.go/auth_origin.go）归入"鉴权"域的"会话鉴权"模块。

## 依赖（内部逻辑模块）

- 通用工具（限流、Redis、缓存）
- 常量定义
- 数据访问（审计日志、缓存）
- 配置（限流设置）
- 国际化（语言解析）
