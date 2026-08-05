# 管理员重置用户 Passkey

> `DELETE /api/user/:id/reset_passkey`

- **鉴权**：`AdminAuth`（管理员）
- **用途**：管理员强制重置指定用户的 Passkey，同时吊销该用户所有会话。不可操作同级或更高权限用户。

## 请求

Path：

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| id | int | 是 | 目标用户 ID |

## 响应

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | `Passkey 已重置` |

```json
{ "success": true, "message": "Passkey 已重置" }
```

## 错误码

| 场景 | message |
|---|---|
| 用户 ID 非法 | `无效的用户 ID` |
| 无权操作（同级/更高） | `no permission` |
| 用户未绑定 Passkey | `该用户尚未绑定 Passkey` |
