# HTTP 客户端与文件处理

## 职责

跨业务复用的 HTTP 客户端（含代理/传输策略/SSRF 防护）、文件下载与解码（图像/音频/视频格式探测）、敏感词过滤、支付封装（EPay 回调地址解析、Waffo Pancake SDK 客户端/会话/webhook 校验）、排行榜快照聚合、节点实例上报等杂项业务能力。

## 契约（开放能力）

- **跨业务 HTTP 客户端能力**：提供含代理/传输策略/SSRF 防护的复用 HTTP 客户端工厂。
- **文件下载与解码能力**：下载并探测图像/音频/视频格式。
- **敏感词过滤能力**：多模式匹配敏感词。
- **支付封装能力**：EPay 回调地址解析、Waffo Pancake 会话创建与 webhook 校验。
- **排行榜快照能力**：聚合 `quota_data` 表生成模型/厂商排行榜快照（5 分钟内存缓存）。
- **节点实例上报能力**：后台定时上报本节点身份与运行信息（仅主节点）。

## 覆盖代码

`server/internal/service/http.go`、`server/internal/service/http_client.go`、`server/internal/service/http_transport_policy.go`、`server/internal/service/http_transport_sharded.go`、`server/internal/service/protected_fetch_client.go`、`server/internal/service/download.go`、`server/internal/service/file_decoder.go`、`server/internal/service/file_service.go`、`server/internal/service/sensitive.go`、`server/internal/service/epay.go`、`server/internal/service/waffo_pancake.go`、`server/internal/service/funding_source.go`、`server/internal/service/rankings.go`（排行榜快照聚合）、`server/internal/service/system_instance.go`（节点实例后台上报）

> 注：五个支付网关（EPay/Stripe/Creem/Waffo/Waffo Pancake）的下单 handler、webhook 回调与配额入账在控制器层（`server/internal/controller/topup_*.go`），归"控制器"模块；本模块仅承载 service 层的支付封装/客户端能力。Codex 凭证/模型/用量与用户通知已拆为独立模块（见 [codex-integration.md](codex-integration.md)、[user-notify.md](user-notify.md)）。

## 依赖（内部逻辑模块）

- 通用工具（SSRF 防护、加密、限流）
- 数据访问（用户/令牌/日志）
- 配置（系统设置、运营设置）
