# 发起 OAuth 登录获取 state

## 摘要

让访客在跳转第三方授权前获取一次性 state，防止 CSRF 攻击，保障 OAuth 登录流程安全。

## 用例：
- **作为** 访客
- **我想要** 在跳转到第三方（GitHub/Discord/OIDC 等）授权前获取一个 OAuth state 码
- **以便** 我能安全地完成 OAuth 登录流程，避免被跨站请求伪造（CSRF）攻击

## 验收标准：

### 场景：访客发起 OAuth 登录获取 state
- **假设：** 访客选择了某个已启用的 OAuth 提供商
- **当：** 访客提交 `POST /api/oauth/state`（`controller/oauth.go` `GenerateOAuthCode`）携带 provider 名称和 intent=`login`
- **则：** 系统创建一个 10 分钟有效的 OAuth AuthFlow 记录，返回 `flow_token`（即 state）与过期时间，供后续跳转与回调校验

### 场景：provider 不存在或 intent 非法被拒绝
- **假设：** 访客提交的 provider 名称不存在，或 intent 不是 `login`/`bind`
- **当：** 访客请求 state
- **则：** 请求被拒绝并提示参数无效（`MsgInvalidParams`）
