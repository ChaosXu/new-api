# OAuth 登录与账号绑定

## 参与者

| 参与者 | 类型 | 职责 |
| --- | --- | --- |
| 访客/用户 | 用户角色 | 通过第三方身份提供商登录或为已有账号绑定第三方身份 |
| OAuth IdP | 外部系统 | GitHub/Discord/OIDC/LinuxDO/自定义/微信/Telegram 提供身份凭证 |
| 网关接入层 | 系统 | state CSRF 校验、会话绑定校验、重复绑定校验、注册开关判定 |
| 关系数据库 | 外部系统 | 持久化 user_oauth_bindings、外部身份占位、auth_flow |

## 流程图

```mermaid
flowchart TD
    START([Start - 发起 OAuth]) --> T1[POST /api/oauth/state 生成 flow_token 作为 state，含 intent=login/bind]
    T1 --> T2[跳转 IdP 授权，用户在 IdP 完成授权]
    T2 --> T3[IdP 回调 GET /api/oauth/:provider?state=...&code=...]
    T3 --> T4[GetAuthFlow 校验 state CSRF：purpose=oauth+provider 匹配]
    T4 --> G1{state 有效且未消费?}
    G1 -- 否 --> END_FAIL1([End - Cancel：state 无效/过期])
    G1 -- 是 --> G_INT{intent?}

    %% 绑定分支
    G_INT -- bind --> B1[校验当前会话 UserID/SessionID 与 flow 一致]
    B1 --> G_BIND{会话与 flow 绑定一致?}
    G_BIND -- 否 --> END_FAIL2([End - Cancel：会话不匹配])
    G_BIND -- 是 --> B2[ExchangeToken + GetUserInfo 获取第三方身份]
    B2 --> B3[网关：IsUserIDTaken 该第三方身份是否已被绑定]
    B3 --> G_DUP{已被绑定?}
    G_DUP -- 是 --> END_FAIL3([End - Cancel：该第三方账号已被其他用户绑定])
    G_DUP -- 否 --> B4[ConsumeAuthFlow + 写 user_oauth_bindings 或内置 provider 字段]
    B4 --> END_BIND([End - Success：绑定完成])

    %% 登录分支
    G_INT -- login --> L1[ExchangeToken + GetUserInfo 含 LinuxDO trust-level 校验]
    L1 --> L2[ConsumeAuthFlow 一次性消费]
    L2 --> L3[网关：IsUserIDTaken 第三方 ID 是否已存在关联用户]
    L3 --> G_EXIST{已有关联用户?}
    G_EXIST -- 是 --> L4[FillUserByProviderID 取出用户]
    L4 --> G_DEL{user.Id==0 软删残留?}
    G_DEL -- 是 --> END_FAIL4([End - Cancel：该账号已注销])
    G_DEL -- 否 --> SIGN[setupLogin 登录已有账号]
    G_EXIST -- 否 --> G_REG{RegisterEnabled 开放注册?}
    G_REG -- 否 --> END_FAIL5([End - Cancel：OAuth 注册已关闭])
    G_REG -- 是 --> NEW1[构造新用户 username=prefix+maxId]
    NEW1 --> NEW2[邮箱归一化 EnsureEmailAvailable]
    NEW2 --> G_EMAIL{邮箱可用或为空?}
    G_EMAIL -- 被占用 --> END_FAIL6([End - Cancel：邮箱已被占用，不自动绑定已有账号])
    G_EMAIL -- 可用/为空 --> NEW3[事务原子写：InsertWithTx + 建立绑定关系]
    NEW3 --> NEW4[FinalizeOAuthUserCreation：邀请奖励/赠送额度/初始化设置]
    NEW4 --> SIGN
    SIGN --> S1[校验 user.Status==Enabled]
    S1 --> G_STATUS{用户被禁?}
    G_STATUS -- 是 --> END_FAIL7([End - Cancel：用户已被禁用])
    G_STATUS -- 否 --> END_OK([End - Success：登录成功])
```

## 流程描述

本流程统一处理标准 OAuth（GitHub/Discord/OIDC/LinuxDO/自定义）的登录与绑定（`controller/oauth.go`）。微信与 Telegram 走独立的非标 OAuth 路由，逻辑类似但绑定写入字段不同。

**state 生成**（`oauth.go:38`）创建一个 10 分钟有效的 `AuthFlow`（purpose=oauth，含 provider、intent、可选 UserId/SessionId、邀请码），返回 `flow_token` 作为 OAuth `state` 参数，承担 CSRF 防护。

**回调处理**（`oauth.go:95` `HandleOAuth`）先校验 state 有效性与 provider 匹配，再按 intent 分流：
- **绑定（bind）**：要求当前登录会话与 flow 绑定一致，获取第三方身份后校验该身份未被其他用户占用，通过后写绑定关系（自定义 provider 写 `user_oauth_bindings` 表，内置 provider 写对应 `github_id` 等字段）。
- **登录（login）**：获取第三方身份（LinuxDO 额外校验 trust-level），消费 flow，判定该第三方 ID 是否已关联用户：
  - **已关联** → 取出该用户登录（软删残留视为已注销）。
  - **未关联** → 判定 `RegisterEnabled`：关闭则拒绝；开放则创建新用户，邮箱被占用时拒绝自动绑定（`OAuthEmailAlreadyTakenError`），事务内原子创建用户与绑定关系，完成后发放邀请/注册奖励。

无论登录还是新建，最终都汇聚到 `setupLogin` 签发会话，并校验用户未被禁用。
