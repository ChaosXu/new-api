# Creem下单
> `POST /api/user/creem/pay`
- **鉴权**：UserAuth + CriticalRateLimit
- **用途**：基于预设 Creem 产品创建一次性充值订单，返回 Creem 结账链接。

## 请求
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| product_id | string | 是 | Creem 产品 ID（需在 `setting.CreemProducts` 列表内） |
| payment_method | string | 是 | 必须为 `"creem"` |

示例：
```json
{ "product_id": "prod_xxx", "payment_method": "creem" }
```

## 响应
非标准信封 `{message, data}`：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| data.checkout_url | string | Creem 结账页面 URL |
| data.order_id | string | 本地订单号（referenceId，`ref_xxx`） |

示例：
```json
{
  "message": "success",
  "data": { "checkout_url": "https://www.creem.io/checkout/xxx", "order_id": "ref_abc123" }
}
```

## 错误码
HTTP 200，`message:"error"`：
| data 文案 | 触发条件 |
| --- | --- |
| 参数错误 | 请求体解析失败 |
| 不支持的支付渠道 | payment_method ≠ creem |
| 请选择产品 | product_id 为空 |
| 产品配置错误 | CreemProducts 配置 JSON 解析失败 |
| 产品不存在 | product_id 不在列表 |
| 创建订单失败 | 本地订单插入失败 |
| 拉起支付失败 | Creem 创建结账链接失败 |
| read query error | 读取请求体失败 |
