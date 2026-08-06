# 产出物：组件详情（overview.md）

## 是什么

每个组件一份详情文档，承载该组件的技术细节：技术栈 / 构建部署方式 / 制品形态 / 对外功能 / 边界与依赖。每个组件单独一个文件，放在以组件名命名的子目录下。

## 数据源

| 字段 | 证据来源 |
| --- | --- |
| 仓库路径 | 组件清单（components.md）的"路径"列 |
| 技术栈 | 组件根目录的 manifest（`go.mod` / `package.json` / `pom.xml` / `Cargo.toml` / `pyproject.toml` 等） |
| 构建 / 部署方式 | 构建脚本、`Dockerfile`、`Makefile`、`package.json` 的 `scripts`、CI 配置 |
| 制品形态 | 构建产物（可执行二进制 / 静态站点目录 / 桌面应用包 / 容器镜像 / CLI） |
| 对外功能 | 运行入口、对外接口（HTTP 端点 / CLI 命令 / GUI）、README |
| 边界与依赖 | 与其他组件/宿主的关系：编译时嵌入（`go:embed` / `bundle`）、运行时调用、父子进程、共享 manifest（`workspaces` / `replace`） |

## 怎么做

1. 读取模板 `assets/overview.md`。
2. 为组件清单中的**每个组件**各填一份：
   - 文件标题为组件名（仓库内的实际名称）。
   - 字段照模板填写，命名用实际名称，不臆造。
   - "边界与依赖"字段描述该组件与其他组件/宿主的关系（这些关系会在 `relation.md` 中集中展开）。
3. 删除模板中的 HTML 注释后交付。

## 模板

`assets/overview.md`

## 写入路径

`specs/03-ARCH/L2/{组件名}/overview.md`（目录不存在则创建）。组件详情通过同名 `{组件名}` 子目录与组件清单关联，不在清单表中放置详情链接。
