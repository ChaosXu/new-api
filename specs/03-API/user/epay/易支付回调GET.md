# 易支付回调GET
> `GET /api/user/epay/notify`
- **鉴权**：无（匿名，由易支付网关回调）
- **用途**：与 POST 版本一致的回调处理，仅参数来源不同——从 URL Query 解析。响应为纯文本。

## 请求
Query 参数为易支付标准回调参数（如 `out_trade_no`、`trade_no`、`type`、`trade_status`、签名等）。控制器解析 `c.Request.URL.Query()` 为 `map[string]string` 后调用 `client.Verify(params)` 验签。

## 响应
**纯文本**（非 JSON）：
| 文本 | 含义 |
| --- | --- |
| `success` | 验签通过 |
| `fail` | webhook 未启用 / 参数为空 / client 未初始化 / 验签失败 |

验签通过且 `trade_status == TRADE_SUCCESS` 时，订单级互斥（LockOrder）后更新订单为成功并 `IncreaseUserQuota`。

## 错误码
无（HTTP 200，纯文本 body）。失败一律返回 `fail`。
