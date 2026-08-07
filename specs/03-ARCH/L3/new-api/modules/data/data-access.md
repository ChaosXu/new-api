# 实体数据访问

## 职责

基于 GORM 的数据访问层，定义各实体表结构（用户/令牌/渠道/日志/兑换码/任务等），管理数据库连接与跨库（主库/日志库）兼容，提供查询与 CRUD；含缓存。

## 契约（开放能力）

- **实体表结构与 CRUD 能力**：定义各实体表并提供跨库兼容的查询与写入。
- **跨库行锁能力**：以统一辅助函数在 MySQL/PostgreSQL 发 FOR UPDATE、SQLite 跳过。
- **主库/日志库分流能力**：按数据用途路由到主库或日志库分支。

## 覆盖代码

`model/`（全部实体与数据访问文件）

## 依赖（内部逻辑模块）

- 通用工具（Redis 缓存、加密、配额计算）
- 常量定义
- 配置（各设置模块）
- 中继上下文（日志记录用 RelayInfo）
- 协议转换类型（日志的 dto）

## 项目约束

- **跨库兼容**：必须同时支持 SQLite/MySQL≥5.7.8/PostgreSQL≥9.6。行锁必须用 `lockForUpdate(tx)`（MySQL/PG 发 FOR UPDATE，SQLite 跳过）；禁用 GORM v1 的 `Set("gorm:query_option","FOR UPDATE")`（v2 静默忽略）。避免 `gorm:"default:true"`（重启反复 ALTER）。方言差异用 `commonGroupCol`/`commonTrueVal` 等辅助。
