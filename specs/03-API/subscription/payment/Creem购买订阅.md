# Creem购买订阅
> `POST /api/subscription/creem/pay`
- **鉴权**：UserAuth（用户登录态）+ CriticalRateLimit
- **用途**：通过 Creem 创建订阅结账链接。需管理员已确认支付合规。

## 请求
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| plan_id | int | 是 | 订阅计划 ID |

示例：
```json
{ "plan_id": 1 }
```

## 响应
非标准信封：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| message | string | `success` / `error` |
| data | object | 成功为 `{ checkout_url, order_id }`；失败为错误描述字符串 |

示例：
```json
{
  "message": "success",
  "data": { "checkout_url": "https://www.creem.io/checkout/...", "order_id": "sub_xxx" }
}
```

## 错误码
| HTTP | message | 说明 |
| --- | --- | --- |
| 200 | 支付合规声明未确认（MsgPaymentComplianceRequired） | 管理员未确认支付合规 |
| 200 | 参数错误 / read query error | 请求体解析失败 |
| 200 | 套餐未启用 | 计划 disabled |
| 200 | 该套餐未配置 CreemProductId | 计划缺少 Creem 配置 |
| 200 | Creem Webhook 未配置 | webhook 未配置 |
| 200 | 用户不存在 | 用户查询失败 |
| 200 | 已达到该套餐购买上限 | 超过单用户上限 |
| 200 | 创建订单失败 / 拉起支付失败 | data 字段携带原因 |
