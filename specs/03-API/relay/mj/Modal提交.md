# Modal提交
> `POST /mj/submit/modal`
- **鉴权**：TokenAuth + Distribute
- **用途**：提交 Midjourney Modal 表单（如 INPOOL 修图、Vary Region 等需要二次确认的操作）。

## 请求
请求体 `dto.MidjourneyRequest`：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `prompt` | string | 否 | Modal 内输入的提示词 |
| `maskBase64` | string | 否 | 区域掩码 Base64 |
| `customId` | string | 否 | 触发 Modal 的按钮 customId |
| `taskId` | string | 否 | 关联任务 ID |
| `notifyHook` | string | 否 | 回调地址 |

## 响应
返回任务回执（同文生图）。

## 错误
见 README 错误格式。
