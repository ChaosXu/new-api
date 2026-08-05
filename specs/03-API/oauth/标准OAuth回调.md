# 标准 OAuth 回调

> `GET /api/oauth/:provider`

- **鉴权**：可选（TryUserAuth，绑定回调需要登录会话）
- **用途**：处理所有标准 OAuth 提供商的授权回调，校验 state、换取 token、获取用户信息并完成登录或绑定。

## 请求

路径参数：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| provider | string | OAuth 提供商标识 |

Query 参数：

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| state | string | 是 | 由 `POST /api/oauth/state` 返回的 flow_token |
| code | string | 是（登录） | 授权码（登录回调）；绑定回调由 handleOAuthBind 处理 |
| error | string | 否 | 提供商返回的错误码 |
| error_description | string | 否 | 提供商返回的错误描述 |

## 响应

登录成功后直接建立会话（setupLogin），返回当前用户信息；绑定流程返回：

```json
{
  "success": true,
  "message": "绑定成功",
  "data": {
    "action": "bind"
  }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 400 | 未知 provider |
| 403 | state 无效/已过期/已使用，或绑定会话不匹配 |
| 403 | 提供商未启用 |
| 200(success=false) | 邮箱已被占用、用户已注销、注册已关闭、用户被封禁等 |
