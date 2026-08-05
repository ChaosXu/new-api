# vendors 供应商端点（管理员）

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/vendors/` | GET | AdminAuth | 分页获取供应商 | [供应商列表.md](供应商列表.md) |
| `/api/vendors/search` | GET | AdminAuth | 搜索供应商 | [搜索供应商.md](搜索供应商.md) |
| `/api/vendors/:id` | GET | AdminAuth | 获取供应商详情 | [获取供应商.md](获取供应商.md) |
| `/api/vendors/` | POST | AdminAuth | 创建供应商 | [创建供应商.md](创建供应商.md) |
| `/api/vendors/` | PUT | AdminAuth | 更新供应商 | [更新供应商.md](更新供应商.md) |
| `/api/vendors/:id` | DELETE | AdminAuth | 删除供应商 | [删除供应商.md](删除供应商.md) |
