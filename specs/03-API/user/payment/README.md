# 在线支付

所有端点均挂在 `selfRoute`（UserAuth）下，部分加 `CriticalRateLimit`。
支付下单响应多为非标准信封 `{message, data, ...}`（无 `success` 字段）：`message:"success"` 表示成功，`message:"error"` 表示失败。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/user/pay` | POST | UserAuth + CriticalRateLimit | 易支付下单 | [易支付下单.md](易支付下单.md) |
| `/api/user/amount` | POST | UserAuth | 易支付金额校验 | [易支付金额校验.md](易支付金额校验.md) |
| `/api/user/stripe/pay` | POST | UserAuth + CriticalRateLimit | Stripe 下单 | [Stripe下单.md](Stripe下单.md) |
| `/api/user/stripe/amount` | POST | UserAuth | Stripe 金额校验 | [Stripe金额校验.md](Stripe金额校验.md) |
| `/api/user/creem/pay` | POST | UserAuth + CriticalRateLimit | Creem 下单 | [Creem下单.md](Creem下单.md) |
| `/api/user/waffo/pay` | POST | UserAuth + CriticalRateLimit | Waffo 下单 | [Waffo下单.md](Waffo下单.md) |
| `/api/user/waffo/amount` | POST | UserAuth | Waffo 金额校验 | [Waffo金额校验.md](Waffo金额校验.md) |
| `/api/user/waffo-pancake/pay` | POST | UserAuth + CriticalRateLimit | Waffo Pancake 下单 | [Waffo-Pancake下单.md](Waffo-Pancake下单.md) |
| `/api/user/waffo-pancake/amount` | POST | UserAuth | Waffo Pancake 金额校验 | [Waffo-Pancake金额校验.md](Waffo-Pancake金额校验.md) |
