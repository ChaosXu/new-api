# HTTP 客户端与文件处理

## 职责

跨业务复用的 HTTP 客户端（含代理/传输策略/SSRF 防护）、文件下载与解码（图像/音频/视频格式探测）、敏感词过滤、支付封装（EPay 回调地址解析、Waffo Pancake SDK 客户端/会话/webhook 校验）、Codex 凭证与 OAuth 等杂项业务能力。

## 契约（开放能力）

- **跨业务 HTTP 客户端能力**：提供含代理/传输策略/SSRF 防护的复用 HTTP 客户端工厂。
- **文件下载与解码能力**：下载并探测图像/音频/视频格式。
- **敏感词过滤能力**：多模式匹配敏感词。
- **支付封装能力**：EPay 回调地址解析、Waffo Pancake 会话创建与 webhook 校验。

## 覆盖代码

`service/http.go`、`service/http_client.go`、`service/http_transport_policy.go`、`service/http_transport_sharded.go`、`service/protected_fetch_client.go`、`service/download.go`、`service/file_decoder.go`、`service/file_service.go`、`service/sensitive.go`、`service/epay.go`、`service/waffo_pancake.go`、`service/funding_source.go`、`service/codex_*.go`、`service/rankings.go`、`service/system_instance.go`、`service/notify-limit.go`、`service/user_notify.go`

> 注：五个支付网关（EPay/Stripe/Creem/Waffo/Waffo Pancake）的下单 handler、webhook 回调与配额入账在控制器层（`controller/topup_*.go`），归"控制器"模块；本模块仅承载 service 层的支付封装/客户端能力。

## 依赖（内部逻辑模块）

- 通用工具（SSRF 防护、加密、限流）
- 数据访问（用户/令牌/日志）
- 配置（系统设置、运营设置）
