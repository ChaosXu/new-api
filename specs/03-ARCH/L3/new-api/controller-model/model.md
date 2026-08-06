# model

- **路径**：`./model`
- **职责**：数据访问层（GORM），定义各实体表结构、数据库连接管理、缓存、查询与 CRUD 操作；含跨库（主库/日志库）兼容处理

## 直接依赖（内部）

- common
- constant
- logger
- pkg/cachex
- relay/common
- relaykit/dto
- relaykit/types
- setting
- setting/billing_setting
- setting/config
- setting/console_setting
- setting/operation_setting
- setting/performance_setting
- setting/ratio_setting
- setting/system_setting
- types
