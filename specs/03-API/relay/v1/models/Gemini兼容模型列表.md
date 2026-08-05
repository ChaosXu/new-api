# Gemini 兼容模型列表
> `GET /v1beta/openai/models`
- **鉴权**：TokenAuth（API 令牌 sk-xxx）
- **用途**：以 OpenAI 兼容格式列出当前可用模型（供 Gemini OpenAI 兼容客户端使用）。

## 请求
无请求体。鉴权使用 `Authorization: Bearer sk-xxx`。

## 响应
遵循 OpenAI 原生规范：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| object | string | 固定 `list` |
| data | array | 模型对象列表，元素含 `id` / `object`=`model` / `owned_by` |

## 错误
```json
{ "error": { "message": "...", "type": "...", "code": "..." } }
```
