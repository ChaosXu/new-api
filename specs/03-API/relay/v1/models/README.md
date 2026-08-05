# 模型列表端点

网关模型列表/详情接口，按请求头自动分流为 OpenAI / Anthropic / Gemini 协议。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1/models` | GET | TokenAuth | 模型列表（按 header 分流） | [模型列表.md](模型列表.md) |
| `/v1/models/:model` | GET | TokenAuth | 获取模型详情 | [获取模型详情.md](获取模型详情.md) |
| `/v1beta/models` | GET | TokenAuth | Gemini 原生模型列表 | [Gemini模型列表.md](Gemini模型列表.md) |
| `/v1beta/openai/models` | GET | TokenAuth | Gemini 兼容(OpenAI)模型列表 | [Gemini兼容模型列表.md](Gemini兼容模型列表.md) |

## 网关特殊行为
- **不走统一响应信封**：返回上游/对应协议的原生格式。
- **按请求头分流**：`x-api-key` + `anthropic-version` 走 Anthropic；`x-goog-api-key`/`key` 走 Gemini；默认 OpenAI。
- **模型过滤**：仅返回当前分组启用、已配置计费、且令牌模型限制允许的模型。
- **无预扣计费/无重试/无流式**：列表类接口不涉及计费与渠道转发。
