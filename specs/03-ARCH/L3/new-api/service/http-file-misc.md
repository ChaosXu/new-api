# HTTP 客户端与文件处理

- **职责**：跨业务复用的 HTTP 客户端（含代理/传输策略/SSRF 防护）、文件下载与解码（图像/音频/视频格式探测）、敏感词过滤、支付集成（EPay/Waffo/Pancake）、Codex 凭证与 OAuth 等杂项业务能力。
- **覆盖代码**：`service/http.go`、`service/http_client.go`、`service/http_transport_policy.go`、`service/http_transport_sharded.go`、`service/protected_fetch_client.go`、`service/download.go`、`service/file_decoder.go`、`service/file_service.go`、`service/sensitive.go`、`service/epay.go`、`service/waffo_pancake.go`、`service/funding_source.go`、`service/codex_*.go`、`service/rankings.go`、`service/system_instance.go`、`service/notify-limit.go`、`service/user_notify.go`
- **关键契约**：HTTP 客户端工厂、文件解码器、敏感词匹配器、SSRF 防护策略

## 依赖（内部逻辑模块）

- 通用工具（SSRF 防护、加密、限流）
- 数据访问（用户/令牌/日志）
- 配置（系统设置、运营设置）
