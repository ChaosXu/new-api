---
name: code-to-components
description: 从当前项目的所有代码中归纳组件。当用户提到"归纳组件"、"系统由哪些组件组成"时使用。
---

## 目的

从当前项目的所有代码中归纳出**组件**——即可独立开发、部署、运行的执行单元。产出是一份只包含组件清单的文档，严格按内置模板填写。

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

1. **扫描候选**：从仓库根目录起，列出所有"独立构建单元"——凡是带上述 manifest 的目录都是候选。注意多 module 仓库（一个仓库含多个 `go.mod` / 多个 `package.json` workspace）。
2. **逐条核对**：对每个候选用三条判据逐一检验，重点确认"是否存在运行入口、能否产出独立制品"。**这一步区分模块与组件，仅内部推理。**
3. **剔除非组件**：把单体内部模块、纯库、横向支撑层从候选中剔除（不输出剔除理由）。
4. **按模板产出**：读取 `assets/components.md`，
   - 仅将通过判据的组件填入模板，输出最终文档。
   - 组件命名用仓库内的实际名称（目录名 / module 名 / 制品名），不臆造。
5. **写入文件**：将最终文档写入 `specs/03-ARCH/components.md`。
