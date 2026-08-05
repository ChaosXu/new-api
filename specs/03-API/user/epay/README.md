# 易支付回调

易支付异步通知回调，匿名访问（由易支付网关发起）。响应为纯文本 `success` / `fail`，非 JSON 信封。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/user/epay/notify` | POST | 无（匿名） | 易支付 POST 回调，表单参数 | [易支付回调POST.md](易支付回调POST.md) |
| `/api/user/epay/notify` | GET | 无（匿名） | 易支付 GET 回调，Query 参数 | [易支付回调GET.md](易支付回调GET.md) |
