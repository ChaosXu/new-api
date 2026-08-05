# Waffo-Pancake 回调

> `POST /api/waffo-pancake/webhook/:env`

- **鉴权**：无登录鉴权；使用 `X-Waffo-Signature` 头 + 已配置凭证完成验签（请求体受 `anonymousRequestBodyLimit` 限制）
- **用途**：接收 Waffo Pancake 订单完成回调，按订单号前缀分发到普通充值或订阅完成流程。路径段 `:env` 用于区分测试/生产流量。

## 请求

Path 参数：

| 参数 | 必填 | 说明 |
|---|---|---|
| env | 是 | 环境标识，仅允许 `test` 或 `prod`（其他返回 404）。后端会强制 `event.mode` 与该值匹配 |

必需请求头：

| 头 | 必填 | 说明 |
|---|---|---|
| X-Waffo-Signature | 是 | Pancake 签名，由 `service.VerifyConfiguredWaffoPancakeWebhook(body, signature)` 校验 |

## 响应

响应体为纯文本：

| HTTP 状态 | 场景 | 响应体 |
|---|---|---|
| 200 | 处理完成 / 环境不匹配（ACK 避免重试）/ 非目标事件 / 订单解析失败 | `OK` |
| 403 | webhook 未启用 | `webhook disabled` |
| 404 | `:env` 非 test/prod | `unknown env` |
| 400 | 读取请求体失败 | `bad request` |
| 401 | 验签失败 | `invalid signature` |
| 500 | 订阅完成失败 / 充值处理失败 | `retry` |

## 处理逻辑

仅处理归一化事件类型 `order.completed`（其他 ACK 成功）：

1. 校验 `event.mode` 与路径 `:env` 一致（不匹配 ACK 成功，仅记错误日志）。
2. 取 `orderMerchantExternalID`（即本地 trade_no），按前缀分发：
   - 以 `WAFFO_PANCAKE_SUB-` 开头：解析订阅订单号后调用 `CompleteSubscriptionOrder`。
   - 否则：解析普通充值订单号后调用 `RechargeWaffoPancake`。

## 错误码

无业务 JSON 错误体；错误以 HTTP 状态码 + 纯文本响应体表达（见上表）。
