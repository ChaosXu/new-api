# Stripe金额校验
> `POST /api/user/stripe/amount`
- **鉴权**：UserAuth
- **用途**：根据数量预计算 Stripe 实际支付金额。

## 请求
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| amount | int64 | 是 | 购买数量 |

示例：
```json
{ "amount": 10 }
```

## 响应
非标准信封 `{message, data}`：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| message | string | `"success"` / `"error"` |
| data | string | 支付金额（两位小数字符串） |

示例：
```json
{ "message": "success", "data": "2.50" }
```

## 错误码
HTTP 200，`message:"error"`：
| data 文案 | 触发条件 |
| --- | --- |
| 参数错误 | 请求体解析失败 |
| 充值数量不能小于 N | amount 低于 Stripe 最低充值 |
| 获取用户分组失败 | 无法读取用户分组 |
| 充值金额过低 | 计算后金额 <= 0.01 |
