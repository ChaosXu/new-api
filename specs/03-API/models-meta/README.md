# models-meta 模型元数据端点（管理员）

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/models/` | GET | AdminAuth | 模型元数据列表 | [模型元数据列表.md](模型元数据列表.md) |
| `/api/models/search` | GET | AdminAuth | 搜索模型 | [搜索模型.md](搜索模型.md) |
| `/api/models/:id` | GET | AdminAuth | 获取模型详情 | [获取模型.md](获取模型.md) |
| `/api/models/missing` | GET | AdminAuth | 获取缺失模型 | [缺失模型.md](缺失模型.md) |
| `/api/models/` | POST | AdminAuth | 创建模型 | [创建模型.md](创建模型.md) |
| `/api/models/` | PUT | AdminAuth | 更新模型（支持 status_only） | [更新模型.md](更新模型.md) |
| `/api/models/:id` | DELETE | AdminAuth | 删除模型 | [删除模型.md](删除模型.md) |
| `/api/models/sync_upstream/preview` | GET | AdminAuth | 预览上游同步差异 | [预览上游同步.md](预览上游同步.md) |
| `/api/models/sync_upstream` | POST | AdminAuth | 执行上游同步 | [执行上游同步.md](执行上游同步.md) |
