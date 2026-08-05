# 充值兑换

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/user/topup/info` | GET | UserAuth | 获取充值页配置信息 | [获取充值信息.md](获取充值信息.md) |
| `/api/user/topup/self` | GET | UserAuth | 查询当前用户充值记录 | [查询充值记录.md](查询充值记录.md) |
| `/api/user/topup` | POST | UserAuth + CriticalRateLimit | 兑换码兑换额度 | [兑换码兑换.md](兑换码兑换.md) |
| `/api/user/aff_transfer` | POST | UserAuth | 邀请额度转移到可用额度 | [邀请额度转移.md](邀请额度转移.md) |
| `/api/user/topup` | GET | AdminAuth | 管理员查询全部充值记录 | [获取全部充值记录.md](获取全部充值记录.md) |
| `/api/user/topup/complete` | POST | AdminAuth | 管理员手动补单 | [管理员补单.md](管理员补单.md) |
