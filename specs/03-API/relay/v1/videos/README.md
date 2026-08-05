# 视频（OpenAI 兼容 sora）

OpenAI 兼容 Videos API（sora）。对齐 OpenAI Videos API 规范，含创建、查询、混剪与内容代理。

## 鉴权

- 创建/查询/混剪：`TokenAuth + Distribute`
- 内容代理 `/v1/videos/:task_id/content`：`TokenOrUserAuth`（接受会话登录或 API Token）

## 通用响应

同 `/v1/video/generations`，详见 [video](../video/) 的 VideoResponse / VideoTaskResponse。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
| --- | --- | --- | --- |
| [创建视频](./创建视频.md) | POST | `/v1/videos` | 创建视频（sora 兼容） |
| [查询视频](./查询视频.md) | GET | `/v1/videos/:task_id` | 查询视频任务 |
| [视频混剪](./视频混剪.md) | POST | `/v1/videos/:video_id/remix` | 视频混剪 |
| [视频内容代理](./视频内容代理.md) | GET | `/v1/videos/:task_id/content` | 内容代理下载（按渠道回源 + SSRF 校验） |

## 错误格式

- 提交/查询：`dto.TaskError`（同 video）
- 内容代理：OpenAI 风格 `{error:{message, type}}`
