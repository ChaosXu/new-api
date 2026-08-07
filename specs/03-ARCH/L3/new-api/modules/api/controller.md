# 控制器

## 职责

HTTP API 的请求处理器，处理用户、渠道、令牌、日志、计费、订阅、任务、Passkey、io.net 部署、签到、兑换码、上游同步等各业务接口的请求逻辑；含审计 action 模板渲染。

## 契约（开放能力）

- **各资源 CRUD 处理能力**：处理用户/渠道/令牌/日志等资源的增删改查请求。
- **支付下单与回调入账能力**：五个支付网关（EPay/Stripe/Creem/Waffo/Waffo Pancake）的下单与 webhook 回调入账，及管理员手动补单。
- **io.net 部署生命周期处理能力**：部署的创建/查询/延长/删除等请求处理。
- **签到入账能力**：用户每日签到并发放配额。
- **审计 action 渲染能力**：为敏感操作渲染审计动作模板。

## 覆盖代码

`controller/`（全部控制器文件）

> 注：支付网关的 controller handler 与 service 层支付封装（`service/epay.go`、`service/waffo_pancake.go`）协作完成充值与支付流程，详见 [flows/topup-payment.md](../../flows/topup-payment.md)。

## 依赖（内部逻辑模块）

- 业务逻辑（service 全部业务能力）
- 渠道适配框架（渠道测试等直接调用适配器）
- 数据访问
- 鉴权（鉴权中间件、权限授权）
- 配置
