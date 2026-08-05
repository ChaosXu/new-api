# Action提交
> `POST /mj/submit/action`
- **鉴权**：TokenAuth + Distribute
- **用途**：通用按钮动作提交，根据传入的 `customId` 解析并路由到对应的变换/视频等动作，避免客户端逐一对接各 `submit/*` 端点。

## 请求
请求体 `dto.MidjourneyRequest`（核心字段）：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `customId` | string | 是 | 按钮 customId（用于推断 action） |
| `taskId` | string | 是 | 源任务 ID |
| `prompt` | string | 否 | 追加提示词 |
| `index` | int | 否 | 按钮序号 |
| `notifyHook` | string | 否 | 回调地址 |

## 响应
返回任务回执（同文生图）。具体动作由 customId 解析后决定。

## 错误
见 README 错误格式。
