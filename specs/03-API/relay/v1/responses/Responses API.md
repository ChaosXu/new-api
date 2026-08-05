# Responses API
> `POST /v1/responses`
- **鉴权**：TokenAuth + ModelRequestRateLimit + Distribute
- **用途**：OpenAI Responses API（事件驱动），RelayFormat=OpenAIResponses。

## 请求
遵循 OpenAI Responses 原生规范。核心字段：
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| model | string | 是 | 模型名 |
| input | any | 否 | 字符串或输入项数组（`input_text`/`input_image`/`input_file`） |
| instructions | any | 否 | 系统指令 |
| max_output_tokens | uint | 否 | 最大输出 token |
| stream | bool | 否 | 是否流式（SSE） |
| stream_options | object | 否 | 含 `include_usage`/`include_obfuscation` |
| temperature | float | 否 | 采样温度 |
| top_p | float | 否 | nucleus 采样 |
| tools | any | 否 | 工具列表（function/MCP/web_search 等） |
| tool_choice | any | 否 | 工具选择策略 |
| parallel_tool_calls | any | 否 | 并行工具调用 |
| reasoning | object | 否 | 含 `effort`/`summary`/`mode`/`context` |
| previous_response_id | string | 否 | 上一响应 ID（会话延续） |
| store | any | 否 | 是否存储（默认透传） |
| service_tier | string | 否 | 服务等级（默认过滤） |
| truncation | any | 否 | 截断策略 |
| metadata | any | 否 | 元数据 |
| include | any | 否 | 包含项 |
| user | any | 否 | 用户标识 |

## 响应
遵循 OpenAI Responses 原生规范。
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| id | string | 响应 ID |
| object | string | `response` |
| status | string | 状态 |
| output | array | 输出项（message/function_call/reasoning 等） |
| usage | object | `input_tokens`/`output_tokens`/`total_tokens` 及 `input_tokens_details` |

流式时以 SSE 返回 `response.created`/`response.output_item.*`/`response.completed` 等事件。

## 错误
```json
{ "error": { "message": "...", "type": "invalid_request_error", "param": "", "code": "..." } }
```
