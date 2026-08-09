# 多级缓存与可观测与 io.net

## 职责

三个独立的内部工具包：(1) cachex 本地内存（hot LRU）+ Redis 的多级带命名空间缓存；(2) perf_metrics 性能指标分桶采集与周期 flush；(3) ionet io.net 云服务客户端（容器/部署/硬件 API）。

## 契约（开放能力）

- **多级带命名空间缓存能力**：本地内存 LRU + Redis 的两级缓存读写。
- **性能指标采集与落库能力**：分桶采集性能指标并周期性 flush。
- **io.net 云服务交互能力**：经客户端调用 io.net 的容器/部署/硬件 API。

## 覆盖代码

`server/pkg/cachex/`、`server/pkg/perf_metrics/`、`server/pkg/ionet/`

## 依赖（内部逻辑模块）

- 通用工具（Redis、日志）
- 数据访问（perf_metrics 落库）
- 中继上下文（perf_metrics 用 RelayInfo）
- 配置（perf_metrics_setting）
