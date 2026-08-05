# 更新自定义 OAuth

> `PUT /api/custom-oauth-provider/:id`

- **鉴权**：RootAuth
- **用途**：更新已存在的自定义 OAuth 提供商；指针类型字段为 nil 时保留原值。

## 请求

路径参数：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| id | int | 提供商 ID |

请求体 JSON（`UpdateCustomOAuthProviderRequest`，字段均可选）：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| name | string | 名称 |
| slug | string | 新 slug（变更时校验唯一与内置冲突） |
| icon | *string | 图标（nil 保留） |
| enabled | *bool | 启用状态（nil 保留） |
| client_id | string | 客户端 ID |
| client_secret | string | 客户端密钥（空保留） |
| authorization_endpoint | string | 授权端点 |
| token_endpoint | string | Token 端点 |
| user_info_endpoint | string | 用户信息端点 |
| scopes | string | 授权 scopes |
| user_id_field | string | 用户 ID 字段名 |
| username_field | string | 用户名字段名 |
| display_name_field | string | 显示名字段名 |
| email_field | string | 邮箱字段名 |
| well_known | *string | discovery URL（nil 保留） |
| auth_style | *int | token 认证风格（nil 保留） |
| access_policy | *string | 访问策略（nil 保留） |
| access_denied_message | *string | 访问拒绝提示（nil 保留） |

## 响应

返回更新后的 `CustomOAuthProviderResponse`。

```json
{
  "success": true,
  "message": "更新成功",
  "data": { "id": 2, "name": "Renamed", "slug": "new-sso", "enabled": true }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 200(success=false) | ID 无效、未找到、slug 已被使用或与内置冲突 |
