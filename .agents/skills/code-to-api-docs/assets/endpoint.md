# [端点标题，如：创建渠道]

> `[METHOD] [完整路径，如：POST /api/channel/]`

- **鉴权**：[鉴权类型，如：AdminAuth + RequirePermission(ChannelSensitiveWrite)]
- **用途**：[一句话说明这个端点做什么]

## 请求

[如果是 query 参数：]

| 参数 | 类型 | 必填 | 默认 | 说明 |
|---|---|---|---|---|
| [参数名] | [类型] | [是/否] | [默认值] | [含义] |

[如果是 request body：]

请求体（`[struct 名]`）：

| 字段 | json tag | 类型 | 必填 | 约束 | 说明 |
|---|---|---|---|---|---|
| [字段名] | `[json tag]` | [类型] | [是/否] | [validate 约束] | [含义] |

[如果无请求参数：]

无请求参数。

## 响应

[如果有统一信封：]

| 字段 | 类型 | 说明 |
|---|---|---|
| success | bool | `true` |
| message | string | `""` 或 i18n key |
| data | [data 类型] | [说明] |

`data` 字段（`[model struct 名]`）：

| 字段 | json tag | 类型 | 说明 |
|---|---|---|---|
| [字段名] | `[json tag]` | [类型] | [含义] |

示例：

```json
{
  "success": true,
  "message": "",
  "data": { ... }
}
```

[如果是非标准信封（原生协议/纯文本/自定义结构）：]

> **非标准信封**：返回 `[格式说明]`，不走统一 `{success, message, data}` 包装。

[示例 JSON]

[如果无响应 data：]

无 data，仅 `{success: true, message: ""}`。

## 错误码

[如果有 i18n MsgKey：]

| MsgKey | EN | ZH | 触发条件 |
|---|---|---|---|
| `[key]` | [英文文案] | [中文文案] | [何时触发] |

[如果有硬编码消息：]

| message | 触发条件 |
|---|---|
| `[字面消息]` | [何时触发] |

[如果无错误码：]

无特定错误码。失败时返回 DB 错误字符串。
