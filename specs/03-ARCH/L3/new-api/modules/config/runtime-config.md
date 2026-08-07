# 运行时配置

## 职责

系统运行时设置的管理——各设置模块（计费倍率、模型适配参数、运营、控制台、性能、系统、计费模式等）的注册、加载、热更新与持久化。

## 契约（开放能力）

- **设置注册与加载能力**：统一注册并加载各设置模块。
- **设置热更新与持久化能力**：运行时变更设置并持久化（Redis + DB）。
- **设置项查询能力**：按结构与键读取各设置项的当前值。

## 覆盖代码

`setting/`（注册入口）、`setting/config/`（ConfigManager）、`setting/billing_setting/`、`setting/model_setting/`、`setting/operation_setting/`、`setting/ratio_setting/`、`setting/console_setting/`、`setting/system_setting/`、`setting/performance_setting/`、`setting/perf_metrics_setting/`、`setting/reasoning/`

## 依赖（内部逻辑模块）

- 通用工具（Redis 持久化）
- 数据访问（设置存储）
- 协议转换（reasoning 设置再导出 relaykit 的 reasoning 工具）
