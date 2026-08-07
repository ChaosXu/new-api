# 钱包与支付

## 职责

用户钱包主页与在线支付核心：余额统计、充值配置读取与金额试算、多支付网关在线支付（支付宝/微信/Stripe/Creem/Waffo/Waffo-Pancake）、兑换码兑换、推广返佣、账单历史。是充值/支付流程的核心承载地。

## 契约（开放能力）

- **钱包余额与配额统计展示能力**：展示当前余额与配额
- **充值配置读取能力**：读取预设金额、折扣、各支付网关开关（`getTopupInfo`）
- **充值金额试算能力**：按普通/Stripe/Waffo/Waffo-Pancake 各自试算应付金额
- **多通道在线支付能力**：发起支付宝/微信、Stripe、Creem、Waffo、Waffo-Pancake 支付并跳转/确认
- **兑换码充值能力**：调用 `redeemTopupCode`（`/api/user/topup`）兑换面值入余额
- **推广返佣能力**：生成推广码、将推广额度转入余额（`transferAffiliateQuota`）
- **账单历史查询能力**：自助与管理员查看全部、完成挂单

## 覆盖代码

`web/src/features/wallet/`（index、api、types、constants、components、hooks）

## 内部子能力

- 余额统计卡片（WalletStatsCard）
- 充值表单卡片（RechargeFormCard：金额/预设/支付方式/兑换码）
- 订阅套餐购买入口卡片（SubscriptionPlansCard，条件渲染，委托订阅管理模块）
- 推广奖励卡片（AffiliateRewardsCard）
- 多支付网关 hooks（use-payment、use-creem-payment、use-waffo-payment、use-waffo-pancake-payment）

## 依赖（内部逻辑模块）

- [HTTP 与认证会话底座](infra/http-auth-base.md)
- [订阅套餐管理](billing/subscriptions.md)
- [通用工具库](infra/utils.md)（货币格式化与三方换算）
