# 订阅易支付回调GET
> `GET /api/subscription/epay/notify`
- **鉴权**：无鉴权
- **用途**：易支付 GET 方式异步通知，逻辑与 POST 回调一致。

## 请求
来自易支付网关的 URL Query 参数（签名、交易状态等）。

## 响应
纯文本，非 JSON：
- 校验通过且订单完成：`success`
- 失败：`fail`

## 错误码
无
