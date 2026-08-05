# 强制GC
> `POST /api/performance/gc`
- **鉴权**：RootAuth（超级管理员）
- **用途**：强制触发 Go 垃圾回收。

## 请求
无

## 响应
| 字段 | 类型 | 说明 |
| --- | --- | --- |
| success | bool | 是否成功 |
| message | string | 成功提示 |

示例：
```json
{ "success": true, "message": "GC 已执行" }
```

## 错误码
无
