---
name: code-to-api-docs
description: 从后端代码归纳全部 HTTP/HTTPS API，当用户提到"归纳API"、"提取接口"时使用。
---

## 目的

从后端代码归纳系统对外暴露的全部 HTTP/HTTPS API，按 **REST 资源的真实路径嵌套**组织目录，每个端点一个可独立阅读的 Markdown 文档，每个资源一个索引 README。

产出是**纯接口契约文档**（描述"提供什么能力、怎么调用、返回什么"），不是实现说明（不深陷代码内部结构），也不是 OpenAPI/Swagger JSON。

## 关键概念

### REST 资源识别准则

资源目录按**真实路由路径段嵌套**，而非拍平为连字符目录名：

- **顶级路径段**为资源根：比如`/api/user/*` → `user/`，`/api/channel/*` → `channel/`
- **语义独立的子路径嵌套为子目录**：比如`/api/user/passkey/*` → `user/passkey/`，`/api/channel/:id/codex/*` → `channel/codex/`
- **路径本身含连字符的保持不变**：比如`/api/custom-oauth-provider` 就是一个目录 `custom-oauth-provider/`，不拆为 `custom/oauth/provider/`
- **CRUD 不拆**：同一资源的 GET 列表 / GET :id / POST / PUT / DELETE 归入同一资源目录
- **动作型端点归入所属资源**：比如：`/test`、`/search`、`/fix` 不单独成资源，归入所属资源目录下的端点文件

### 嵌套 vs 拍平的判定

| 情况 | 处理 | 示例 |
|---|---|---|
| 路径真实嵌套 | **嵌套** | `/api/user/passkey` → `user/passkey/` |
| 路径本身含连字符 | **保持** | `/api/custom-oauth-provider` → `custom-oauth-provider/` |

### 统一响应信封识别

先判断项目是否有统一响应包装。典型模式（Gin 框架）：

- **有统一信封**：`{success: bool, message: string, data: any}`，HTTP 状态码恒为 200，业务成败看 `success`。源在 `common/gin.go` 的 `ApiSuccess` / `ApiError` / `ApiErrorI18n` 等公共 helper。
- **无统一信封（原生协议）**：如 OpenAI 兼容接口返回 `{error: {message, type, code}}`、Claude 返回 `{type: "error", error: {...}}`。需按各协议原生格式描述。

在总览 README 中统一说明信封约定，各端点文档标注是否遵循信封或为原生协议。

### 鉴权类型识别

从路由的中间件链读取鉴权要求。比如：

| 中间件 | 含义 |
|---|---|
| （无） | 公开接口 |
| `UserAuth` | 已登录用户 |
| `AdminAuth` | 管理员（角色数值门槛） |
| `RootAuth` | 超级管理员 |
| `TokenAuth` | API 令牌（如 `sk-xxx`） |
| `RequirePermission(p)` | 细粒度 RBAC（Casbin 权限位） |
| `SecureVerificationRequired` | 安全操作二次验证（需 `X-Security-Proof` 头） |

鉴权信息来自三处：路由组级 `Use()`、端点级内联中间件、表驱动的权限映射（如 `channelPermissionRoutes`）。务必三者都读。

### 数据源追溯

| 要提取的信息 | 权威来源 |
|---|---|
| 路径 / HTTP 方法 / 鉴权 / 中间件链 | `router/*.go` |
| 请求参数（字段 / json tag / validate 约束） | `controller/*.go` 内的请求 struct（常内联在 handler 旁） |
| 响应 data 类型 | `controller/*.go` 的 `c.JSON` / `ApiSuccess` 调用，或 `gin.H` 内联 |
| 响应字段 schema | `model/*.go` 的 struct（含 json tag） |
| 敏感字段脱敏 | `json:"-"` tag + 响应层处理（如 `GetMaskedKey`） |
| 错误码 key | `controller/*.go` 内调用的 `MsgXxx` 常量 |
| 错误码文案（en/zh） | `i18n/keys.go`（常量定义）+ `i18n/locales/*.yaml`（翻译文案） |
| 分页约定 | `common.GetPageQuery` / `PageInfo` |
| 限流 / 人机校验 | 路由中间件（`CriticalRateLimit` / `TurnstileCheck` 等） |

### 反模式（这不是什么）

- **不是 swagger 注解自动生成**：不依赖 swaggo 等工具从代码反射生成。理由：版本降级（Swagger 2.0 vs OpenAPI 3.0）、跨 module 解析风险、不支持分文件。
- **不是 OpenAPI JSON**：产出是人类可读的 Markdown，不是机器可读的 JSON/YAML。
- **不是按业务领域分类**：按 REST 资源路径组织，不按"认证域""渠道域"等业务概念分类。
- **不是实现文档**：不描述 controller 函数内部逻辑、不贴代码、不写行号引用。描述的是对外契约。
- **不是一次性全量生成后不管**：代码变更后需同步更新。校验步骤确保覆盖率。

