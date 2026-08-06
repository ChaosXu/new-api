# 异步任务适配器（图像/视频/音频生成）

> **同构折叠组**：11 个异步任务适配器，都实现 `relay/channel.TaskAdaptor` 接口，结构同构，折叠汇总于此。

## 共性依赖（内部）

几乎所有适配器（≥9/11）都依赖以下模块：

- common
- constant
- dto
- model
- relay/channel
- relay/channel/task/taskcommon
- relay/common
- service

## 各适配器特例

| 适配器 | 非共性依赖 | 职责 |
| --- | --- | --- |
| relay/channel/task/ali | logger、relaykit/dto | ali 异步任务（图像/视频/音频生成）适配器 |
| relay/channel/task/doubao | relaykit/dto | doubao（豆包）异步任务（图像/视频/音频生成）适配器 |
| relay/channel/task/gemini | relaykit/dto、setting/model_setting | gemini 异步任务（图像/视频/音频生成）适配器 |
| relay/channel/task/hailuo | relaykit/dto | hailuo（海螺）异步任务（视频生成）适配器 |
| relay/channel/task/jimeng | relaykit/dto | jimeng（即梦）异步任务（图像/视频/音频生成）适配器 |
| relay/channel/task/kling | relaykit/dto | kling（可灵）异步任务（图像/视频/音频生成）适配器 |
| relay/channel/task/sora | （仅共性依赖） | sora 异步任务（图像/视频/音频生成）适配器 |
| relay/channel/task/suno | （仅共性依赖） | suno 异步任务（主要为音乐生成）适配器 |
| relay/channel/task/taskcommon | setting/system_setting | 异步任务适配器的公共工具与请求上下文/响应处理（含 metadata JSON 往返转换等通用逻辑） |
| relay/channel/task/vertex | relay/channel/task/gemini、relay/channel/vertex、relaykit/dto | vertex-ai 异步任务（图像/视频/音频生成）适配器 |
| relay/channel/task/vidu | relaykit/dto | vidu 异步任务（图像/视频/音频生成）适配器 |
