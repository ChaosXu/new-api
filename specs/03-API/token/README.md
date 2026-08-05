# token 令牌端点

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/token/` | GET | UserAuth | 分页获取令牌列表 | [令牌列表.md](令牌列表.md) |
| `/api/token/search` | GET | UserAuth + SearchRateLimit | 搜索令牌 | [搜索令牌.md](搜索令牌.md) |
| `/api/token/auto-groups` | GET | UserAuth | 获取自动分组候选 | [自动分组选项.md](自动分组选项.md) |
| `/api/token/:id` | GET | UserAuth | 获取令牌详情 | [获取令牌.md](获取令牌.md) |
| `/api/token/:id/key` | POST | UserAuth + CriticalRateLimit | 获取令牌明文 Key | [获取令牌明文.md](获取令牌明文.md) |
| `/api/token/` | POST | UserAuth | 创建令牌 | [创建令牌.md](创建令牌.md) |
| `/api/token/` | PUT | UserAuth | 更新令牌（支持 status_only） | [更新令牌.md](更新令牌.md) |
| `/api/token/:id` | DELETE | UserAuth | 删除令牌 | [删除令牌.md](删除令牌.md) |
| `/api/token/batch` | POST | UserAuth | 批量删除令牌 | [批量删除令牌.md](批量删除令牌.md) |
| `/api/token/batch/keys` | POST | UserAuth + CriticalRateLimit | 批量获取令牌明文（≤100） | [批量获取令牌明文.md](批量获取令牌明文.md) |
