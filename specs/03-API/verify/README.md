# Verify API

> 路由前缀：`/api/verify`，UserAuth + CriticalRateLimit + DisableCache。用于敏感操作的二次安全验证并签发 proof_token。

## 端点清单

| 文件 | 方法 | 路径 | 用途 |
|---|---|---|---|
| [通用安全验证](./通用安全验证.md) | POST | /api/verify | 2FA 二次验证，签发一次性 proof_token（scope 限 channel.key.read / passkey.register / passkey.delete） |
