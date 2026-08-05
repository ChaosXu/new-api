# OAuth 发现

> `POST /api/custom-oauth-provider/discovery`

- **鉴权**：RootAuth
- **用途**：后端代为获取 OIDC Discovery 文档（避免前端跨域），支持直接传入 well_known URL 或由 issuer URL 推导。

## 请求

请求体 JSON：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| well_known_url | string | 否 | 完整的 discovery 文档 URL（http/https） |
| issuer_url | string | 否 | issuer URL，将拼接 `/.well-known/openid-configuration` |

二者至少填一个；同时填写时以 `well_known_url` 为准。

## 响应

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| well_known_url | string | 实际请求的 discovery URL |
| discovery | object | OIDC discovery 文档原内容 |

```json
{
  "success": true,
  "message": "",
  "data": {
    "well_known_url": "https://example.com/.well-known/openid-configuration",
    "discovery": {
      "issuer": "https://example.com",
      "authorization_endpoint": "https://example.com/oauth2/authorize",
      "token_endpoint": "https://example.com/oauth2/token"
    }
  }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 200(success=false) | 参数缺失、URL 无效、获取/解析 discovery 失败、上游非 200 |
