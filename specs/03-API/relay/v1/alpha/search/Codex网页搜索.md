# Codex 网页搜索
> `POST /v1/alpha/search`
- **鉴权**：TokenAuth + ModelRequestRateLimit + Distribute
- **用途**：Codex 独立的网页搜索接口，原始请求体透传，RelayFormat=OpenAIAlphaSearch。

## 请求
请求体原样透传（RawBody 保留未知字段）。核心字段：
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| model | string | 是 | 模型名 |
| id | string | 否 | 请求 ID |
| stream | bool | 否 | 是否流式 |

其余字段按 Codex 网页搜索规范原样转发；网关额外注入内置工具 `web_search_preview` 的用量统计。

## 响应
遵循 Codex 网页搜索原生响应格式；usage 含 input/output tokens 及内置工具调用计数。

## 错误
```json
{ "error": { "message": "...", "type": "...", "param": "", "code": "..." } }
```
