# Gemini 引擎嵌入
> `POST /v1/engines/:model/embeddings`
- **鉴权**：TokenAuth + ModelRequestRateLimit + Distribute
- **用途**：以 OpenAI 引擎风格路径调用 Gemini 嵌入，RelayFormat=Gemini。

## 请求
Path 参数：
| 参数 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| model | string | 是 | 模型名（嵌入模型） |

遵循 OpenAI Embeddings 兼容 body：
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| model | string | 是 | 模型名 |
| input | any | 是 | 字符串或字符串数组 |
| encoding_format | string | 否 | 编码格式 |
| dimensions | int | 否 | 维度 |

## 响应
遵循 OpenAI Embeddings 兼容格式：`{object:"list", data:[{object:"embedding", index, embedding}], model, usage}`。

## 错误
```json
{ "error": { "message": "...", "type": "invalid_request_error", "param": "", "code": "..." } }
```
