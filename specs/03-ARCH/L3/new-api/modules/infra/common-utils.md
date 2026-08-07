# 通用工具

## 职责

跨模块复用的通用基础设施——Redis 客户端、邮件、加密、配额计算、限流（Lua）、SSRF 防护、系统监控、JSON 包装、环境变量、速率限制器等。

## 契约（开放能力）

- **统一 JSON 序列化能力**：以包装函数提供 marshal/unmarshal，收敛 JSON 库选择。
- **配额饱和换算能力**：以饱和取整方式换算配额（防溢出、防负扣费）。
- **分布式限流能力**：基于 Redis + Lua 的多维度限流。
- **通用基础设施能力**：Redis 客户端、加密、邮件、SSRF 防护、系统监控、日志、环境变量等。

## 覆盖代码

`common/`（绝大部分文件）、`common/limiter/`（分布式限流器）、`logger/`（全局日志）、`i18n/`（go-i18n 多语言）

## 依赖（内部逻辑模块）

- 常量与基础类型
- 国际化（语言包）

## 项目约束

- **JSON 铁律**：所有 marshal/unmarshal 必须用 `common.*` 包装函数，**禁止直接用 `encoding/json`**（`json.RawMessage`/`json.Number` 仅可作类型引用）。
- 配额换算必须用 `common/quota_math.go` 的饱和函数（防溢出/防负扣费，int32 上限）。
