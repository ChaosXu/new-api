# 微调端点（全部未实现）

OpenAI Fine-tunes API 占位端点，**当前全部返回 501 Not Implemented**。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1/fine-tunes` | POST | TokenAuth | 创建微调（未实现） | [创建微调.md](创建微调.md) |
| `/v1/fine-tunes` | GET | TokenAuth | 微调列表（未实现） | [微调列表.md](微调列表.md) |
| `/v1/fine-tunes/:id` | GET | TokenAuth | 微调详情（未实现） | [微调详情.md](微调详情.md) |
| `/v1/fine-tunes/:id/cancel` | POST | TokenAuth | 取消微调（未实现） | [取消微调.md](取消微调.md) |
| `/v1/fine-tunes/:id/events` | GET | TokenAuth | 微调事件（未实现） | [微调事件.md](微调事件.md) |

## 网关特殊行为
- **未实现**：全部端点由 `RelayNotImplemented` 处理，固定返回 HTTP 501 与 OpenAI 错误体。
- **无计费/无重试/无转发**。
