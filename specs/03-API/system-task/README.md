# system-task 系统任务端点（超级管理员）

| 端点 | 方法 | 鉴权 | 用途 | 文件 |
| --- | --- | --- | --- | --- |
| `/api/system-task/log-cleanup` | POST | RootAuth | 创建日志清理任务 | [创建日志清理任务.md](创建日志清理任务.md) |
| `/api/system-task/list` | GET | RootAuth | 获取任务列表 | [任务列表.md](任务列表.md) |
| `/api/system-task/current` | GET | RootAuth | 查询某类型当前活跃任务 | [当前任务.md](当前任务.md) |
| `/api/system-task/:task_id` | GET | RootAuth | 查询任务详情 | [任务详情.md](任务详情.md) |