---

## 应用

### 第 1 步：盘点全部路由

- **读取路由文件**：找到项目的路由注册入口（如 `router/*.go`），读取全部 `GET/POST/PUT/DELETE/PATCH/Handle` 注册。
- **提取每条路由的**：HTTP 方法、完整路径（还原 group 前缀）、中间件链（组级 `Use` + 端点级内联 + 表驱动权限）、handler 函数名。
- **注意三种中间件挂载方式**：路由组级 `Use()`、端点级内联参数、表驱动映射（如 `[]permissionRoute{{method, path, permission, handler}}`）。三者都要读全。
- **输出端点总表**：作为后续校验的基准。

---

### 第 2 步：按真实路径嵌套识别资源

- **顶级段为资源根**：`/api/user/*` → `user/`，`/api/channel/*` → `channel/`。
- **语义独立子路径嵌套**：`/api/user/passkey/*` → `user/passkey/`（不是 `user-passkey/`）。
- **同族前缀归入统一父目录**：如所有 OpenAI/Claude/Gemini/MJ/Suno 中转接口归入 `relay/`，再按 `/v1`、`/v1beta`、`/mj` 等路径段嵌套。
- **路径本身含连字符的保持不变**：`/api/custom-oauth-provider` → `custom-oauth-provider/`。
- **CRUD 不拆，动作归入所属资源**。
- **跨前缀的同名资源**：如 `/api/mj`（管理查询）和 `/mj`（中转）是不同前缀，保持各自独立目录。

**质量检查**：连字符目录只应是"路径本身含连字符"的情况。如果出现 `xxx-yyy/` 且路径是 `/xxx/yyy`，应改为嵌套 `xxx/yyy/`。

---

### 第 3 步：逐端点提取规格

对每个端点，从对应 controller handler 提取：

- **请求参数**：query 参数（名称/类型/默认值/含义）或 request body struct（字段/json tag/类型/validate 约束/含义）。注意 `map[string]interface{}` 接收的需按代码分支描述。
- **响应 data 类型**：model struct（列出字段表）或内联 `gin.H`（列出 key）或无 data。注意非标准信封（如 `{message, data, url}` 或纯文本）。
- **错误码**：handler 内调用的 `MsgXxx` 常量 + 触发条件。硬编码中文消息标注为"字面消息"。从 i18n locale 文件提取 en/zh 文案。
- **鉴权与前置**：中间件链中的鉴权 + 限流 + 人机校验 + 合规门控等。
- **敏感字段脱敏**：标注 `json:"-"` 字段和响应层脱敏规则（如 key 脱敏为 `sk-abc****xyz`）。

---

### 第 4 步：生成文档

- **每端点一个 md 文件**，文件名用**自然语言**（动词+宾语，如 `创建渠道.md`、`查看渠道密钥.md`）。同类操作加限定词（`批量删除.md`、`测试所有渠道.md`、`测试指定渠道.md`）。使用 `assets/endpoint.md` 获取填写结构。
- **每资源一个 README.md**，含路由前缀说明、鉴权说明、数据模型（model struct 字段表）、端点清单表（文件链接/方法/路径/用途）。使用 `assets/resource-readme.md` 获取填写结构。
- **一个总览 README**，含公共约定（统一信封/鉴权类型/分页/敏感字段规则）+ 全部资源索引表（资源/目录/路由前缀/端点数）。使用 `assets/overview-readme.md` 获取填写结构。
- **输出位置**：按项目约定（如 `specs/03-API/`）。

**大规模项目的分批策略**：若端点数超过 100，按路径前缀分批，每批可并行处理（每批一个 agent 负责多个资源）。先写总览 README 骨架，再逐批填充。

---

### 第 5 步：交叉校验

- **端点覆盖**：总端点数 = router 注册数。找出遗漏或多余。
- **路径/鉴权一致性**：抽查若干端点，确认文档中的方法/路径/鉴权与 router 代码一致。
- **MsgKey 可追溯**：抽查错误码表中的 MsgKey，确认在 `i18n/keys.go` 真实存在。
- **无空目录**：每个资源目录至少有 README + 1 个端点文件。
- **链接有效**：总览 README 和各资源 README 的相对链接指向真实存在的文件。
- **嵌套正确**：无"路径真实嵌套但拍平为连字符"的残留。

---

## 参考

- REST 架构风格（Roy Fielding 博士论文）— 资源/表示/状态转移
- OpenAPI 3.0 规范 — 接口契约的字段描述参考（虽不输出 JSON，但字段表结构可借鉴）
- Gin 框架路由 — 中间件链 / 路由组 / 参数绑定（`ShouldBindJSON` / `c.Query`）
- GORM struct tag — `json` / `validate` 标签的含义
