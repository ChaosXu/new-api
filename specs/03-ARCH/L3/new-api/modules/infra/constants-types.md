# 常量与基础类型

## 职责

全局常量定义（API 类型、渠道类型、缓存键、上下文键、环境变量名、任务状态等枚举）与跨模块复用的基础数据结构（PriceData、并发安全 Map/Set 等）。

## 契约（开放能力）

- **全局枚举常量定义能力**：提供渠道类型、API 类型、中继模式、任务状态等系统级枚举。
- **基础数据结构能力**：提供 PriceData、并发安全 Map/Set 等复用结构。
- **计费乘数受控写入能力**：PriceData 的计费乘数经统一入口写入（拒绝非正/NaN/Inf）。

## 覆盖代码

`server/internal/constant/`（channel.go/api_type.go 等枚举常量）、`server/internal/types/`（PriceData/concurrent Map/Set 等基础结构）、`server/internal/dto/`（异步任务 DTO）

## 依赖（内部逻辑模块）

- 协议转换类型（server/relaykit/types 部分基础类型引用）

## 项目约束

- `PriceData.OtherRatios` 必须经 `AddOtherRatio` 写入（拒绝非正/NaN/Inf），禁止直接赋值。
