# 使用第三方账号登录或注册（标准 OAuth 提供商）

## 摘要

让访客使用 GitHub、Discord、OIDC、LinuxDO 或自定义 OAuth 提供商的账号一键登录或注册，免去记忆新密码。

## 用例：
- **作为** 访客
- **我想要** 使用已有的第三方账号（GitHub/Discord/OIDC/LinuxDO/自定义）登录或注册站点
- **以便** 我无需创建并记忆新密码即可快速接入站点的 AI 服务

## 验收标准：

### 场景：访客首次使用第三方账号登录并自动注册
- **假设：** 目标 OAuth 提供商已启用（`provider.IsEnabled()`）
- **而且假设：** 站点已开启注册（`RegisterEnabled`），允许 OAuth 自动创建账号
- **而且假设：** 访客已在第三方完成授权并被重定向回带 `code` 与有效 `state` 的回调
- **当：** 访客访问 `GET /api/oauth/:provider?code=<授权码>&state=<state>`（`controller/oauth.go` `HandleOAuth`）
- **则：** 系统校验 state、用 code 换取 token、获取第三方用户信息，自动创建新用户（普通角色、启用状态），创建登录会话并返回访问令牌，登录成功

### 场景：访客使用已绑定的第三方账号登录
- **假设：** 该第三方账号 ID 已在系统中关联到某启用状态的用户
- **当：** 访客访问 OAuth 回调
- **则：** 系统找到已存在的用户（含 legacy_id 迁移兼容），创建登录会话并返回访问令牌，登录成功

### 场景：state 无效被拒绝
- **假设：** 回调中的 state 不存在、已过期或与 provider 不匹配
- **当：** 访客访问 OAuth 回调
- **则：** 请求被拒绝（403）并提示 state 无效（`MsgOAuthStateInvalid`），不交换 token

### 场景：注册关闭导致无法自动注册
- **假设：** 第三方账号未关联任何用户，但站点关闭了注册（`RegisterEnabled=false`）
- **当：** 访客访问 OAuth 回调
- **则：** 请求被拒绝并提示注册已禁用（`MsgUserRegisterDisabled`）

### 场景：第三方账号邮箱被占用
- **假设：** 第三方返回的邮箱已被系统中其他用户占用
- **当：** 访客访问 OAuth 回调
- **则：** 请求被拒绝并提示邮箱已被占用（`MsgUserEmailAlreadyTaken`）

### 场景：关联用户已被封禁
- **假设：** 第三方账号关联的用户状态为禁用
- **当：** 访客访问 OAuth 回调
- **则：** 请求被拒绝并提示用户已被封禁（`MsgOAuthUserBanned`）
