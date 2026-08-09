# 任务轮询与异步处理

## 职责

异步任务（图像/视频/音频生成，如 Suno/Midjourney/Kling/Sora）的提交、轮询查询、状态推进与最终结算。管理任务的生命周期与定时轮询。

## 契约（开放能力）

- **异步任务提交与轮询能力**：提交任务并周期性轮询上游状态、推进任务状态机。
- **任务生命周期管理能力**：管理任务从提交到完成/失败的全程状态流转与定时调度。
- **任务回调处理能力**：处理上游 webhook 回调以推进任务状态。

## 覆盖代码

`server/internal/service/task.go`、`server/internal/service/task_polling.go`、`server/internal/service/midjourney.go`、`server/internal/service/subscription_reset_task.go`、`server/internal/service/system_task.go`、`server/internal/service/webhook.go`

## 依赖（内部逻辑模块）

- 渠道适配框架（调用 TaskAdaptor）
- 计费结算（任务计费）
- 数据访问（任务记录）
- 通用工具（HTTP 客户端、定时任务）
