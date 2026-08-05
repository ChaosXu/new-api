# Waffo-Pancake下单
> `POST /api/user/waffo-pancake/pay`
- **鉴权**：UserAuth + CriticalRateLimit
- **用途**：基于已绑定的 Pancake 产品创建一次性充值订单，返回结账会话。

## 请求
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| amount | int64 | 是 | 充值数量（不低于 WaffoPancakeMinTopUp） |

示例：
```json
{ "amount": 10 }
```

## 响应
非标准信封 `{message, data}`：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| data.checkout_url | string | 结账页 URL |
| data.session_id | string | Pancake 会话 ID |
| data.expires_at | int64/string | 会话过期时间 |
| data.order_id | string | 本地订单号（`WAFFO_PANCAKE-...`） |
| data.token | string | 会话 token |
| data.token_expires_at | int64/string | token 过期时间 |

示例：
```json
{
  "message": "success",
  "data": {
    "checkout_url": "https://checkout.pancake.so/xxx",
    "session_id": "ses_xxx",
    "expires_at": 1700002700,
    "order_id": "WAFFO_PANCAKE-2-1700000000-abc123",
    "token": "tok_xxx",
    "token_expires_at": 1700002700
  }
}
```

## 错误码
HTTP 200，`message:"error"`：
| data 文案 | 触发条件 |
| --- | --- |
| 参数错误 | 请求体解析失败 |
| Waffo Pancake 配置不完整 | 网关未启用 |
| 充值数量不能小于 N | amount 低于 WaffoPancakeMinTopUp |
| 用户不存在 | 用户查询失败 |
| 获取用户分组失败 | 无法读取用户分组 |
| 充值金额过低 | 计算后金额 < 0.01 |
| 创建订单失败 | 本地订单插入失败 |
| 拉起支付失败 | 创建 Pancake 结账会话失败（订单标记 failed） |
