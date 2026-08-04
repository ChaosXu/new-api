# 调用异步任务型 AI 接口

## 摘要

让普通用户通过令牌提交并查询异步 AI 任务（Midjourney、Suno 等），获取异步生成结果。

## 用例：
- **作为** 普通用户
- **我想要** 提交 Midjourney 绘图、Suno 音乐等异步任务并查询任务状态与结果
- **以便** 我能在应用中集成耗时的生成式 AI 任务，按需获取结果

## 验收标准：

### 场景：用户提交 Midjourney 任务
- **假设：** 用户持有效 API 令牌，且令牌允许调用 Midjourney 模型
- **当：** 用户请求 `POST /mj/submit/imagine`（或 change/describe/blend 等动作）
- **则：** 系统创建异步任务、预扣额度并返回任务 ID

### 场景：用户查询 Midjourney 任务状态
- **假设：** 用户已提交任务并获得任务 ID
- **当：** 用户请求 `GET /mj/task/:id/fetch`
- **则：** 返回该任务的当前状态与结果（成功后返回图片 URL 等）

### 场景：用户提交并查询 Suno 任务
- **假设：** 用户持有效 API 令牌
- **当：** 用户请求 `POST /suno/submit/:action` 提交，随后用 `GET /suno/fetch/:id` 查询
- **则：** 系统创建音乐生成任务并返回结果
