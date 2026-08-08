# 控制器

## 职责

HTTP API 的请求处理器，处理用户、渠道、令牌、日志、计费、订阅、任务、Passkey、io.net 部署、签到、兑换码、上游同步、视频代理、第三方登录（Telegram/WeChat）、Codex 用量、定价倍率、性能监控等各业务接口的请求逻辑；含审计 action 模板渲染。

## 契约（开放能力）

- **各资源 CRUD 处理能力**：处理用户/渠道/令牌/日志等资源的增删改查请求。
- **支付下单与回调入账能力**：五个支付网关（EPay/Stripe/Creem/Waffo/Waffo Pancake）的下单与 webhook 回调入账，及管理员手动补单。
- **io.net 部署生命周期处理能力**：部署的创建/查询/延长/删除等请求处理。
- **签到入账能力**：用户每日签到并发放配额。
- **审计 action 渲染能力**：为敏感操作渲染审计动作模板。
- **异步任务产物代理能力**：`VideoProxy` 按任务 ID 解析已完成任务的产物 URL，经 SSRF 防护代理回拉并重发（含 data URL 解码与按渠道类型解析），详见 [flows/video-proxy.md](../../flows/video-proxy.md)。
- **第三方账号登录/绑定能力**：Telegram（HMAC 校验）、WeChat 登录与账户绑定。
- **Codex 用量端点能力**：向仪表盘暴露 Codex 渠道用量/限额重置积分查询与重置（经 Codex 集成模块）。
- **定价与倍率管理能力**：定价查询、倍率配置与上游倍率同步（详见 [flows/upstream-sync.md](../../flows/upstream-sync.md)）。
- **系统性能管理能力**：磁盘缓存清理、GC 控制、性能统计、日志文件管理。
- **配额数据看板能力**：按用户/模型/时间段查询配额数据与流量数据（详见 [flows/quota-dashboard.md](../../flows/quota-dashboard.md)）。

## 覆盖代码

`controller/`（全部控制器文件：用户/渠道/令牌/日志/计费/订阅/任务/Passkey/io.net/签到/兑换码/上游同步等 CRUD handler；`video_proxy.go`+`video_proxy_gemini.go` 视频代理；`telegram.go`/`wechat.go` 第三方登录；`codex_usage.go` Codex 用量；`pricing.go`/`ratio_config.go`/`ratio_sync.go` 定价倍率；`performance.go`/`perf_metrics.go`/`system_info.go` 性能监控；`usedata.go`/`rankings.go` 配额看板）

> 注：支付网关的 controller handler 与 service 层支付封装（`service/epay.go`、`service/waffo_pancake.go`）协作完成充值与支付流程，详见 [flows/topup-payment.md](../../flows/topup-payment.md)。

## 依赖（内部逻辑模块）

- 业务逻辑（service 全部业务能力）
- 渠道适配框架（渠道测试等直接调用适配器）
- 数据访问
- 鉴权（鉴权中间件、权限授权）
- 配置
