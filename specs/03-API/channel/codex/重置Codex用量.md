# 重置 Codex 用量

> `POST /api/channel/:id/codex/usage/reset`

- **鉴权**：AdminAuth + RequirePermission(ChannelOperate)
- **用途**：消耗一次重置额度，重置 Codex 渠道的用量。

## 请求

路径参数：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| id | int | 渠道 ID（需为 Codex 类型，且非多密钥） |

## 响应

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| upstream_status | int | 上游 HTTP 状态码 |
| data | any | 上游返回结果 |

```json
{
  "success": true,
  "message": "",
  "upstream_status": 200,
  "data": { "ok": true }
}
```

## 错误码

| 状态 | 说明 |
| --- | --- |
| 200(success=false) | 渠道不存在、非 Codex 类型、多密钥不支持、凭证缺失、重置用量失败 |
