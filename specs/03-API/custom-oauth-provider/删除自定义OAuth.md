# 删除自定义 OAuth

> `DELETE /api/custom-oauth-provider/:id`

- **鉴权**：RootAuth
- **用途**：删除自定义 OAuth 提供商；存在用户绑定时拒绝删除。

## 请求

路径参数：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| id | int | 提供商 ID |

## 响应

```json
{
  "success": true,
  "message": "删除成功"
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 200(success=false) | ID 无效、未找到、仍有用户绑定（需先解绑）、检查绑定时发生内部错误 |
