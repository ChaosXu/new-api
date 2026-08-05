# 用户MJ任务
> `GET /api/mj/self`
- **鉴权**：UserAuth（用户登录态）
- **用途**：分页查询当前用户的 Midjourney 任务。

## 请求
Query 参数：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| mj_id | string | Midjourney 任务 ID |
| start_timestamp / end_timestamp | string | 时间范围 |
| p / page_size | int | 分页 |

## 响应
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| data | PageQuery | 分页对象，含 items（Midjourney 任务）与 total |

示例：
```json
{ "success": true, "message": "", "data": { "total": 0, "items": [] } }
```

## 错误码
无
