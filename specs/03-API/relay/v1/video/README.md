# 视频生成（统一接口）

统一视频生成中转接口（`/v1/video/generations`）。跨厂商统一入参（`dto.VideoRequest`），由渠道分发到具体上游。任务调度走 `RelayTask` / `RelayTaskFetch`（`controller/relay.go`）。

## 鉴权

`TokenAuth + Distribute`

## 通用提交响应（VideoResponse）

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `task_id` | string | 任务 ID |
| `status` | string | 提交状态 |

## 通用查询响应（VideoTaskResponse）

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `task_id` | string | 任务 ID |
| `status` | string | `succeeded` / `processing` / `failed` 等 |
| `url` | string | 视频资源 URL（成功时） |
| `format` | string | 视频格式（如 `mp4`） |
| `metadata` | object | `{duration, fps, width, height, seed}` |
| `error` | object | `{code, message}`（失败时） |

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
| --- | --- | --- | --- |
| [视频生成](./视频生成.md) | POST | `/v1/video/generations` | 视频生成（统一入参） |
| [查询视频任务](./查询视频任务.md) | GET | `/v1/video/generations/:task_id` | 查询任务 |

## 错误格式

任务型错误统一为 `dto.TaskError`：

```json
{ "code": "get_channel_failed", "message": "...", "statusCode": 500 }
```
