# 创建Pancake配对
> `POST /api/option/waffo-pancake/pair`
- **鉴权**：RootAuth（超级管理员）
- **用途**：使用凭证创建 Pancake 网关配对（绑定），返回配对结果。

## 请求
| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| merchant_id | string | 是 | 商户 ID |
| private_key | string | 是 | 私钥 |
| return_url | string | 是 | 回跳地址 |

示例：
```json
{ "merchant_id": "M1", "private_key": "K1", "return_url": "https://site.example.com/wallet" }
```

## 响应
非标准信封：
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| message | string | `success` / `error` |
| data | object | 配对结果；失败时为错误描述 |

示例：
```json
{ "message": "success", "data": {} }
```

## 错误码
| HTTP | message | 说明 |
| --- | --- | --- |
| 200 | 参数错误 | 请求体解析失败 |
| 200 | Waffo Pancake 凭证未配置 | 缺少凭证 |
| 200 | （data 携带错误） | 网关返回错误 |
