# subscription 订阅端点

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/subscription/plans` | GET | UserAuth | 获取启用的订阅计划列表（需合规） | [订阅计划列表.md](订阅计划列表.md) |
| `/api/subscription/self` | GET | UserAuth | 查询当前用户订阅与计费偏好 | [当前用户订阅.md](当前用户订阅.md) |
| `/api/subscription/self/preference` | PUT | UserAuth | 更新计费偏好 | [更新计费偏好.md](更新计费偏好.md) |
