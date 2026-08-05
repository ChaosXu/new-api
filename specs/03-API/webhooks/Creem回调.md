# Creem 回调

> `POST /api/creem/webhook`

- **鉴权**：无登录鉴权；使用 `creem-signature` 头 + `CreemWebhookSecret` 完成 HMAC-SHA256 验签（请求体受 `anonymousRequestBodyLimit` 限制）
- **用途**：接收 Creem 支付回调，处理一次性付款（充值）与订阅订单完成到账。

## 请求

无 Query/Path 参数。请求体为 Creem 原始事件 JSON。

必需请求头：

| 头 | 必填 | 说明 |
|---|---|---|
| creem-signature | 是 | HMAC-SHA256 签名（hex）。后端用 `verifyCreemSignature` 与请求体原文比对 |

> 若 `CreemWebhookSecret` 未配置且 `CreemTestMode=true`，验签被跳过（仅测试环境）；未配置且非测试模式直接拒绝。

## 响应

| HTTP 状态 | 场景 | 响应体 |
|---|---|---|
| 200 | 验签成功并处理完毕（含忽略的事件类型 / 订单未支付 / 已处理） | 无响应体（`c.Status(200)`） |
| 403 | Creem webhook 未启用 | 无响应体 |
| 400 | 读取请求体失败 / 解析失败 / 缺少 request_id / 本地订单不存在 | 无响应体 |
| 401 | 缺少签名 / 验签失败 | 无响应体 |
| 500 | 订阅/充值处理失败 | 无响应体 |

## 处理逻辑

仅处理 `checkout.completed` 事件（其他忽略并返回 200）：

1. 校验 `order.status=paid`，否则忽略。
2. 取 `object.request_id` 作为本地订单号（缺失返回 400）。
3. 先尝试 `CompleteSubscriptionOrder`；未命中再校验 `order.type=onetime`（非一次性忽略），随后走 `RechargeCreem` 完成充值。

## 错误码

无业务 JSON 错误体；错误以 HTTP 状态码表达（见上表）。
