# 产出物：组件清单（components.md）

## 是什么

一份组件清单表，每行一个组件，仅含组件名、路径、一句话职责，不含技术细节。它是其余三份产出物（overview / relation / deployment）的共同输入——后者都引用这里的组件名。

## 数据源

- SKILL.md 第一步识别出的组件清单（组件名、路径、职责）。

## 怎么做

1. 读取模板 `assets/components.md`。
2. 把识别出的每个组件填入表格一行：
   - **组件名**：仓库内的实际名称（目录名 / module 名 / 制品名），不臆造。
   - **路径**：相对于仓库根的路径。
   - **组件说明**：一句话职责，不含技术细节。
3. 删除模板中的 HTML 注释后交付。

## 模板

`assets/components.md`

## 写入路径

`specs/03-ARCH/L2/components.md`
