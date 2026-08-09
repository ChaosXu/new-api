# 令牌计数与用量

## 职责

对请求/响应的文本、图像、音频进行 token 计数与用量估算，作为计费与日志的依据。含本地分词器与上游用量解析。

## 契约（开放能力）

- **文本 token 计数能力**：用本地分词器或上游用量解析对文本请求/响应计数。
- **多模态用量估算能力**：估算图像/音频的用量与计费因子。
- **计费乘数有界校验能力**：对用户可控的计费乘数（图像数量等）强制上界校验。

## 覆盖代码

`server/internal/service/token_counter.go`、`server/internal/service/token_estimator.go`、`server/internal/service/tokenizer.go`、`server/internal/service/usage_helpr.go`、`server/internal/service/text_quota.go`（文本配额）、`server/internal/service/image.go`（图像计费因子）、`server/internal/service/audio.go`（音频时长解析计费）

## 依赖（内部逻辑模块）

- 计费结算（用量喂给计费）
- 配置（模型倍率）
- 数据访问（用量日志）

## 项目约束

- 用户可控的计费乘数（image n、audio duration 等）必须有界校验（`dto.MaxImageN`、`MaxTaskDurationSeconds`），音频时长来自文件头/上游 deduction 时需饱和转换。
