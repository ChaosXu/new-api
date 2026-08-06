# 产出物：部署拓扑（deployment.md）

## 是什么

从部署描述文件归纳系统的部署形态，每种形态说明：涉及组件、打包方式、运行方式、组件间连接。末尾可附跨形态共性。

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
2. 扫描上述部署描述文件，归纳出几种**部署形态**。形态数量与划分由代码中的部署证据决定，不预设固定分类。
3. 为每种形态填一个小节：
   - 标题为形态名（如"容器化单体""桌面应用""前端独立托管""裸机/systemd"）。
   - 列：涉及组件 | 打包方式 | 运行方式 | 组件间连接（同源 / 子进程 / 反代回源 等）。
4. 若多种形态共享同一运行核心或可降级项（如同一二进制、数据层可降级、缓存可选、多节点需共享密钥），在"跨形态共性"节归纳；若无共性可省略该节。
5. 命名用 `components.md` 中的实际组件名。
6. 删除模板中的 HTML 注释后交付。

## 模板

`assets/deployment.md`

## 写入路径

`specs/03-ARCH/L2/deployment.md`
