# 任务轮询与异步处理

- **职责**：异步任务（图像/视频/音频生成，如 Suno/Midjourney/Kling/Sora）的提交、轮询查询、状态推进与最终结算。管理任务的生命周期与定时轮询。
- **覆盖代码**：`service/task.go`、`service/task_polling.go`、`service/midjourney.go`、`service/subscription_reset_task.go`、`service/system_task.go`、`service/webhook.go`
- **关键契约**：任务轮询器、任务状态机、webhook 回调处理

## 依赖（内部逻辑模块）

- 渠道适配框架（调用 TaskAdaptor）
- 计费结算（任务计费）
- 数据访问（任务记录）
- 通用工具（HTTP 客户端、定时任务）
