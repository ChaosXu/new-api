# 常量与基础类型

- **职责**：全局常量定义（API 类型、渠道类型、缓存键、上下文键、环境变量名、任务状态等枚举）与跨模块复用的基础数据结构（PriceData、并发安全 Map/Set 等）。
- **覆盖代码**：`constant/`（channel.go/api_type.go 等枚举常量）、`types/`（PriceData/concurrent Map/Set 等基础结构）、`dto/`（异步任务 DTO）
- **关键契约**：`ChannelType*` 枚举、`APIType*` 枚举、`RelayMode`、`PriceData`（含 OtherRatios 计费乘数）

## 项目约束

- `PriceData.OtherRatios` 必须经 `AddOtherRatio` 写入（拒绝非正/NaN/Inf），禁止直接赋值。

## 依赖（内部逻辑模块）

- 协议转换类型（relaykit/types 部分基础类型引用）
