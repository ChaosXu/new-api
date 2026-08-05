# 按Key查询日志
> `GET /api/log/token`
- **鉴权**：TokenAuthReadOnly（令牌只读鉴权）+ CORS + CriticalRateLimit
- **用途**：使用令牌鉴权查询该令牌的日志。

## 请求
无（鉴权后从 token_id 获取所属令牌）

## 响应
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| data | Log[] | 该令牌的日志列表 |

示例：
```json
{ "success": true, "message": "", "data": [] }
```

## 错误码
| HTTP | message | 说明 |
| --- | --- | --- |
| 200 | 无效的令牌 | token_id 为 0 |
| 200 | （错误信息） | 查询失败 |
