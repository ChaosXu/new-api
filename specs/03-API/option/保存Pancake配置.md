# 保存Pancake配置
> `POST /api/option/waffo-pancake/save`
- **鉴权**：RootAuth（超级管理员）
- **用途**：保存 Pancake 网关配置（商户、私钥、回跳、店铺、产品）。

## 请求
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| merchant_id | string | 是 | 商户 ID |
| private_key | string | 是 | 私钥 |
| return_url | string | 是 | 回跳地址 |
| store_id | string | 是 | 店铺 ID |
| product_id | string | 是 | 产品 ID |

示例：
```json
{ "merchant_id": "M1", "private_key": "K1", "return_url": "https://...", "store_id": "S1", "product_id": "P1" }
```

## 响应
非标准信封：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| message | string | `success` / `error` |
| data | string | 成功提示或错误描述 |

示例：
```json
{ "message": "success", "data": "保存成功" }
```

## 错误码
| HTTP | message | 说明 |
| --- | --- | --- |
| 200 | 参数错误 | 请求体解析失败 |
| 200 | 保存配置失败 | 持久化失败 |
