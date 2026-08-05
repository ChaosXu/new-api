# Telegram 登录

> `GET /api/oauth/telegram/login`

- **鉴权**：无
- **用途**：处理 Telegram Login Widget 回调，校验 HMAC 签名后完成登录或注册。

## 请求

Query 参数（Telegram Login Widget 标准参数）：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| id | string | 是 | Telegram 用户 ID |
| hash | string | 是 | HMAC 签名 |
| auth_date | string | 是 | 授权时间（Unix 秒） |
| first_name / last_name / username / photo_url | string | 否 | 其他 widget 字段 |

签名有效期 5 分钟，断言一次性消费（防重放）。

## 响应

校验通过后建立会话，返回当前用户信息。

```json
{
  "success": true,
  "message": "",
  "data": { }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 200(success=false) | 管理员未开启 Telegram 登录、参数无效/签名无效 |
| 403 | 该登录凭据已被使用（断言重放） |
