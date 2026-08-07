# 令牌计数与用量

- **职责**：对请求/响应的文本、图像、音频进行 token 计数与用量估算，作为计费与日志的依据。含本地分词器与上游用量解析。
- **覆盖代码**：`service/token_counter.go`、`service/token_estimator.go`、`service/tokenizer.go`、`service/usage_helpr.go`、`service/text_quota.go`（文本配额）、`service/image.go`（图像计费因子）、`service/audio.go`（音频时长解析计费）
- **关键契约**：token 计数函数、用量估算接口、`MaxImageN`（图像数量上界，计费乘数校验）

## 依赖（内部逻辑模块）

- 计费结算（用量喂给计费）
- 配置（模型倍率）
- 数据访问（用量日志）

## 项目约束

- 用户可控的计费乘数（image n、audio duration 等）必须有界校验（`dto.MaxImageN`、`MaxTaskDurationSeconds`），音频时长来自文件头/上游 deduction 时需饱和转换。
