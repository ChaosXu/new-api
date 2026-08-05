# Waffo下单
> `POST /api/user/waffo/pay`
- **鉴权**：UserAuth + CriticalRateLimit
- **用途**：创建 Waffo 支付订单，返回支付跳转链接。

## 请求
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| amount | int64 | 是 | 充值数量（不低于 WaffoMinTopUp） |
| pay_method_index | int* | 否 | 服务端支付方式列表索引，nil 表示由 Waffo 自动选择 |
| pay_method_type | string | 否 | （已废弃，兼容旧前端）支付方式类型 |
| pay_method_name | string | 否 | （已废弃，兼容旧前端）支付方式名称 |

支付方式解析优先级：`pay_method_index` > 旧 `pay_method_type`+`pay_method_name` > 留空（自动选择）。

示例：
```json
{ "amount": 10, "pay_method_index": 0 }
```

## 响应
非标准信封 `{message, data}`：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| data.payment_url | string | Waffo 支付跳转 URL |
| data.order_id | string | 本地订单号（merchantOrderId，`WAFFO-...`） |

示例：
```json
{
  "message": "success",
  "data": { "payment_url": "https://pay.waffo.com/xxx", "order_id": "WAFFO-2-1700000000-abc123" }
}
```

## 错误码
HTTP 200，`message:"error"`：
| data 文案 | 触发条件 |
| --- | --- |
| 参数错误 | 请求体解析失败 |
| Waffo 支付未启用 | setting.WaffoEnabled=false |
| 充值数量不能小于 N | amount 低于 WaffoMinTopUp |
| 用户不存在 | 用户查询失败 |
| 不支持的支付方式 | pay_method_index 越界或旧字段未匹配 |
| 充值金额过低 | 计算后金额 < 0.01 |
| 创建订单失败 | 本地订单插入失败 |
| 支付配置错误 | Waffo SDK 初始化失败（订单标记 failed） |
| 拉起支付失败 | SDK 创建订单失败或业务失败（订单标记 failed） |
