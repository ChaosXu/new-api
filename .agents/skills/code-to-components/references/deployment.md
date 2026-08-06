# 产出物：组件部署（{组件名}/deployment.md）

## 是什么

从**某一个组件的视角**，描述它在各部署形态中如何被打包、运行、与其他组件连接。**只描述涉及本组件的部署形态**，每种形态聚焦本组件的打包/运行/连接方式。

每个组件各产出一份，放在该组件自己的目录下。

## 数据源

部署描述文件（按需查找存在的那些）：

| 证据 | 来源 |
| --- | --- |
| 容器化部署 | `Dockerfile`、`docker-compose.yml`、镜像构建脚本、CI 镜像构建配置 |
| 桌面/移动打包 | 打包配置（Electron `package.json` 的 `build` / `extraResources`、Android `build.gradle`、iOS `*.xcodeproj`）、CI 打包配置 |
| 前端独立托管 | 静态托管配置（如 `netlify.toml`、SPA fallback）、API 地址策略（`baseURL` / 环境变量）、反向代理规则 |
| 裸机/systemd | `Makefile`、systemd unit（`*.service`）、启动脚本、README 部署章节 |
| 编排/平台 | Kubernetes manifests、Helm chart、PaaS 配置（若存在） |

## 怎么做

1. 读取模板 `assets/deployment.md`。
2. 扫描上述部署描述文件，筛出**涉及本组件**的部署形态。
3. 为每种形态填一个小节：
   - 标题为形态名（如"容器化单体""桌面应用""前端独立托管""裸机/systemd"）。
   - 列：打包方式（本组件如何被打）| 运行方式（本组件如何跑）| 与其他组件的连接（同源 / 子进程 / 反代回源 等）。
4. 若本组件在多种形态间有共性（如同一构建产物被复用、配置项可降级），在末尾"跨形态共性"节归纳；若无共性可省略。
5. 命名用 `components.md` 中的实际组件名。
6. 删除模板中的 HTML 注释后交付。

## 模板

`assets/deployment.md`

## 写入路径

`specs/03-ARCH/L2/{组件名}/deployment.md`
