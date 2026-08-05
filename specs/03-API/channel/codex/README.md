# Codex 渠道用量与凭证

路由前缀：`/api/channel/:id/codex`（AdminAuth，细分权限位）。用于 Codex 类型渠道的凭证刷新与用量管理。

## 端点清单

| 文件 | 方法 | 路径 | 权限 | 用途 |
| --- | --- | --- | --- | --- |
| 刷新Codex凭证.md | POST | /api/channel/:id/codex/refresh | ChannelSensitiveWrite | 刷新 OAuth 凭证 |
| 查询Codex用量.md | GET | /api/channel/:id/codex/usage | ChannelRead | 查询上游用量 |
| 查询Codex重置额度.md | GET | /api/channel/:id/codex/usage/reset-credits | ChannelRead | 查询可用重置额度 |
| 重置Codex用量.md | POST | /api/channel/:id/codex/usage/reset | ChannelOperate | 消耗额度重置用量 |
