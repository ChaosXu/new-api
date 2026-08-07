# OAuth 登录

- **职责**：第三方 OAuth 登录提供者的抽象与实现（GitHub、Discord、LinuxDo、OIDC、Generic 自定义等），处理 OAuth 授权码流程与用户绑定。
- **覆盖代码**：`oauth/`（discord.go/github.go/generic.go 等）、`service/codex_oauth.go`（Codex 相关 OAuth）
- **关键契约**：OAuth Provider 接口、各提供者实现、回调处理

## 依赖（内部逻辑模块）

- 数据访问（用户绑定查询/创建）
- 通用工具（HTTP 客户端、状态令牌）
- 配置（系统设置中的 OAuth 配置）
