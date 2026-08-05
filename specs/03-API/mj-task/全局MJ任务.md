# 全局MJ任务
> `GET /api/mj/`
- **鉴权**：AdminAuth（管理员）
- **用途**：分页查询全局 Midjourney 任务。

## 请求
Query 参数：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| channel_id | string | 渠道 ID |
| mj_id | string | Midjourney 任务 ID |
| start_timestamp / end_timestamp | string | 时间范围 |
| p / page_size | int | 分页 |

## 响应
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| data | PageQuery | 分页对象，含 items 与 total |

示例：
```json
{ "success": true, "message": "", "data": { "total": 0, "items": [] } }
```

## 错误码
无
