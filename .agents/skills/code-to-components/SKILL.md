---
name: code-to-components
description: 从当前项目的所有代码中归纳组件。当用户提到"归纳组件"、"系统由哪些组件组成"时使用。
---

## 目的

从当前项目的所有代码中识别出**组件**——即可独立开发、部署、运行的执行单元（C4 模型的 Level 2：Container）。

本 skill 负责**组件识别**（判定哪些是组件、哪些不是），识别完成后产出四份文档：

| 产出物 | 说明 | 如何做 |
| --- | --- | --- |
| `components.md` | 组件清单表（每行一个组件：组件名、路径、一句话职责） | 见 `references/components.md` |
| `{组件名}/overview.md` | 每个组件的详情（技术栈 / 构建部署 / 制品形态 / 对外功能 / 边界与依赖） | 见 `references/overview.md` |
| `relation.md` | 组件之间的关系（关系图 + 交互表） | 见 `references/relation.md` |
| `deployment.md` | 系统的部署形态（涉及组件 / 打包 / 运行 / 组件间连接） | 见 `references/deployment.md` |

四份产出均严格按对应模板（`assets/<name>.md`）填写。本 SKILL.md 只讲**组件识别**；每份产出物的具体数据源、步骤、模板与写入路径，按需读取对应 `references/<产出物名>.md`。

## 关键概念

### 组件定义

**组件**：系统中可独立开发、部署、运行的执行单元。

三条判据**必须同时满足**，缺一不可：

1. **可独立开发**：拥有自己的构建配置 / manifest，无需宿主应用的编译上下文即可单独构建。
   - 例如：独立 `go.mod`、`package.json`、`pom.xml`/`build.gradle`、`Cargo.toml`、`pyproject.toml`、`Dockerfile`、`Makefile`、`build.sh` 等。
2. **可独立部署运行**：产出可独立运行的制品（可执行二进制、可独立托管的静态站点、可打包的桌面/移动应用、容器镜像等）。
   - 关键判据：**是否存在运行入口**。例如：`package main` + `main()`、`if __name__ == "__main__"`、`public static void main`、`package.json` 的 `bin` 字段、可执行产物目录、静态站点产物目录（`dist`/`build`/`out`/`public`）。
   - **纯库不算组件**：即使有独立 manifest，若没有运行入口、只被宿主以 import/require 方式消费，则不是组件。
3. **对外明确功能**——对外提供清晰、可观测的能力（HTTP 服务、CLI、桌面 GUI、独立可访问的前端站点等），而非仅作为内部依赖被调用。

### 反模式（这些不是组件）

| 误判对象 | 为何不是组件 |
| --- | --- |
| 单体内部业务功能域（请求处理链路、计费、鉴权、订单等） | 编译进同一制品，不可独立部署运行 |
| 独立 library / module（有独立 manifest 但无入口，被宿主 import） | 满足"独立开发"，但不满足"独立部署运行" |
| 横向支撑层（路由、中间件、公共工具、类型定义、配置） | 不对外独立提供功能，只是被复用的内部代码 |
| 同一应用按层拆分的"前端层/后端层"内部的子目录 | 若不能脱离该层独立部署，则只是模块 |

判定时常见的陷阱：**"有独立 `go.mod`/`package.json`" 不等于 "是组件"**。必须进一步确认它有运行入口、能产出独立制品。

## 输出范围控制（重要）

- **不要把内部推理作为产出**: 为了判定组件，通常需要先识别仓库内的模块/功能域，并区分"模块 vs 组件"。
- **不要在产出中输出**: 系统层归纳、模块清单、功能域分析、判定推理过程、被排除项的列表。读者只看到组件。

## 数据源（判定证据）

按"要判定什么 → 去哪里找证据"组织。跨技术栈通用：

| 判据 | 证据来源示例 |
| --- | --- |
| 独立构建 | 各级目录的 manifest：`go.mod`（多 module Go）、`package.json`（含 `workspaces`）、`pom.xml`/`build.gradle`、`Cargo.toml`、`pyproject.toml`/`setup.py`、`Dockerfile`、`Makefile`、`build.sh` |
| 独立运行 | 运行入口：`package main`+`func main`、`if __name__ == "__main__"`、`public static void main`、`#[tokio::main]`、`package.json` 的 `bin`/`scripts.start`；产物目录：`dist`/`build`/`out`/`public`；打包配置：Electron `main.js`+`package.json`、Android `build.gradle`、iOS `*.xcodeproj` |
| 依赖边界 | Go `replace`/`require`、npm `dependencies`/`devDependencies`/`workspaces`、Maven `<dependencies>`、模块间 import 关系；判断某候选是"被宿主 import 的库"还是"独立运行的制品" |

## 工作流程

### 第一步：识别组件

1. **扫描候选**：从仓库根目录起，列出所有"独立构建单元"——凡是带上述 manifest 的目录都是候选。注意多 module 仓库（一个仓库含多个 `go.mod` / 多个 `package.json` workspace）。
2. **逐条核对**：对每个候选用三条判据逐一检验，重点确认"是否存在运行入口、能否产出独立制品"。**这一步区分模块与组件，仅内部推理。**
3. **剔除非组件**：把单体内部模块、纯库、横向支撑层从候选中剔除（不输出剔除理由）。

识别完成后，得到一份组件清单（组件名、路径、职责），作为后续四份产出物的共同输入。

### 第二步：按产出物逐项填写

针对四份产出物，分别读取对应的 reference 文件，按其中的数据源、步骤、模板与写入路径执行：

- 组件清单 → 读取 `references/components.md`
- 组件详情 → 读取 `references/overview.md`
- 组件关系 → 读取 `references/relation.md`
- 部署拓扑 → 读取 `references/deployment.md`

四份产出物共用第一步识别出的组件清单，互相之间不再重复识别组件。
