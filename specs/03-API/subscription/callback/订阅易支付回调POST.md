# 订阅易支付回调POST
> `POST /api/subscription/epay/notify`
- **鉴权**：无鉴权（服务器间回调）
- **用途**：易支付服务端异步通知，校验签名并完成订阅订单。

## 请求
来自易支付网关的 POST 表单参数（如 `out_trade_no`、`trade_no`、`trade_status`、`money`、签名等）。

## 响应
纯文本，非 JSON：
- 校验通过且订单完成：`success`
- 任何失败（参数空、签名校验失败、订单完成失败等）：`fail`

## 错误码
无（以纯文本 `fail` 表达失败）
