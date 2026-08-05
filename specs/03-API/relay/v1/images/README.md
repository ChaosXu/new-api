# 图像端点

OpenAI 兼容图像生成/编辑接口。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1/images/generations` | POST | TokenAuth + ModelRequestRateLimit + Distribute | 图像生成 | [图像生成.md](图像生成.md) |
| `/v1/images/edits` | POST | TokenAuth + ModelRequestRateLimit + Distribute | 图像编辑（multipart） | [图像编辑.md](图像编辑.md) |
| `/v1/edits` | POST | TokenAuth + ModelRequestRateLimit + Distribute | 图像编辑别名 | [图像编辑别名.md](图像编辑别名.md) |
| `/v1/images/variations` | POST | TokenAuth + ModelRequestRateLimit + Distribute | 图像变体（**未实现**，501） | [图像变体.md](图像变体.md) |

## 网关特殊行为
- **不走统一响应信封**：使用 OpenAI 原生协议。
- **预扣计费**：按固定单价 + 尺寸/质量倍率 + 数量 `n`（上限 128）预扣，失败退还。
- **多渠道重试**：可重试错误触发渠道切换。
- **流式**：`stream=true`（部分模型）支持流式返回。
- **未实现接口**：`/v1/images/variations` 固定返回 501。
