# 系统信息与首次部署

## 职责

两部分：Root 用户的系统运行信息仪表盘（活动分布式实例与后台系统任务）；以及后端就绪但未初始化时的首次部署 4 步初始化向导。

## 契约（开放能力）

- **系统实例查看能力**（仅 Root）：列出活动分布式实例、删除陈旧实例、删除单个实例、查看系统任务
- **首次部署状态查询能力**：查询部署初始化状态
- **首次部署初始化能力**：4 步向导（数据库检查 → 管理员账号 → 使用模式 external/self/demo → 审核与初始化），提交 Root 凭据与使用模式（`POST /api/setup`）

## 覆盖代码

`web/src/features/system-info/`（index、api、types、components/system-instances-panel、components/system-tasks-panel）、`web/src/features/setup/`（index、setup-wizard、api、types、components/admin-step、components/complete-step、components/database-step、components/usage-mode-step、components/step-navigation）

## 内部子能力

- 系统实例面板（SystemInstancesPanel）与系统任务面板（SystemTasksPanel）
- 部署向导（react-hook-form，StepNavigation 上一步/下一步/提交，右上角语言切换；Root 已初始化则跳过凭据输入，映射为 SelfUseModeEnabled/DemoSiteEnabled）

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [路由层与权限守卫](framework/routing-guard.md)（__root.tsx 根据 setup 状态强制重定向）
- [国际化基础](infra/i18n.md)

## 备注

首次部署向导由 `__root.tsx` 强制执行：当 `setup status.status` 为 false 时重定向到 `/setup`，完成后重定向到 `/`。
