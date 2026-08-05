# Ollama 渠道管理

路由前缀：`/api/channel/ollama`（AdminAuth，全部 ChannelSensitiveWrite）。用于 Ollama 类型渠道的模型拉取、删除与版本查询。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
| --- | --- | --- | --- |
| Ollama拉取模型.md | POST | /api/channel/ollama/pull | 拉取模型（阻塞） |
| Ollama流式拉取.md | POST | /api/channel/ollama/pull/stream | SSE 流式拉取 |
| Ollama删除模型.md | DELETE | /api/channel/ollama/delete | 删除模型 |
| Ollama版本查询.md | GET | /api/channel/ollama/version/:id | 查询 Ollama 版本 |
