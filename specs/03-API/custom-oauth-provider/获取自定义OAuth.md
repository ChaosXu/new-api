# 获取自定义 OAuth

> `GET /api/custom-oauth-provider/:id`

- **鉴权**：RootAuth
- **用途**：按 ID 获取单个自定义 OAuth 提供商详情。

## 请求

路径参数：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| id | int | 提供商 ID |

## 响应

返回单个 `CustomOAuthProviderResponse`（结构同「自定义 OAuth 列表」元素）。

```json
{
  "success": true,
  "message": "",
  "data": { "id": 1, "name": "My SSO", "slug": "my-sso", "enabled": true }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 200(success=false) | ID 无效、未找到该 OAuth 提供商 |
