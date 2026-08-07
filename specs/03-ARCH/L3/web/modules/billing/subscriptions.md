# 订阅套餐管理

## 职责

订阅套餐全生命周期：管理员创建/编辑/启停套餐、管理用户订阅（创建/作废/删除/重置配额）；用户侧订阅查询、计费偏好、多通道支付购买。含合规门控（管理员须先在支付网关确认合规条款）。

## 契约（开放能力）

- **套餐管理能力**（管理员）：套餐 CRUD、启停
- **用户订阅管理能力**（管理员）：创建/作废/删除/按用户或按套餐重置配额
- **用户自助订阅查询能力**：查询本人订阅与完整信息、更新计费偏好（`updateBillingPreference`）
- **公开套餐列表能力**：提供可购买的公开套餐（`getPublicPlans`）
- **订阅多通道支付能力**：Stripe、Creem、Waffo-Pancake（含一次性产品铸造）、余额支付、Epay
- **合规门控能力**：管理员创建/变更套餐前校验支付网关合规条款确认状态

## 覆盖代码

`web/src/features/subscriptions/`（index、api、types、constants、components）

## 内部子能力

- 套餐编辑抽屉（SubscriptionsMutateDrawer：价格、时长单位 year/month/day/hour/custom、配额重置周期、升降级分组、各支付网关 price_id/product_id）
- 用户订阅表格（SubscriptionsTable + Provider，含合规提示 Alert）
- 订阅管理动作对话框（SubscriptionsDialogs、SubscriptionsPrimaryButtons）

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [数据表格复合组件](ui/data-table.md)
- [系统设置](admin-channels/system-settings.md)（合规门控依赖支付网关设置）
