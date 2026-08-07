# 模型目录管理

## 职责

维护系统向用户暴露的"模型目录"（model_name 与供应商 vendor 的元数据），控制哪些模型对用户可见、如何命名匹配、归属哪个供应商；并管理 io.net GPU 部署（Deployments）。

## 契约（开放能力）

- **模型元数据 CRUD 能力**：model_name、描述、图标、tags、vendor、endpoints、name_rule（精确/前缀/包含/后缀 4 种匹配规则）、status、sync_official
- **模型状态切换能力**
- **供应商（Vendor）CRUD 能力**
- **上游同步能力**：同步上游模型、预览差异、应用覆盖（支持 zh/en/ja、official/config 来源）
- **缺失模型检测能力**：识别"已用未配置"模型
- **预设组（Prefill Group）CRUD 能力**：model/tag/endpoint 三类
- **io.net GPU 部署管理能力**：连接配置与测试、部署列表/搜索/详情/删除/改名/续期、容器与日志、硬件/位置/副本查询、价格估算、创建部署、集群名可用性检查

## 覆盖代码

`web/src/features/models/`（index、api、types、constants、section-registry、components、drawers、dialogs、hooks、lib）

## 内部子能力

- 元数据表格（ModelsTable）
- io.net 部署表格（DeploymentsTable，受 DeploymentAccessGuard 保护：检查 io.net 启用与连接）
- 模型编辑抽屉（model-mutate-drawer）
- 同步向导对话框（sync-wizard-dialog）、冲突解决（upstream-conflict-dialog）、缺失模型（missing-models-dialog）、预设组管理（prefill-group-management）
- 创建部署抽屉（create-deployment-drawer）

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [数据表格复合组件](ui/data-table.md)
- [系统设置](admin-channels/system-settings.md)（io.net 部署依赖模型路由设置）
