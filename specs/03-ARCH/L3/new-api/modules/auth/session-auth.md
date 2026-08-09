# 会话与令牌鉴权

## 职责

HTTP 请求的会话鉴权与 API 令牌（Token）鉴权。校验请求方的身份（Cookie 会话或 API Key），解析用户/令牌/分组上下文注入请求，供后续中间件与控制器使用。

## 契约（开放能力）

- **会话鉴权能力**：校验 Cookie 会话身份。
- **API 令牌鉴权能力**：校验 API Key 并解析其权限边界。
- **请求身份上下文注入能力**：把用户/令牌/分组信息注入请求上下文供后续使用。

## 覆盖代码

`server/internal/middleware/auth.go`、`server/internal/middleware/auth_origin.go`、`server/internal/service/auth_session.go`、`server/internal/service/auth_token.go`、`server/internal/service/auth_cleanup.go`

## 依赖（内部逻辑模块）

- 数据访问（用户/令牌查询）
- 权限授权（角色判定）
- 通用工具（JWT、加密）
- 配置（系统设置）
