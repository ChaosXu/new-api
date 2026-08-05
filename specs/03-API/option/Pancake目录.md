# Pancake目录
> `GET /api/option/waffo-pancake/catalog`
- **鉴权**：RootAuth（超级管理员）
- **用途**：使用指定（或已保存）的 Pancake 凭证拉取商品目录。

## 请求
Query 参数（可覆盖已保存凭证）：
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| merchant_id | string | 否 | 商户 ID；不传则用已保存凭证 |
| private_key | string | 否 | 私钥；不传则用已保存凭证 |

示例：`GET /api/option/waffo-pancake/catalog?merchant_id=M1&private_key=K1`

## 响应
非标准信封：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| message | string | `success` / `error` |
| data | object/array | 目录数据；失败时为错误描述 |

示例：
```json
{ "message": "success", "data": [] }
```

## 错误码
| HTTP | message | 说明 |
| --- | --- | --- |
| 200 | Waffo Pancake 凭证未配置 | 未提供且无已保存凭证 |
| 200 | 拉取目录失败 | 调用 Pancake 失败 |
