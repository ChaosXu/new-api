# option 系统设置端点（超级管理员）

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/option/` | GET | RootAuth | 获取全部系统设置（过滤敏感项） | [获取系统设置.md](获取系统设置.md) |
| `/api/option/` | PUT | RootAuth | 更新单个系统设置 | [更新系统设置.md](更新系统设置.md) |
| `/api/option/payment_compliance` | POST | RootAuth | 确认支付合规声明 | [确认支付合规.md](确认支付合规.md) |
| `/api/option/channel_affinity_cache` | GET | RootAuth | 渠道亲和缓存统计 | [渠道亲和缓存统计.md](渠道亲和缓存统计.md) |
| `/api/option/channel_affinity_cache` | DELETE | RootAuth | 清除渠道亲和缓存 | [清除渠道亲和缓存.md](清除渠道亲和缓存.md) |
| `/api/option/rest_model_ratio` | POST | RootAuth | 重置模型倍率为默认值 | [重置模型倍率.md](重置模型倍率.md) |
| `/api/option/waffo-pancake/catalog` | GET | RootAuth | 拉取 Pancake 商品目录 | [Pancake目录.md](Pancake目录.md) |
| `/api/option/waffo-pancake/pair` | POST | RootAuth | 创建 Pancake 网关配对 | [创建Pancake配对.md](创建Pancake配对.md) |
| `/api/option/waffo-pancake/save` | POST | RootAuth | 保存 Pancake 配置 | [保存Pancake配置.md](保存Pancake配置.md) |
| `/api/option/waffo-pancake/subscription-product` | POST | RootAuth | 创建 Pancake 订阅套餐产品 | [创建订阅产品.md](创建订阅产品.md) |
| `/api/option/waffo-pancake/subscription-product-options` | GET | RootAuth | 拉取可用订阅产品选项 | [订阅产品选项.md](订阅产品选项.md) |
