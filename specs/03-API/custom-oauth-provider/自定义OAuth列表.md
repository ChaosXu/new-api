# 自定义 OAuth 列表

> `GET /api/custom-oauth-provider/`

- **鉴权**：RootAuth
- **用途**：返回所有自定义 OAuth 提供商（不含 client_secret）。

## 请求

无。

## 响应

返回数组，元素结构（`CustomOAuthProviderResponse`）：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| id | int | 提供商 ID |
| name | string | 名称 |
| slug | string | 标识 slug |
| icon | string | 图标 |
| enabled | bool | 是否启用 |
| client_id | string | 客户端 ID |
| authorization_endpoint | string | 授权端点 |
| token_endpoint | string | Token 端点 |
| user_info_endpoint | string | 用户信息端点 |
| scopes | string | 授权 scopes |
| user_id_field | string | 用户 ID 字段名 |
| username_field | string | 用户名字段名 |
| display_name_field | string | 显示名字段名 |
| email_field | string | 邮箱字段名 |
| well_known | string | discovery URL |
| auth_style | int | token 请求认证风格 |
| access_policy | string | 访问策略 |
| access_denied_message | string | 访问拒绝提示 |

```json
{
  "success": true,
  "message": "",
  "data": [ { "id": 1, "name": "My SSO", "slug": "my-sso", "enabled": true } ]
}
```

## 错误码

无。
