# Stripe下单
> `POST /api/user/stripe/pay`
- **鉴权**：UserAuth + CriticalRateLimit
- **用途**：创建 Stripe Checkout Session，返回支付跳转链接。

## 请求
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| amount | int64 | 是 | 购买数量（1~10000） |
| payment_method | string | 是 | 必须为 `"stripe"` |
| success_url | string | 否 | 支付成功重定向 URL，需在可信域名白名单内；为空用默认 |
| cancel_url | string | 否 | 支付取消重定向 URL，需在可信域名白名单内；为空用默认 |

示例：
```json
{ "amount": 10, "payment_method": "stripe", "success_url": "", "cancel_url": "" }
```

## 响应
非标准信封 `{message, data}`：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| message | string | `"success"` / `"error"` |
| data.pay_link | string | Stripe Checkout 支付链接 |

示例：
```json
{
  "message": "success",
  "data": { "pay_link": "https://checkout.stripe.com/c/pay/cs_xxx" }
}
```

## 错误码
| HTTP | message / data | 触发条件 |
| --- | --- | --- |
| 200 | error / 参数错误 | 请求体解析失败 |
| 200 | error / 不支持的支付渠道 | payment_method ≠ stripe |
| 200 | 充值数量不能小于 N（data:10） | amount 低于 Stripe 最低充值 |
| 200 | 充值数量不能大于 10000（data:10） | amount > 10000 |
| 400 | 支付成功重定向URL不在可信任域名列表中 | success_url 校验失败 |
| 400 | 支付取消重定向URL不在可信任域名列表中 | cancel_url 校验失败 |
| 200 | error / 拉起支付失败 | Stripe Checkout 创建失败 |
| 200 | error / 创建订单失败 | 本地订单插入失败 |
