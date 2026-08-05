# redemption 兑换码端点（管理员）

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/redemption/` | GET | AdminAuth | 分页获取兑换码列表 | [兑换码列表.md](兑换码列表.md) |
| `/api/redemption/search` | GET | AdminAuth | 搜索兑换码 | [搜索兑换码.md](搜索兑换码.md) |
| `/api/redemption/:id` | GET | AdminAuth | 获取兑换码详情 | [获取兑换码.md](获取兑换码.md) |
| `/api/redemption/` | POST | AdminAuth | 批量生成兑换码（需合规） | [生成兑换码.md](生成兑换码.md) |
| `/api/redemption/` | PUT | AdminAuth | 更新兑换码（支持 status_only） | [更新兑换码.md](更新兑换码.md) |
| `/api/redemption/invalid` | DELETE | AdminAuth | 删除全部无效兑换码 | [删除无效兑换码.md](删除无效兑换码.md) |
| `/api/redemption/:id` | DELETE | AdminAuth | 删除指定兑换码 | [删除兑换码.md](删除兑换码.md) |
