# 查询 Passkey 状态

> `GET /api/user/passkey`

- **鉴权**：`UserAuth`
- **用途**：查询当前用户是否已绑定 Passkey 及最近使用时间。

> 注：该路由在 `selfRoute(UserAuth)` 下注册，实际路径为 `/api/user/passkey`（非 `/api/user/self/passkey`）。

## 请求

无参数。

## 响应

### 未绑定

```json
{ "success": true, "message": "", "data": { "enabled": false } }
```

### 已绑定

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | 空 |
| data.enabled | bool | `true` |
| data.last_used_at | int64/string | 最近一次使用时间 |

```json
{
  "success": true,
  "message": "",
  "data": { "enabled": true, "last_used_at": 1699999000 }
}
```

## 错误码

| 场景 | message |
|---|---|
| 未登录 | `未登录` |
| 用户被禁用 | `该用户已被禁用` |
