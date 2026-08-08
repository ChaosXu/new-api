# OAuth 登录

## 职责

第三方 OAuth 登录提供者的抽象与实现（GitHub、Discord、LinuxDo、OIDC、Generic 自定义等），处理用户登录的 OAuth 授权码流程与用户绑定。

## 契约（开放能力）

- **多提供者 OAuth 登录能力**：以统一 Provider 抽象对接各第三方 OAuth 授权码流程（用户登录场景）。
- **OAuth 回调处理能力**：处理授权回调并换取用户信息。
- **账号绑定能力**：把第三方身份与本地用户绑定/解绑。

## 覆盖代码

`oauth/`（discord.go/github.go/generic.go 等用户登录 OAuth 提供者）

> 注：Codex 渠道的 OAuth 机器凭证刷新（`service/codex_oauth.go`）属于 Codex 集成模块（见 [../service/codex-integration.md](../service/codex-integration.md)），非用户登录 OAuth。

## 依赖（内部逻辑模块）

- 数据访问（用户绑定查询/创建）
- 通用工具（HTTP 客户端、状态令牌）
- 配置（系统设置中的 OAuth 配置）
