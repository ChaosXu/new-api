# HTTP 与认证会话底座

## 职责

整个前端的网络通信与认证会话底座：提供带认证拦截、token 自动刷新、请求去重、业务错误处理的 axios 实例；管理认证 bundle 的解析、刷新协议与跨标签页会话同步。

## 契约（开放能力）

- **统一 HTTP 客户端能力**：提供注入认证头、自动刷新过期 token、去重并发请求、统一业务错误转 toast 的 axios 实例
- **认证会话解析能力**：解析 access token、过期时间、用户信息、会话信息的认证 bundle
- **token 刷新协议能力**：在 token 过期时按协议刷新，处理 409 会话不匹配等异常并清理认证态
- **跨标签页会话同步能力**：通过 BroadcastChannel（storage 降级）在多标签页间同步登录/登出/会话变更
- **统一服务端错误处理能力**：将服务端错误码转为 toast 消息、HTTP 状态码规则解析、安全验证错误识别

## 覆盖代码

`web/src/lib/http-client.ts`、`web/src/lib/api.ts`、`web/src/lib/auth-session.ts`、`web/src/lib/auth-session-sync.ts`、`web/src/lib/handle-server-error.ts`、`web/src/lib/server-error-message.ts`、`web/src/lib/http-status-code-rules.ts`、`web/src/lib/secure-verification.ts`

## 依赖（内部逻辑模块）

- [全局状态与系统配置缓存](infra/global-state.md)
