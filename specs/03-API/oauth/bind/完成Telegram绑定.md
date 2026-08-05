# 完成 Telegram 绑定

> `GET /api/oauth/telegram/bind/:flow_token`

- **鉴权**：无（通过 flow_token 关联到发起绑定时的会话）
- **用途**：Telegram Login Widget 回跳端点，校验签名并完成绑定，最终 302 重定向到前端。

## 请求

路径参数：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| flow_token | string | 由 `POST /api/oauth/telegram/bind/start` 返回 |

Query 参数（Telegram Login Widget 标准）：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| id | string | 是 | Telegram 用户 ID |
| hash | string | 是 | HMAC 签名 |
| auth_date | string | 是 | 授权时间（Unix 秒） |

## 响应

绑定成功：`302 Found`，重定向至 `/oauth/telegram?telegram_bind=success&flow_token=...`。

绑定失败：`302 Found`，重定向至 `/oauth/telegram?telegram_bind=error&flow_token=...&error_code=...`。

## 错误码

重定向 query 中的 `error_code`：

| error_code | 说明 |
| --- | --- |
| TELEGRAM_BIND_DISABLED | 管理员未开启 Telegram |
| TELEGRAM_BIND_INVALID_REQUEST | 签名/参数无效 |
| TELEGRAM_BIND_FLOW_INVALID | flow_token 无效/过期/已使用 |
| TELEGRAM_BIND_SESSION_INVALID | 关联会话已失效 |
| TELEGRAM_BIND_ALREADY_BOUND | 该 Telegram 账号已被绑定 |
| TELEGRAM_BIND_USER_DELETED | 用户已注销 |
| TELEGRAM_BIND_USER_DISABLED | 用户已被禁用 |
| TELEGRAM_BIND_INTERNAL_ERROR | 内部错误 |
