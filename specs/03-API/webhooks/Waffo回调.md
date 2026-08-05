# Waffo 回调

> `POST /api/waffo/webhook`

- **鉴权**：无登录鉴权；使用 Waffo SDK 验签（请求头 `X-SIGNATURE` + 请求体原文，由 `wh.VerifySignature` 校验）（请求体受 `anonymousRequestBodyLimit` 限制）
- **用途**：接收 Waffo 支付/退款/订阅通知，对 `PAY_SUCCESS` 的订单完成充值到账，对终态失败订单标记 failed。

## 请求

无 Query/Path 参数。请求体为 Waffo 原始事件 JSON。

必需请求头：

| 头 | 必填 | 说明 |
|---|---|---|
| X-SIGNATURE | 是 | Waffo 签名，由 `sdk.Webhook().VerifySignature(body, signature)` 校验 |

## 响应

响应体为 Waffo SDK 构造的签名 JSON，并在响应头回写 `X-SIGNATURE`：

| HTTP 状态 | 场景 | 响应体 |
|---|---|---|
| 200 | 处理完成（含忽略的事件类型 / 非成功状态忽略但 ACK） | 签名后的成功/失败 JSON |
| 403 | Waffo webhook 未启用 | 无响应体 |
| 400 | 读取请求体失败 / 验签失败 | 无响应体 |
| 500 | SDK 初始化失败 | 无响应体 |

> 解析失败或充值失败时，后端通过 `sendWaffoWebhookResponse` 返回签名后的失败响应（HTTP 200）。

## 处理逻辑

仅处理 `PAYMENT` 事件（其他忽略并 ACK 成功）：

1. 若 `orderStatus != PAY_SUCCESS`：终态失败订单标记 failed（忽略错误），ACK 成功。
2. 若 `orderStatus == PAY_SUCCESS`：加锁后调用 `RechargeWaffo` 完成充值；失败返回签名后的失败响应。

## 错误码

无业务 JSON 错误体；错误以 HTTP 状态码 + 签名响应体表达（见上表）。
