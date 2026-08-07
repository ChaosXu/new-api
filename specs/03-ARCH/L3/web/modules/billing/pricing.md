# 定价广场

## 职责

面向访客与登录用户的公开"模型广场"：展示所有启用模型的价格、能力、分组倍率，支持多维筛选与表格/卡片双视图、模型详情。是公开页，无需登录。

## 契约（开放能力）

- **模型定价数据读取能力**：读取模型倍率、分组倍率、可用分组、端点映射、供应商列表（`/api/pricing`）
- **多维筛选能力**：按供应商、分组、配额类型（token/request）、端点类型、标签、关键词筛选
- **多视图展示能力**：表格视图与卡片网格视图切换
- **模型详情能力**：抽屉展示分组倍率、端点、倍率换算（ModelDetailsDrawer）
- **计价切换能力**：M/K 计价单位切换、充值价/显示价切换、排序（名称/价格）

## 覆盖代码

`web/src/features/pricing/`（index、api、types、constants、components、hooks）

## 内部子能力

- 定价表格（PricingTable）与卡片网格（ModelCardGrid）
- 筛选侧栏（PricingSidebar）与工具栏（PricingToolbar）
- 搜索栏、加载骨架、空状态、模型详情抽屉

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [通用工具库](infra/utils.md)（货币与价格比率换算）
- [通用 UI 原子组件](ui/ui-primitives.md)
