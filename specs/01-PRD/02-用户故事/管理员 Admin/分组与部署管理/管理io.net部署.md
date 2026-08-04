# 管理 io.net 部署

## 摘要

让管理员管理 io.net GPU 部署实例（创建、查看、更新、删除、查看日志），运维算力资源。

## 用例：
- **作为** 管理员
- **我想要** 创建和管理 io.net GPU 部署实例（含查看日志、容器、价格估算）
- **以便** 我能运维平台依赖的 GPU 算力资源，确保部署正常运行

## 验收标准：

### 场景：管理员查看部署设置与连接状态
- **假设：** 管理员已登录（AdminAuth）
- **当：** 管理员请求 `GET /api/deployments/settings`（`controller/deployment.go` `GetModelDeploymentSettings`）
- **则：** 返回 io.net 部署功能的启用与配置状态

### 场景：管理员测试 io.net 连接
- **假设：** 管理员已登录
- **当：** 管理员提交 `POST /api/deployments/settings/test-connection`（`TestIoNetConnection`）
- **则：** 系统验证 API Key 可用性并返回连接结果

### 场景：管理员创建部署
- **假设：** 管理员已登录
- **当：** 管理员提交 `POST /api/deployments/`（`CreateDeployment`）
- **则：** 系统在 io.net 创建部署实例

### 场景：管理员查看部署列表与详情
- **假设：** 管理员已登录
- **当：** 管理员请求 `GET /api/deployments/`（列表/搜索）或 `GET /api/deployments/:id`（详情）
- **则：** 返回部署列表或指定部署详情

### 场景：管理员查看部署日志与容器
- **假设：** 管理员已登录
- **当：** 管理员请求 `GET /api/deployments/:id/logs`（日志）或 `/api/deployments/:id/containers`（容器列表）
- **则：** 返回部署运行日志或容器信息

### 场景：管理员更新、延长或删除部署
- **假设：** 管理员已登录
- **当：** 管理员提交 `PUT /api/deployments/:id`（更新）、`POST /api/deployments/:id/extend`（延长）或 `DELETE /api/deployments/:id`（删除）
- **则：** 系统执行对应操作

### 场景：管理员查询硬件、地区、价格估算
- **假设：** 管理员已登录
- **当：** 管理员请求硬件类型、地区、可用副本或价格估算接口
- **则：** 返回相应信息辅助部署决策
