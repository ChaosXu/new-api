# Gemini 原生接口
> `POST /v1beta/models/*path`
- **鉴权**：TokenAuth + ModelRequestRateLimit + Distribute
- **用途**：Gemini 原生 API 透传，路径格式 `{model}:{action}`（如 `gemini-pro:generateContent`），RelayFormat=Gemini。

## 请求
遵循 Gemini 原生规范。路径形如 `/v1beta/models/<model>:<action>`，action 如 `generateContent`/`streamGenerateContent`。核心 body 字段：
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| contents | array | 是 | 会话内容（parts 含 text/inline_data 等） |
| systemInstruction | object | 否 | 系统指令 |
| generationConfig | object | 否 | 生成配置（temperature/topP/maxOutputTokens 等） |
| safetySettings | array | 否 | 安全设置 |
| tools | array | 否 | 工具（functionDeclarations/googleSearch 等） |

路径含 `embed` 时走 Gemini 嵌入处理器。

## 响应
遵循 Gemini 原生规范。
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| candidates | array | 候选项，含 `content`/`finishReason`/`safetyRatings` |
| usageMetadata | object | `promptTokenCount`/`candidatesTokenCount`/`totalTokenCount` |
| modelVersion | string | 模型版本 |

`streamGenerateContent` 时以 SSE/分块 JSON 返回。

## 错误
Gemini 原生错误格式（被网关归一化后通常以原生 JSON 返回）。
