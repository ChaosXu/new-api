# 创建自定义 OAuth

> `POST /api/custom-oauth-provider/`

- **鉴权**：RootAuth
- **用途**：新建一个自定义 OAuth 提供商并注册到 OAuth 注册表。

## 请求

请求体 JSON（`CreateCustomOAuthProviderRequest`）：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| name | string | 是 | 名称 |
| slug | string | 是 | 标识 slug（不能与已存在或内置冲突） |
| icon | string | 否 | 图标 |
| enabled | bool | 否 | 是否启用 |
| client_id | string | 是 | 客户端 ID |
| client_secret | string | 是 | 客户端密钥 |
| authorization_endpoint | string | 是 | 授权端点 |
| token_endpoint | string | 是 | Token 端点 |
| user_info_endpoint | string | 是 | 用户信息端点 |
| scopes | string | 否 | 授权 scopes |
| user_id_field | string | 否 | 用户 ID 字段名 |
| username_field | string | 否 | 用户名字段名 |
| display_name_field | string | 否 | 显示名字段名 |
| email_field | string | 否 | 邮箱字段名 |
| well_known | string | 否 | discovery URL |
| auth_style | int | 否 | token 认证风格 |
| access_policy | string | 否 | 访问策略 |
| access_denied_message | string | 否 | 访问拒绝提示 |

## 响应

返回新建的 `CustomOAuthProviderResponse`。

```json
{
  "success": true,
  "message": "创建成功",
  "data": { "id": 2, "name": "New SSO", "slug": "new-sso", "enabled": false }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 200(success=false) | 参数无效、slug 已被使用、slug 与内置提供商冲突 |
