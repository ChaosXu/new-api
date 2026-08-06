# 产出物：组件关系（relation.md）

## 是什么

描述组件（容器）之间的关系，回答"这些组件如何协作组成系统"。包含两部分：一张组件关系图（Mermaid）+ 一张组件间交互表。

## 数据源

| 要识别 | 证据来源 |
| --- | --- |
| 编译时关系 | 构建配置：`go:embed`、打包工具的 `bundle`/`extraResources`、`workspaces`、`replace`；产物嵌入产物的情况 |
| 运行时关系 | 各组件 overview 的"边界与依赖"字段；运行入口：子进程 spawn、反向代理配置、同源托管；HTTP/RPC/gRPC 出站调用 |
| 开发态关系 | dev server 代理配置（如 Rsbuild/webpack 的 `proxy`）、`NODE_ENV=development` 分支、开发用占位文件 |

## 怎么做

1. 读取模板 `assets/relation.md`。
2. 画**组件关系图**（Mermaid `graph`/`flowchart`）：
   - 组件用方框 `[]`。
   - 边标注关系类型与方向（如"编译时嵌入""运行时调用""父子进程""托管静态资源"）。
   - 若关系有时机区分（编译时 / 运行时 / 开发态），在边上注明；开发态关系可用虚线 `-.->` 与运行态区分。
3. 填**组件间交互表**：逐对列出有关系的组件，仅列存在直接关系的组件对，不重复罗列无交互的组件。
   - 列：组件 A | 组件 B | 时机（编译时 / 运行时 / 开发态）| 方式（嵌入 / HTTP / 子进程 / 托管 等）| 说明（关系细节）。
4. 命名用 `components.md` 中的实际组件名，不臆造。
5. 删除模板中的 HTML 注释后交付。

## 模板

`assets/relation.md`

## 写入路径

`specs/03-ARCH/L2/relation.md`
