# OpenAI 兼容计费端点

OpenAI 兼容的计费/用量查询端点，供客户端按 OpenAI 旧版 billing API 习惯读取额度与用量。见 `controller/billing.go`、`router/dashboard.go`。

## 鉴权
全部端点：`TokenAuth`（经过 `GlobalAPIRateLimit` 与 `CORS` 中间件，RouteTag=`old_api`）。

## 额度来源
- 开启 `DisplayTokenStatEnabled` 时：按令牌统计（`token.RemainQuota` / `token.UsedQuota`，`access_until` 取令牌过期时间）。
- 否则：按用户统计。
- 额度单位换算遵循 `operation_setting.GetQuotaDisplayType()`：
  - `USD`：`amount / QuotaPerUnit`
  - `CNY`：`amount / QuotaPerUnit * USDExchangeRate`
  - `Tokens`：保持 tokens 原值
- 令牌为无限额度（`UnlimitedQuota`）时，`hard_limit_usd` 等返回 `100000000`。

## 端点列表

| 端点 | 方法 | 用途 | 文件 |
| --- | --- | --- | --- |
| `/dashboard/billing/subscription` | GET | 计费订阅 | [计费订阅.md](计费订阅.md) |
| `/v1/dashboard/billing/subscription` | GET | 计费订阅（v1 别名） | [计费订阅v1.md](计费订阅v1.md) |
| `/dashboard/billing/usage` | GET | 计费用量 | [计费用量.md](计费用量.md) |
| `/v1/dashboard/billing/usage` | GET | 计费用量（v1 别名） | [计费用量v1.md](计费用量v1.md) |

## 错误格式
失败时仍返回 HTTP 200，body 为 OpenAI 风格错误：
```json
{ "error": { "message": "...", "type": "upstream_error" } }
```
