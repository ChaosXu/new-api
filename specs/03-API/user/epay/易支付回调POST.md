# 易支付回调POST
> `POST /api/user/epay/notify`
- **鉴权**：无（匿名，由易支付网关回调；受 `anonymousRequestBodyLimit` 限制）
- **用途**：接收易支付服务器的异步支付结果通知，验签成功后为订单发放额度。响应为纯文本。

## 请求
请求体为易支付标准 POST 表单（`application/x-www-form-urlencoded`），包含易支付回调参数（如 `out_trade_no`、`trade_no`、`type`、`trade_status`、签名等）。控制器解析 `c.Request.PostForm` 为 `map[string]string` 后调用 `client.Verify(params)` 验签。

## 响应
**纯文本**（非 JSON）：
| 文本 | 含义 |
| --- | --- |
| `success` | 验签通过 |
| `fail` | webhook 未启用 / 表单解析失败 / 参数为空 / client 未初始化 / 验签失败 |

验签通过且 `trade_status == TRADE_SUCCESS` 时，订单级互斥（LockOrder）后更新订单为成功并 `IncreaseUserQuota`。

## 错误码
无（HTTP 200，纯文本 body）。失败一律返回 `fail`。
