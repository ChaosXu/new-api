# 会话与令牌鉴权

- **职责**：HTTP 请求的会话鉴权与 API 令牌（Token）鉴权。校验请求方的身份（Cookie 会话或 API Key），解析用户/令牌/分组上下文注入请求，供后续中间件与控制器使用。
- **覆盖代码**：`middleware/auth.go`、`middleware/auth_origin.go`、`service/auth_session.go`、`service/auth_token.go`、`service/auth_cleanup.go`
- **关键契约**：鉴权中间件函数、会话/令牌解析、请求上下文键（注入的用户/令牌信息）

## 依赖（内部逻辑模块）

- 数据访问（用户/令牌查询）
- 权限授权（角色判定）
- 通用工具（JWT、加密）
- 配置（系统设置）
