# 中间件

## 职责

Gin 请求处理链的通用中间件层（不含会话鉴权，鉴权归"鉴权"域）。提供跨域、限流、缓存、请求分发、人机验证、请求体控制、panic 恢复、i18n 语言解析等请求处理能力，以及部分非会话的访问控制（管理员/Root/Token 校验）。

## 契约（开放能力）

- **跨域与可信代理能力**：CORS 跨域处理；可信代理配置（ConfigureTrustedProxies，解析 X-Forwarded-* 头）。
- **多维度限流能力**：关键操作限流（CriticalRateLimit）、全局 API 限流（GlobalAPIRateLimit）、全局 Web 限流（GlobalWebRateLimit）、下载限流（DownloadRateLimit）、上传限流（UploadRateLimit）、搜索限流（SearchRateLimit）、模型请求限流（ModelRequestRateLimit）、邮件验证限流（EmailVerificationRateLimit）。
- **请求分发与上下文装配能力**：按分组/优先级/权重选渠道并注入上下文（Distribute、SetupContextForSelectedChannel）；按令牌装配请求上下文（SetupContextForToken）。
- **人机验证与安全证明能力**：Cloudflare Turnstile 人机校验（TurnstileCheck）；敏感操作安全证明（RequireSecurityProof、SecureVerificationRequired）。
- **请求体与缓存控制能力**：匿名请求体大小限制（AnonymousRequestBodyLimit）；请求体清理与存储（BodyStorageCleanup）；响应缓存控制（Cache、DisableCache）；gzip 解压（DecompressRequestMiddleware）。
- **健壮性能力**：中继 panic 恢复（RelayPanicRecover）；请求 ID 注入（RequestId）；系统性能检查拦截（SystemPerformanceCheck）。
- **国际化能力**：从请求解析用户语言（GetLanguage），注入 i18n 上下文。
- **审计与统计能力**：请求统计采集（StatsMiddleware、GetStats）；路由标记（RouteTag）。
- **非会话访问控制能力**：管理员鉴权（AdminAuth）、Root 鉴权（RootAuth）、令牌鉴权（TokenAuth/TokenAuthReadOnly/TokenOrUserAuth）、权限要求（RequirePermission）、头部导航模块访问控制（HeaderNavModuleAuth/HeaderNavModulePublicOrUserAuth）；会话 Cookie 来源守护（SessionCookieOriginGuard）；WebSocket 鉴权（WssAuth）。
- **请求转换能力**：即梦/可灵等特定渠道的请求格式转换（JimengRequestConvert、KlingRequestConvert）。
- **日志与通用能力**：请求日志装配（SetUpLogger）；版本信息（Version）。

## 覆盖代码

`middleware/`（除 `auth.go`/`auth_origin.go` 外的中间件文件：cors.go、gzip.go、cache.go、audit.go、distributor.go、turnstile.go、rate_limit.go、recover.go 等）。

> 注：会话鉴权中间件（auth.go/auth_origin.go）归入"鉴权"域的"会话与令牌鉴权"模块。

## 依赖（内部逻辑模块）

- 通用工具（限流器、Redis、缓存）
- 常量与基础类型
- 数据访问（审计日志、缓存、渠道能力查询）
- 配置（限流设置、运营设置）
- 国际化（语言包）
- 渠道选择（distributor 选渠道）
