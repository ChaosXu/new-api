# 即梦中转端点

即梦（Jimeng / 火山引擎）官方 API 风格的视频中转接口，路径 `POST /jimeng/`。鉴权链为 `JimengRequestConvert + TokenAuth + Distribute`。

## 适配机制
`middleware.JimengRequestConvert()`（`middleware/jimeng_adapter.go`）通过 query `Action` 区分提交与查询，并转换为统一流程：

| Action | 含义 | 转换结果 |
| --- | --- | --- |
| `CVSync2AsyncSubmitTask` | 提交异步任务 | 路径重写为 `/v1/video/generations`，POST |
| `CVSync2AsyncGetResult` | 查询任务结果 | 路径重写为 `/v1/video/generations/<task_id>`，方法改 GET |

转换逻辑：
1. 读取 `req_key` 作为 `model`，`prompt` 作为 `prompt`，原始请求体整体放入 `metadata`。
2. 提交时若原始请求无 `image`，设置 `action = TaskActionTextGenerate`。
3. 查询时从请求体取 `task_id`，缺失则返回 400。

因此响应字段同 `relay-video`（提交 `VideoResponse{task_id, status}`，查询 `VideoTaskResponse{...}`）。

## 鉴权
`JimengRequestConvert + TokenAuth + Distribute`，最终走 `RelayTask` / `RelayTaskFetch`。

## 端点列表

| 端点 | 方法 | 用途 | 文件 |
| --- | --- | --- | --- |
| `/jimeng/?Action=CVSync2AsyncSubmitTask` | POST | 提交即梦任务 | [即梦任务.md](即梦任务.md) |
| `/jimeng/?Action=CVSync2AsyncGetResult` | POST（被适配为 GET） | 查询即梦任务结果 | [即梦任务.md](即梦任务.md) |

## 错误格式
- 适配器阶段（Action 缺失 / body 非法 / task_id 缺失）返回 OpenAI 风格错误。
- 任务阶段错误为 `dto.TaskError`：`{code, message, statusCode}`。
