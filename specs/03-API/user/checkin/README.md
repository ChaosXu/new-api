# 签到 API

> 路由前缀：`/api/user/checkin`，挂在 `selfRoute(UserAuth)` 下。执行签到附加 `TurnstileCheck`。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [查询签到状态.md](./查询签到状态.md) | GET | `/api/user/checkin` | 查询功能配置 + 指定月份签到统计 |
| [执行签到.md](./执行签到.md) | POST | `/api/user/checkin` | 每日签到并奖励额度 |
