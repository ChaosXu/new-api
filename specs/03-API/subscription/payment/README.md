# 订阅支付

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/subscription/balance/pay` | POST | UserAuth + CriticalRateLimit | 余额购买订阅 | [余额购买订阅.md](余额购买订阅.md) |
| `/api/subscription/epay/pay` | POST | UserAuth + CriticalRateLimit | 易支付拉起订阅支付 | [易支付购买订阅.md](易支付购买订阅.md) |
| `/api/subscription/stripe/pay` | POST | UserAuth + CriticalRateLimit | Stripe 创建订阅支付链接 | [Stripe购买订阅.md](Stripe购买订阅.md) |
| `/api/subscription/creem/pay` | POST | UserAuth + CriticalRateLimit | Creem 创建订阅结账链接 | [Creem购买订阅.md](Creem购买订阅.md) |
| `/api/subscription/waffo-pancake/pay` | POST | UserAuth + CriticalRateLimit | Waffo Pancake 创建订阅结账会话 | [Waffo-Pancake购买订阅.md](Waffo-Pancake购买订阅.md) |

> 所有支付端点均要求管理员先确认支付合规（见 [option/确认支付合规.md](../option/确认支付合规.md)）。
