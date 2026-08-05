# Responses 压缩
> `POST /v1/responses/compact`
- **鉴权**：TokenAuth + ModelRequestRateLimit + Distribute
- **用途**：Codex 上下文压缩接口，RelayFormat=OpenAIResponsesCompaction。模型名会自动追加 `-openai-compact` 后缀路由到压缩计费变体。

## 请求
遵循 Codex compact 请求规范。核心字段：
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| model | string | 是 | 模型名（网关追加 `-openai-compact` 后缀） |
| input | any | 否 | 待压缩的输入内容 |
| instructions | any | 否 | 指令 |
| previous_response_id | string | 否 | 上一响应 ID |
| tools | any | 否 | 工具列表 |
| parallel_tool_calls | any | 否 | 并行工具调用 |
| reasoning | object | 否 | 推理配置 |
| service_tier | string | 否 | 服务等级（默认过滤） |
| text | any | 否 | 文本配置 |
| prompt_cache_key / prompt_cache_options / prompt_cache_retention | any | 否 | 缓存配置 |

## 响应
遵循 Codex compact 响应规范。
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| usage | object | `input_tokens`/`output_tokens`/`total_tokens` 及 `input_tokens_details`（含 cached_tokens/cache_write_tokens） |

## 错误
```json
{ "error": { "message": "...", "type": "...", "param": "", "code": "..." } }
```
