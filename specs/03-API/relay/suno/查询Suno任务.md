# 查询Suno任务
> `GET /suno/fetch/:id`
- **鉴权**：TokenAuth + Distribute
- **用途**：查询单个 Suno 任务状态，调度走 `RelayTaskFetch`。

## 请求
路径参数：

| 参数 | 位置 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- | --- |
| `id` | path | string | 是 | task_id |

## 响应
返回 `SunoDataResponse`，字段见 README「通用响应」。状态：`submitted` / `queueing` / `processing` / `success` / `failed`。

## 错误
见 README 错误格式。
