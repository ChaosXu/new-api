# 订阅易支付返回POST
> `POST /api/subscription/epay/return`
- **鉴权**：无鉴权
- **用途**：易支付以 POST 方式回传浏览器返回数据，校验后完成订单并 302 重定向到控制台。逻辑与 GET 返回一致。

## 请求
来自易支付的 POST 表单参数（签名、交易状态等）。

## 响应
HTTP 302 重定向（非 JSON）：
- 成功：`/wallet?pay=success`
- 待处理：`/wallet?pay=pending`
- 失败：`/wallet?pay=fail`

## 错误码
无
