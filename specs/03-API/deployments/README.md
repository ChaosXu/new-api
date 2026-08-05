# deployments 部署端点（管理员，io.net）

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/deployments/` | GET | AdminAuth | 部署列表 | [部署列表.md](部署列表.md) |
| `/api/deployments/search` | GET | AdminAuth | 搜索部署 | [搜索部署.md](搜索部署.md) |
| `/api/deployments/:id` | GET | AdminAuth | 部署详情 | [部署详情.md](部署详情.md) |
| `/api/deployments/` | POST | AdminAuth | 创建部署 | [创建部署.md](创建部署.md) |
| `/api/deployments/:id` | PUT | AdminAuth | 更新部署 | [更新部署.md](更新部署.md) |
| `/api/deployments/:id/name` | PUT | AdminAuth | 重命名部署 | [重命名部署.md](重命名部署.md) |
| `/api/deployments/:id/extend` | POST | AdminAuth | 延长部署时长 | [延长部署.md](延长部署.md) |
| `/api/deployments/:id` | DELETE | AdminAuth | 删除部署 | [删除部署.md](删除部署.md) |
| `/api/deployments/settings` | GET | AdminAuth | 部署配置状态 | [部署设置.md](部署设置.md) |
| `/api/deployments/settings/test-connection` | POST | AdminAuth | 测试 io.net 连接 | [测试连接.md](测试连接.md) |
| `/api/deployments/hardware-types` | GET | AdminAuth | 硬件类型列表 | [硬件类型.md](硬件类型.md) |
| `/api/deployments/locations` | GET | AdminAuth | 位置列表 | [位置列表.md](位置列表.md) |
| `/api/deployments/available-replicas` | GET | AdminAuth | 可用副本查询 | [可用副本.md](可用副本.md) |
| `/api/deployments/price-estimation` | POST | AdminAuth | 价格估算 | [价格估算.md](价格估算.md) |
| `/api/deployments/check-name` | GET | AdminAuth | 检查名称可用性 | [检查名称.md](检查名称.md) |
| `/api/deployments/:id/logs` | GET | AdminAuth | 容器日志 | [部署日志.md](部署日志.md) |
| `/api/deployments/:id/containers` | GET | AdminAuth | 容器列表 | [容器列表.md](容器列表.md) |
| `/api/deployments/:id/containers/:container_id` | GET | AdminAuth | 容器详情 | [容器详情.md](容器详情.md) |
