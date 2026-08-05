# 音频端点

OpenAI 兼容音频转写/翻译/合成接口。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1/audio/transcriptions` | POST | TokenAuth + ModelRequestRateLimit + Distribute | 语音转文字（默认 whisper-1） | [语音转文字.md](语音转文字.md) |
| `/v1/audio/translations` | POST | TokenAuth + ModelRequestRateLimit + Distribute | 语音翻译 | [语音翻译.md](语音翻译.md) |
| `/v1/audio/speech` | POST | TokenAuth + ModelRequestRateLimit + Distribute | 文字转语音（默认 tts-1） | [文字转语音.md](文字转语音.md) |

## 网关特殊行为
- **不走统一响应信封**：使用 OpenAI 原生协议（speech 直接返回音频流）。
- **预扣计费**：按输入字符/token 估算预扣（speech 按文本长度，transcription/translation 按音频时长相关 token），失败退还，成功按实际 usage 结算。
- **多渠道重试**：可重试错误触发渠道切换。
- **默认模型**：transcriptions/translations 默认 `whisper-1`，speech 默认 `tts-1`。
- **流式 SSE**：speech 在 `stream_format=sse` 时以事件流返回。
