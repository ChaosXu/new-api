# Stripe 回调

> `POST /api/stripe/webhook`

- **鉴权**：无登录鉴权；使用 Stripe-Signature 头 + Webhook Secret 完成签名验证（请求体受 `anonymousRequestBodyLimit` 限制）
- **用途**：接收 Stripe Checkout 事件回调，处理订单完成、异步支付成功/失败、会话过期等，完成充值到账或订单状态更新。

## 请求

无 Query/Path 参数。请求体为 Stripe 原始事件 JSON（由后端 `io.ReadAll` 读取原始字节用于验签）。

必需请求头：

| 头 | 必填 | 说明 |
|---|---|---|
| Stripe-Signature | 是 | Stripe 签名，使用 `setting.StripeWebhookSecret` + `webhook.ConstructEventWithOptions`（忽略 API 版本不匹配）校验 |

## 响应

| HTTP 状态 | 场景 | 响应体 |
|---|---|---|
| 200 | 验签成功并处理完毕（含忽略的事件类型） | 无响应体（`c.Status(200)`） |
| 403 | Stripe webhook 未启用 | 无响应体（`AbortWithStatus(403)`） |
| 503 | 读取请求体失败 | 无响应体（`AbortWithStatus(503)`） |
| 400 | 验签失败 | 无响应体（`AbortWithStatus(400)`） |

## 处理逻辑

仅处理以下事件，其他事件类型忽略并返回 200：

| 事件类型 | 行为 |
|---|---|
| `checkout.session.completed` | 校验 `status=complete` 且 `payment_status=paid` 后完成订单（订阅优先，否则普通充值） |
| `checkout.session.async_payment_succeeded` | 延迟支付成功，完成订单 |
| `checkout.session.async_payment_failed` | 延迟支付失败，将 pending 订单标记为 failed |
| `checkout.session.expired` | 会话过期，将订阅/充值订单标记为 expired |

> 完成订单会先尝试 `CompleteSubscriptionOrder`（订阅），未命中再走 `Recharge`（普通充值）。

## 错误码

无业务 JSON 错误体；错误以 HTTP 状态码表达（见上表）。
