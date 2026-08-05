# Suno 中转端点

Suno 音乐/歌词任务型中转接口，路径前缀 `/suno`。鉴权统一 `TokenAuth + Distribute`，调度走 `RelayTask`（提交）与 `RelayTaskFetch`（查询），见 `controller/relay.go`。

## 鉴权
全部端点：`TokenAuth + Distribute`。

## 通用响应（SunoDataResponse）
任务提交/查询统一返回 `dto.SunoDataResponse`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `task_id` | string | 任务 ID |
| `action` | string | `music` / `lyrics` / `description-mode` |
| `status` | string | `submitted` / `queueing` / `processing` / `success` / `failed` |
| `fail_reason` | string | 失败原因 |
| `submit_time` / `start_time` / `finish_time` | int64 | 毫秒时间戳 |
| `data` | json | 结果载荷（`SunoSong[]` 或 `SunoLyrics`） |

### SunoSong 字段（`action=music` 的结果）
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `id` | string | 歌曲 ID |
| `video_url` | string | 视频 URL |
| `audio_url` | string | 音频 URL |
| `image_url` / `image_large_url` | string | 封面图 |
| `major_model_version` | string | 模型版本 |
| `model_name` | string | 模型名 |
| `status` | string | 单曲状态 |
| `title` | string | 标题 |
| `text` | string | 歌词文本 |
| `metadata` | object | `{tags, prompt, gpt_description_prompt, duration, ...}` |

## 端点列表

| 端点 | 方法 | 用途 | 文件 |
| --- | --- | --- | --- |
| `/suno/submit/:action` | POST | 提交 music / lyrics 任务 | [提交Suno任务.md](提交Suno任务.md) |
| `/suno/fetch` | POST | 批量查询 | [批量查询Suno.md](批量查询Suno.md) |
| `/suno/fetch/:id` | GET | 查询单任务 | [查询Suno任务.md](查询Suno任务.md) |

## 错误格式
任务型错误统一为 `dto.TaskError`：

```json
{ "code": "get_channel_failed", "message": "...", "statusCode": 500 }
```
HTTP 状态码取 `statusCode`。`429` 时 `message` 改写为「当前分组上游负载已饱和，请稍后再试」。
