# 订阅易支付返回GET
> `GET /api/subscription/epay/return`
- **鉴权**：无鉴权
- **用途**：用户支付完成后浏览器跳转回站点，校验载荷并完成订单后 302 重定向到控制台。

## 请求
来自易支付的 URL Query 参数（签名、交易状态等）。

## 响应
HTTP 302 重定向（非 JSON），目标路径由 paymentReturnPath 决定：
- 支付成功并订单完成：`/wallet?pay=success`
- 交易待处理：`/wallet?pay=pending`
- 任何失败：`/wallet?pay=fail`

## 错误码
无（以重定向到 `pay=fail` 表达失败）
