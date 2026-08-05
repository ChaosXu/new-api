# Webhooks API

> 路由前缀：`/api`，无登录鉴权。均为第三方支付平台的回调入口，使用各自的签名机制验签（请求体受 `anonymousRequestBodyLimit` 限制）。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [Stripe 回调](./Stripe回调.md) | POST | /api/stripe/webhook | Stripe-Signature 验签，处理 Checkout 完成与过期 |
| [Creem 回调](./Creem回调.md) | POST | /api/creem/webhook | creem-signature HMAC 验签，处理 checkout.completed |
| [Waffo 回调](./Waffo回调.md) | POST | /api/waffo/webhook | Waffo SDK 验签（X-SIGNATURE），处理 PAY_SUCCESS 充值 |
| [Waffo-Pancake 回调](./Waffo-Pancake回调.md) | POST | /api/waffo-pancake/webhook/:env | X-Waffo-Signature 验签，按 env(test/prod) 区分流量，处理 order.completed |
