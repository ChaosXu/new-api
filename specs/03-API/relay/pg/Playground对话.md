# Playground 对话
> `POST /pg/chat/completions`
- **鉴权**：UserAuth（用户登录态）+ Distribute（**非** TokenAuth）
- **用途**：在线 Playground 对话补全，复用 `/v1/chat/completions` 流程。可通过请求体 `group` 切换计费分组，仍按所选分组计费。

## 请求
遵循 OpenAI Chat Completions 原生规范（RelayFormat=OpenAI）。核心字段：
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| model | string | 是 | 模型名 |
| messages | array | 是 | 消息列表 |
| stream | bool | 否 | 是否流式（SSE） |
| group | string | 否 | 指定计费分组（覆盖默认分组） |
| max_tokens / max_completion_tokens | uint | 否 | 最大输出 token |
| temperature / top_p | float | 否 | 采样参数 |
| tools / tool_choice | any | 否 | 工具调用 |

> 不支持使用 access token；必须使用用户登录态 cookie。

## 响应
遵循 OpenAI 原生规范（同 `/v1/chat/completions`）。
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| id | string | 响应 ID |
| choices | array | 含 `message`/`delta`、`finish_reason` |
| usage | object | `prompt_tokens`/`completion_tokens`/`total_tokens` |

流式时以 SSE 逐块返回。

## 错误
```json
{ "error": { "message": "...", "type": "invalid_request_error", "param": "", "code": "..." } }
```
access token 调用时返回错误：`暂不支持使用 access token`。
