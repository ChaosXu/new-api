# 提交Suno任务
> `POST /suno/submit/:action`
- **鉴权**：TokenAuth + Distribute
- **用途**：提交 Suno 任务，`action` 取 `music`（生成歌曲）或 `lyrics`（生成歌词）。调度走 `RelayTask`。

## 请求
路径参数：

| 参数 | 位置 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- | --- |
| `action` | path | string | 是 | `music` / `lyrics` |

请求体（`dto.SunoSubmitReq`，按 action 取用）：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- | --- |
| `gpt_description_prompt` | string | music 常用 | 自然语言描述（描述模式生成歌曲） |
| `prompt` | string | lyrics / 自定义模式 | 歌词文本 |
| `mv` | string | 否 | 模型版本（如 `chirp-v3-5`） |
| `title` | string | 否 | 歌曲标题 |
| `tags` | string | 否 | 风格标签 |
| `make_instrumental` | bool | 否 | 是否纯音乐 |
| `continue_at` | float64 | 否 | 续写起始秒 |
| `continue_clip_id` | string | 否 | 续写源 clip ID |
| `task_id` | string | 否 | 指定任务 ID |

示例（music）：
```json
{ "gpt_description_prompt": "一首关于夏天的轻快流行歌", "mv": "chirp-v3-5", "make_instrumental": false }
```

## 响应
返回 `SunoDataResponse`：`{task_id, action, status, ...}`，详见 README「通用响应」。

## 错误
见 README 错误格式（`dto.TaskError`）。
