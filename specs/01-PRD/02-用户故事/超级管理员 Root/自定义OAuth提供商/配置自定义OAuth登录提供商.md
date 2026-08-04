# 配置自定义 OAuth 登录提供商

## 摘要

让超管创建和管理自定义 OAuth 提供商（OIDC 等），为站点接入第三方登录。

## 用例：
- **作为** 超级管理员
- **我想要** 创建、编辑、删除自定义 OAuth 登录提供商，并通过发现文档自动获取端点配置
- **以便** 我能为站点接入任意第三方身份提供商，丰富用户登录方式

## 验收标准：

### 场景：超管拉取 OIDC 发现文档
- **假设：** 超管已登录（RootAuth）
- **当：** 超管提交 `POST /api/custom-oauth-provider/discovery`（`FetchCustomOAuthDiscovery`）提供 well_known_url 或 issuer_url
- **则：** 系统后端代理拉取 OIDC `.well-known/openid-configuration`（仅 http/https，20s 超时），返回端点配置，避免前端跨域

### 场景：超管创建自定义 OAuth 提供商
- **假设：** 超管已登录
- **当：** 超管提交 `POST /api/custom-oauth-provider/`（`CreateCustomOAuthProvider`）提供必填字段（name/slug/client_id/client_secret/各端点）
- **则：** 系统校验 slug 唯一且不与内置提供商冲突后创建，并注册到运行时 OAuth registry

### 场景：超管更新自定义 OAuth 提供商
- **假设：** 超管已登录
- **当：** 超管提交 `PUT /api/custom-oauth-provider/:id`（`UpdateCustomOAuthProvider`）
- **则：** 系统更新配置；若 slug 变更则先注销旧 slug 再注册新 slug；可选字段（密钥/图标等）空值则保留原值

### 场景：超管删除自定义 OAuth 提供商
- **假设：** 目标提供商无用户绑定
- **当：** 超管提交 `DELETE /api/custom-oauth-provider/:id`（`DeleteCustomOAuthProvider`）
- **则：** 系统从 registry 注销并删除该提供商

### 场景：存在用户绑定时禁止删除
- **假设：** 目标提供商已有用户绑定（`GetBindingCountByProviderId > 0`）
- **当：** 超管尝试删除
- **则：** 请求被拒绝，防止误删导致用户无法登录
