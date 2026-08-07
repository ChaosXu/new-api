# 兑换码管理

## 职责

面向管理员的兑换码（一次性预付面值卡）生成与管理：批量创建、编辑、启停、删除、清理失效码。用户在钱包页输入码兑换入余额。

## 契约（开放能力）

- **兑换码分页列表与搜索能力**
- **兑换码批量创建能力**（count 1-100，含面值 quota 与过期时间）
- **兑换码更新与启停能力**
- **兑换码删除能力**：单个删除 + 批量清理失效码（已用/禁用/过期）
- **单码详情查询能力**

## 覆盖代码

`web/src/features/redemption-codes/`（index、api、types、constants、components）

## 内部子能力

- 兑换码表格（RedemptionsTable + Provider）
- 兑换码编辑抽屉（RedemptionsMutateDrawer）
- 状态体系：Unused(1)/Disabled(2)/Used(3)，外加"Expired"虚拟过滤态

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [数据表格复合组件](ui/data-table.md)

## 备注

兑换码与订阅的关系：兑换码是"一次性预付面值卡"，兑换后直接入钱包余额 quota；订阅是"周期性付费套餐"。用户在钱包页并列使用两者，且兑换码充入的余额可反过来用于订阅余额支付，形成 `兑换码 → 余额 → 订阅` 的间接链路。
