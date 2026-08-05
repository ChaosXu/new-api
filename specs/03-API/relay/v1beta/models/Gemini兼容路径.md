# Gemini 兼容路径
> `POST /v1/models/*path`
- **鉴权**：TokenAuth + ModelRequestRateLimit + Distribute
- **用途**：以 OpenAI 路径风格调用 Gemini（路径 `/v1/models/*path`），RelayFormat=Gemini。供部分 OpenAI 客户端通过该路径访问 Gemini 渠道。

## 请求
路径 `/v1/models/<path>`，由渠道适配层转发到 Gemini 原生端点。body 遵循 Gemini 原生规范（`contents`/`systemInstruction`/`generationConfig`/`tools` 等）。路径含 `embed` 时走嵌入处理器。

## 响应
遵循 Gemini 原生规范：`candidates`/`usageMetadata`/`modelVersion`。流式 `streamGenerateContent` 时分块返回。

## 错误
Gemini 原生错误格式（被网关归一化后通常以原生 JSON 返回）。
