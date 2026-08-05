# Verification API

> 路由前缀：`/api`，无登录鉴权；均叠加限流 + Turnstile 人机校验中间件。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [发送邮箱验证码](./发送邮箱验证码.md) | GET | /api/verification | 发送 6 位注册验证码邮件（EmailVerificationRateLimit + Turnstile） |
| [发送密码重置邮件](./发送密码重置邮件.md) | GET | /api/reset_password | 发送密码重置链接邮件（CriticalRateLimit + Turnstile） |
