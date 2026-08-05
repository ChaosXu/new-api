# 文件端点（全部未实现）

OpenAI Files API 占位端点，**当前全部返回 501 Not Implemented**。

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/v1/files` | GET | TokenAuth | 文件列表（未实现） | [文件列表.md](文件列表.md) |
| `/v1/files` | POST | TokenAuth | 上传文件（未实现） | [上传文件.md](上传文件.md) |
| `/v1/files/:id` | DELETE | TokenAuth | 删除文件（未实现） | [删除文件.md](删除文件.md) |
| `/v1/files/:id` | GET | TokenAuth | 获取文件（未实现） | [获取文件.md](获取文件.md) |
| `/v1/files/:id/content` | GET | TokenAuth | 获取文件内容（未实现） | [获取文件内容.md](获取文件内容.md) |

## 网关特殊行为
- **未实现**：全部端点由 `RelayNotImplemented` 处理，固定返回 HTTP 501 与 OpenAI 错误体 `{error:{message:"API not implemented",type:"new_api_error",code:"api_not_implemented"}}`。
- **无计费/无重试/无转发**。
