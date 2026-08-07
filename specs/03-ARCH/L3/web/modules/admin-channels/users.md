# 用户管理

## 职责

面向管理员的用户账户管理：列表、搜索、创建、更新、删除、角色/状态调整、配额调整、Passkey/2FA 重置、OAuth 绑定清理、权限目录查询。

## 契约（开放能力）

- **用户列表分页/排序与搜索能力**
- **用户创建与更新能力**：含角色、分组、配额、备注、管理员权限矩阵
- **用户删除能力**（硬删除）
- **用户管理动作能力**：提升/降级、启用/禁用、删除
- **用户配额原子调整能力**：加/减/覆盖
- **重置用户 Passkey / 2FA 能力**
- **管理员 OAuth 绑定管理能力**：查询、清理内置绑定、解绑自定义 OAuth
- **权限目录查询能力**（`/api/authz/catalog`）
- **分组查询能力**

## 覆盖代码

`web/src/features/users/`（index、api、types、constants、components）

## 内部子能力

- 用户表格（UsersTable + UsersProvider）
- 用户编辑抽屉（UsersMutateDrawer：角色 USER(1)/ADMIN(10)/ROOT(100)、分组、配额、权限矩阵）
- 用户删除对话框（UsersDeleteDialog）、主操作按钮（UsersPrimaryButtons）
- 状态体系：ENABLED(1)/DISABLED(2)/DELETED(-1)

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [数据表格复合组件](ui/data-table.md)
- [通用工具库](infra/utils.md)（权限矩阵类型）
