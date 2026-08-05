# 可灵视频中转端点

可灵（Kling）官方 API 风格的视频中转接口，路径前缀 `/kling/v1`。鉴权链为 `KlingRequestConvert + TokenAuth + Distribute`。

## 适配机制
`middleware.KlingRequestConvert()`（`middleware/kling_adapter.go`）在请求进入 TokenAuth/Distribute 之前完成转换：

1. 读取原始请求体，取 `model_name`（或 `model`）与 `prompt`。
2. 重写为统一入参 `{model, prompt, metadata: <原始请求>}`。
3. 将请求路径重写为 `/v1/video/generations`，由 `RelayTask` 走统一视频流程。
4. 若原始请求无 `image`，设置 `action = TaskActionTextGenerate`（文生视频）；有 `image` 即图生视频。

因此响应字段同 `relay-video`：提交返回 `VideoResponse{task_id, status}`，查询返回 `VideoTaskResponse{task_id, status, url, format, metadata, error}`。

## 端点列表

| 端点 | 方法 | 用途 | 文件 |
| --- | --- | --- | --- |
| `/kling/v1/videos/text2video` | POST | 可灵文生视频 | [可灵文生视频.md](可灵文生视频.md) |
| `/kling/v1/videos/image2video` | POST | 可灵图生视频 | [可灵图生视频.md](可灵图生视频.md) |
| `/kling/v1/videos/text2video/:task_id` | GET | 查询文生视频任务 | [查询可灵文生视频.md](查询可灵文生视频.md) |
| `/kling/v1/videos/image2video/:task_id` | GET | 查询图生视频任务 | [查询可灵图生视频.md](查询可灵图生视频.md) |

## 错误格式
任务型错误统一为 `dto.TaskError`：
```json
{ "code": "get_channel_failed", "message": "...", "statusCode": 500 }
```
转换阶段（如请求体非法）的失败由 `TokenAuth` 前的适配器返回 OpenAI 风格错误。
