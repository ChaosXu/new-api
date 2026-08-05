# Claude 对话
> `POST /v1/messages`
- **鉴权**：TokenAuth + ModelRequestRateLimit + Distribute
- **用途**：Anthropic Claude Messages API，RelayFormat=Claude。鉴权 header 可用 `x-api-key` + `anthropic-version`，或标准 `Authorization: Bearer sk-xxx`。

## 请求
遵循 Anthropic Messages 原生规范。核心字段：
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| model | string | 是 | 模型名 |
| system | any | 否 | 系统提示（字符串或内容块数组） |
| messages | array | 是 | 消息列表，元素含 `role`/`content` |
| max_tokens | uint | 否 | 最大输出 token |
| stop_sequences | array | 否 | 停止序列 |
| temperature | float | 否 | 采样温度 |
| top_p / top_k | float/int | 否 | 采样参数 |
| stream | bool | 否 | 是否流式（SSE） |
| tools | any | 否 | 工具列表（含普通工具与 web_search 工具） |
| tool_choice | any | 否 | 工具选择策略 |
| thinking | object | 否 | 扩展思考，含 `type`/`budget_tokens`/`display` |
| metadata | any | 否 | 元数据（含 `user_id`） |
| service_tier | string | 否 | 上游服务等级（默认过滤） |
| mcp_servers | any | 否 | MCP 服务器配置 |

消息 content 支持多模态块：`text` / `image` / `tool_use` / `tool_result`。

## 响应
遵循 Anthropic 原生规范。
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| id | string | 响应 ID |
| type | string | `message`（流式为 `message_start`/`content_block_delta` 等事件） |
| role | string | `assistant` |
| content | array | 内容块（`text`/`tool_use` 等） |
| model | string | 模型名 |
| stop_reason | string | 停止原因 |
| usage | object | `input_tokens`/`output_tokens` 及缓存字段（`cache_creation_input_tokens`/`cache_read_input_tokens`） |

流式时以 SSE 返回 Anthropic 事件序列。

## 错误
Claude 格式：
```json
{ "type": "error", "error": { "type": "invalid_request_error", "message": "..." } }
```
