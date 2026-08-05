# Gemini 模型列表
> `GET /v1beta/models`
- **鉴权**：TokenAuth（API 令牌 sk-xxx）
- **用途**：以 Gemini 原生协议列出当前可用模型。

## 请求
无请求体。鉴权使用 `Authorization: Bearer sk-xxx` 或 `x-goog-api-key` / query `key`。

## 响应
遵循 Gemini 原生规范：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| models | array | 模型对象列表 |

模型对象核心字段：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| name | string | 形如 `models/xxx` |
| version | string | 版本 |
| displayName | string | 展示名 |
| description | string | 描述 |
| inputTokenLimit | int | 输入 token 上限 |
| outputTokenLimit | int | 输出 token 上限 |
| supportedGenerationMethods | array | 支持的动作（generateContent 等） |

## 错误
Gemini 原生错误格式（被网关归一化后通常以 OpenAI/原生 JSON 返回）。
