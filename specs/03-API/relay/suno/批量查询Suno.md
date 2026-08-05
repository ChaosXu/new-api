# 批量查询Suno
> `POST /suno/fetch`
- **鉴权**：TokenAuth + Distribute
- **用途**：批量查询 Suno 任务状态，调度走 `RelayTaskFetch`。

## 请求
请求体（任务 ID 列表）：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `ids` | []string | 是 | 待查询的 task_id 列表 |

示例：
```json
{ "ids": ["abc123", "def456"] }
```

## 响应
返回 `SunoDataResponse` 数组，字段见 README「通用响应」。完成后 `data` 含 `SunoSong[]`。

## 错误
见 README 错误格式。
