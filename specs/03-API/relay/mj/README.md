# Midjourney 中转端点

Midjourney 任务型中转接口，路径前缀 `/mj/*`，与 `/:mode/mj/*` 同构（同一组 handler，仅前缀不同）。任务调度走 `RelayMidjourney`（`controller/relay.go`），提交后由 `RelayMidjourneySubmit`/`RelayMidjourneyTask`/`RelayMidjourneyTaskImageSeed`/`RelaySwapFace` 分发。

## 鉴权
- 除「获取图片」在 `TokenAuth` 中间件**之前**注册（匿名）外，其余端点统一走 `TokenAuth + Distribute`，由令牌额度与渠道分发决定上游。
- `/mj/image/:id` 在 `relayMjRouter.Use(middleware.TokenAuth(), middleware.Distribute())` 之前注册，因此不需要鉴权。

## `:mode` 前缀
`/:mode/mj/*` 与 `/mj/*` 完全同构（`registerMjRouterGroup` 同时挂载到 `/mj` 与 `/:mode/mj`）。`mode` 用于在上游区分 Midjourney 的运行速度档位，常见取值：

| mode | 含义 |
| --- | --- |
| `fast` | Fast 模式（默认，消耗快速时长） |
| `relax` | Relax 模式（不消耗快速时长，排队慢） |
| `turbo` | Turbo 模式（最快，消耗倍率更高） |

例如 `POST /fast/mj/submit/imagine` 与 `POST /mj/submit/imagine` 等价，仅速度档位不同。

## 通用响应（MidjourneyDto）
任务查询/提交回执统一返回 `dto.MidjourneyDto`：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `id` | string | 任务 ID（mj_id） |
| `action` | string | 任务动作（imagine、upscale、variation 等） |
| `customId` | string | Midjourney 按钮 customId |
| `botType` | string | 机器人类型（MID_JOURNEY / NIJI_JOURNEY） |
| `prompt` / `promptEn` | string | 原始 / 翻译后提示词 |
| `description` | string | 描述 |
| `state` | string | 用户透传 state |
| `submitTime` / `startTime` / `finishTime` | int64 | 毫秒时间戳 |
| `imageUrl` | string | 生成图片 URL |
| `videoUrl` | string | 视频结果 URL |
| `videoUrls` | `[{url}]` | 多视频结果 |
| `status` | string | `NOT_START` / `SUBMITTED` / `IN_PROGRESS` / `SUCCESS` / `FAILURE` |
| `progress` | string | 进度，如 `50%` |
| `failReason` | string | 失败原因 |
| `buttons` | array | 可点击按钮（`{customId,emoji,label,type,style}`） |
| `maskBase64` | string | 编辑掩码 |
| `properties` | object | `{finalPrompt, finalZhPrompt}` |

## 端点列表

### 提交类（POST /mj/submit/*）
| 端点 | 用途 | 文件 |
| --- | --- | --- |
| `POST /mj/submit/imagine` | 文生图 | [文生图.md](文生图.md) |
| `POST /mj/submit/change` | 图像变换（upscale/variation/pan 等） | [图像变换.md](图像变换.md) |
| `POST /mj/submit/simple-change` | 简单变换 | [简单变换.md](简单变换.md) |
| `POST /mj/submit/describe` | 图生文 | [图生文.md](图生文.md) |
| `POST /mj/submit/blend` | 多图混合 | [混合.md](混合.md) |
| `POST /mj/submit/shorten` | 提示词缩写 | [缩写.md](缩写.md) |
| `POST /mj/submit/modal` | Modal 提交（INPOOL 等） | [Modal提交.md](Modal提交.md) |
| `POST /mj/submit/edits` | 局部编辑 | [编辑.md](编辑.md) |
| `POST /mj/submit/video` | 视频生成 | [视频生成.md](视频生成.md) |
| `POST /mj/submit/action` | 按 customId 解析动作 | [Action提交.md](Action提交.md) |
| `POST /mj/submit/upload-discord-images` | 上传 Discord 图片 | [上传Discord图片.md](上传Discord图片.md) |
| `POST /mj/insight-face/swap` | InsightFace 换脸 | [换脸.md](换脸.md) |

### 查询类
| 端点 | 方法 | 用途 | 文件 |
| --- | --- | --- | --- |
| `/mj/image/:id` | GET | 获取图片（**无鉴权**） | [获取图片.md](获取图片.md) |
| `/mj/task/list-by-condition` | POST | 条件批量查询 | [条件查询任务.md](条件查询任务.md) |
| `/mj/task/:id/fetch` | GET | 查询单任务状态 | [查询任务状态.md](查询任务状态.md) |
| `/mj/task/:id/image-seed` | GET | 查询图像种子 | [查询图像种子.md](查询图像种子.md) |

## 错误格式
失败统一返回（HTTP 通常 400，`code=30` 时 429 限流并改写 `description`）：

```json
{
  "description": "<Description> <Result>",
  "type": "upstream_error",
  "code": 24
}
```

`code=30`（上游限流）：HTTP 429，`description` 改写为「当前分组负载已饱和，请稍后再试…」。
