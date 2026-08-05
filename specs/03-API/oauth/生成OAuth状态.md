# 生成 OAuth 状态

> `POST /api/oauth/state`

- **鉴权**：可选（TryUserAuth，绑定意图需要已登录会话）
- **用途**：为标准 OAuth 登录或绑定流程生成一个 flow_token（同时作为 OAuth state 用于 CSRF 防护）。

## 请求

请求体 JSON：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| provider | string | 是 | OAuth 提供商标识（需为已注册的 provider） |
| intent | string | 是 | 流程意图：`login` 登录 / `bind` 绑定 |
| aff | string | 否 | 邀请/推广码，最长 32 字符；`bind` 意图下必须为空 |

## 响应

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| flow_token | string | OAuth state/流程令牌，回调时回传 |
| expires_at | int64 | 过期时间（Unix 秒），有效期 10 分钟 |

```json
{
  "success": true,
  "message": "",
  "data": {
    "flow_token": "abc123...",
    "expires_at": 1700000000
  }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 400 | 参数无效（provider 不存在、intent 非法、aff 过长、bind 意图带 aff） |
| 401 | 绑定操作需要登录 |
