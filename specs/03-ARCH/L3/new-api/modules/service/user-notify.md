# 用户通知

## 职责

向用户投递面向用户的通知（如渠道测试结果、上游模型更新等管理/系统事件），支持多通道（邮件、webhook HMAC 签名、Bark、Gotify），每种通道按用户×类型粒度限流（Redis 或内存兜底）。纯出站推送子系统，不实现 SSE。

## 契约（开放能力）

- **按用户分发通知能力**：按用户 ID 查询其配置的通知类型（邮件/webhook/Bark/Gotify），占位符替换后投递。
- **便捷通知能力**：通知 root 用户、通知所有订阅上游模型更新的管理员。
- **通知限流能力**：按用户×通知类型在时间窗口内限流（Redis 主、内存兜底），限流通过后才投递。
- **HMAC 签名 webhook 投递能力**：向用户配置的 URL 发送带 `X-Webhook-Signature`（HMAC-SHA256）头的 JSON 负载。

## 覆盖代码

`server/internal/service/user_notify.go`（NotifyRootUser、NotifyUpstreamModelUpdateWatchers、NotifyUser 分发、sendEmailNotify、sendBarkNotify、sendGotifyNotify）、`server/internal/service/notify-limit.go`（CheckNotificationLimit、Redis/内存限流、清理任务）、`server/internal/service/webhook.go`（SendWebhookNotify、generateSignature、WebhookPayload）

## 依赖（内部逻辑模块）

- 通用工具（Redis、邮件发送、SSRF 防护、限流器）
- HTTP 客户端与文件处理（出站 worker/SSRF 直连请求工具）
- 数据访问（用户查询）
