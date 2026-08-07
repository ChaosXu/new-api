# 通用工具

- **职责**：跨模块复用的通用基础设施——Redis 客户端、邮件、加密、配额计算、限流（Lua）、SSRF 防护、系统监控、JSON 包装、环境变量、速率限制器等。
- **覆盖代码**：`common/`（绝大部分文件）、`common/limiter/`（分布式限流器）、`logger/`（全局日志）、`i18n/`（go-i18n 多语言）
- **关键契约**：`common.Marshal`/`Unmarshal`/`UnmarshalJsonStr`/`DecodeJson`（JSON 包装）、`common.QuotaFromFloat`/`QuotaRound`（配额饱和换算）、Redis 客户端、限流器、`SysError`/`LogWarn`（日志）

## 项目约束

- **JSON 铁律**：所有 marshal/unmarshal 必须用 `common.*` 包装函数，**禁止直接用 `encoding/json`**（`json.RawMessage`/`json.Number` 仅可作类型引用）。
- 配额换算必须用 `common/quota_math.go` 的饱和函数（防溢出/防负扣费，int32 上限）。

## 依赖（内部逻辑模块）

- 常量与基础类型
- 国际化（语言包）
