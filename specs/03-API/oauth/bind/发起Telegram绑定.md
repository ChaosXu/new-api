# 发起 Telegram 绑定

> `POST /api/oauth/telegram/bind/start`

- **鉴权**：UserAuth（已登录用户）
- **用途**：发起一次 Telegram 绑定流程，返回 flow_token 与 Telegram 回调地址。

## 请求

无请求体。

## 响应

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| flow_token | string | 绑定流程令牌，用于构造回调地址 |
| callback_url | string | Telegram widget 回跳地址：`/api/oauth/telegram/bind/:flow_token` |
| expires_at | int64 | 过期时间（Unix 秒），有效期 5 分钟 |

```json
{
  "success": true,
  "message": "",
  "data": {
    "flow_token": "xyz...",
    "callback_url": "/api/oauth/telegram/bind/xyz...",
    "expires_at": 1700000000
  }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 200(success=false) | 管理员未开启 Telegram 登录 |
| 401 | 未登录 |
