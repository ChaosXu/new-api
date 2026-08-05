# ratio-sync 倍率同步端点（超级管理员）

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/ratio_sync/channels` | GET | RootAuth | 获取可同步渠道列表 | [可同步渠道列表.md](可同步渠道列表.md) |
| `/api/ratio_sync/fetch` | POST | RootAuth | 拉取上游倍率并比对差异 | [拉取上游倍率.md](拉取上游倍率.md) |
