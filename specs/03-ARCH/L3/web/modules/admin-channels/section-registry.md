# 区块注册框架

## 职责

通用的分区域页面注册框架：通过声明式注册表（sections 数组）驱动多分区页面的导航项生成、URL 构造、分区内容渲染与元数据。被仪表盘、用量日志、系统设置（7 个子注册表）共用。

## 契约（开放能力）

- **声明式分区注册能力**：通过 `createSectionRegistry<TSectionId, TSettings, TExtraArgs>` 注册 sections（id/titleKey/build）、defaultSection、basePath、urlStyle（'path' 或 'query'）
- **导航项生成能力**：`getSectionNavItems(t)` 生成路径式或查询式 URL 的导航项，支持按权限过滤
- **分区内容与元数据获取能力**：`getSectionContent`、`getSectionMeta`、`sectionIds`

## 覆盖代码

`web/src/features/system-settings/utils/section-registry.ts`、各使用方的 `section-registry.tsx`（dashboard、usage-logs、system-settings 的 7 个子目录）

## 内部子能力

- urlStyle 'path'（`/dashboard/$section`）与 'query' 两种 URL 构造
- 分区可见性过滤（如仪表盘 users 分区仅管理员）
- build 回调返回分区内容（仪表盘/用量日志返回 null，内容在 index.tsx 渲染；系统设置返回实际组件）

## 依赖（内部逻辑模块）

- [国际化基础](infra/i18n.md)（titleKey 翻译）
- [全局复用 Hook](infra/hooks.md)（权限过滤）

## 备注

本模块是"可复用页面骨架"的提供者，本身不承载业务，被监控日志、系统设置等域消费。
