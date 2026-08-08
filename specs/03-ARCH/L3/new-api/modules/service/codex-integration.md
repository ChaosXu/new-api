# Codex 集成

## 职责

将 OpenAI Codex（ChatGPT 后端）渠道接入 new-api：管理其 OAuth 凭证生命周期（后台自动刷新 + 按需刷新）并暴露 Codex 专属后端 API（模型发现、WHAM 用量与限额重置积分）。所有 Codex 渠道凭证以 JSON OAuth key blob 形式存储于渠道 `key` 列，过期或上游返回 401/403 时透明刷新。

## 契约（开放能力）

- **Codex 渠道 OAuth 凭证刷新能力**：后台定时调度刷新（距过期 ≤24h 触发）与按需刷新（上游 401/403 触发），刷新后持久化新令牌到渠道记录。
- **Codex 模型发现能力**：拉取渠道可用 Codex 模型（401 自动刷新凭证，含 compact 后缀变体）。
- **Codex 客户端版本查询能力**：查询 Codex CLI 最新稳定版本（GitHub releases，1h 缓存）。
- **Codex 账号用量与限额重置积分能力**：查询 WHAM 用量、限额重置积分余额、消费一枚限额重置积分。
- **Codex 账号身份提取能力**：从 OAuth JWT claims 提取账号 ID 与邮箱。
- **仪表盘用量端点能力**：经控制器层向仪表盘暴露 Codex 用量/重置端点。

## 覆盖代码

`service/codex_oauth.go`（OAuth 刷新 + HTTP 客户端 + JWT 提取）、`service/codex_credential_refresh.go`（按需刷新 + DB 持久化）、`service/codex_credential_refresh_task.go`（后台调度器，仅主节点运行）、`service/codex_channel_models.go`（模型发现 + 401 自动刷新）、`service/codex_models.go`（客户端版本 + 原始模型拉取）、`service/codex_wham_usage.go`（WHAM 用量/限额重置积分）、`controller/codex_usage.go`（仪表盘用量 handler）

## 内部子能力

- 凭证生命周期：后台调度刷新 + 按需刷新 + JWT 身份回填
- Codex 后端 API：模型发现、客户端版本、WHAM 用量/限额重置

## 依赖（内部逻辑模块）

- 通用工具（HTTP 客户端工厂、SSRF 防护、JSON 包装）
- 数据访问（渠道查询/更新、渠道缓存初始化）
- HTTP 客户端与文件处理（复用代理 HTTP 客户端工厂）
