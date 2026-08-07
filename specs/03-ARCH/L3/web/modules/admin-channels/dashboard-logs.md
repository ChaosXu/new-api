# 监控与日志

## 职责

为已认证用户提供数据分析与监控：数据仪表盘（概览/模型分析/流量桑基/用户分析）、用量日志（调用/绘图/任务日志）、性能指标查询。性能指标作为数据/类型库供仪表盘等模块调用。

## 契约（开放能力）

- **仪表盘多分区展示能力**：概览（入门卡片 + 摘要 + 性能健康 + API 信息 + 公告 + FAQ + 可用性运行时间）、模型分析（调用配额统计、按模型/时间分析、消耗分布图）、流量桑基图（用户→节点→Token→分组→模型→渠道，含敏感数据遮罩）、用户分析（仅管理员）
- **用量日志查询能力**：通用调用日志、绘图（Midjourney）任务日志、异步任务日志，支持"全部/仅本人"视图切换、日志统计、用户信息查看
- **性能指标查询能力**：按模型细分的性能摘要（首字延迟 TTFT、延迟、成功率、TPS）、单模型性能时序数据
- **分区导航过滤能力**：按管理员身份过滤分区（如 users 分区仅管理员可见）

## 覆盖代码

`web/src/features/dashboard/`（index、section-registry、api、types、constants、hooks、components/overview、lib）、`web/src/features/usage-logs/`（index、section-registry、api、types、constants、components、data）、`web/src/features/performance-metrics/`（api、types、lib）

## 内部子能力

- 仪表盘分区注册（urlStyle path、basePath /dashboard、defaultSection overview）
- 概览面板（SummaryCards、PerformanceHealthPanel、ApiInfoPanel、AnnouncementsPanel、FAQPanel、UptimePanel，可见性由 useDashboardContentVisibility 控制）
- 流量桑基图（含敏感数据遮罩开关）
- 用量日志分区（common 通用日志、drawing/task 任务日志，标签切换器分组）

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [全局复用 Hook](infra/hooks.md)（管理员判定）
- [通用工具库](infra/utils.md)（图表主题、VChart）
- [区块注册框架](admin-channels/section-registry.md)

## 备注

本模块大量复用通用区块注册框架（createSectionRegistry）。
