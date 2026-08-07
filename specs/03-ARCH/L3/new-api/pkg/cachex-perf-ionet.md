# 多级缓存与可观测与 io.net

- **职责**：三个独立的内部工具包：(1) cachex 本地内存（hot LRU）+ Redis 的多级带命名空间缓存；(2) perf_metrics 性能指标分桶采集与周期 flush；(3) ionet io.net 云服务客户端（容器/部署/硬件 API）。
- **覆盖代码**：`pkg/cachex/`、`pkg/perf_metrics/`、`pkg/ionet/`
- **关键契约**：cachex 多级缓存接口（Get/Set/带命名空间）、perf_metrics 采集与 flush、ionet 客户端方法

## 依赖（内部逻辑模块）

- 通用工具（Redis、日志）
- 数据访问（perf_metrics 落库）
- 中继上下文（perf_metrics 用 RelayInfo）
- 配置（perf_metrics_setting）
