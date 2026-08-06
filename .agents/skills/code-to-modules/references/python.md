# Python 技术栈规则

适用范围：组件根目录下存在 `pyproject.toml` / `requirements.txt` / `Pipfile`。本文件被 SKILL.md 在识别到 Python 技术栈时按需读取，提供 Python 专属的**数据源**、**粒度规则**和**排除项补充**。通用概念（模块定义、内部/导入划分原则、通用排除项）见 SKILL.md。

## 数据源

| 类别 | 证据来源 |
| --- | --- |
| 内部模块 | 含 `__init__.py` 的包目录，或含 `*.py` 的源码目录。 |
| 导入模块 | `pyproject.toml` 的 `[project.dependencies]` / `requirements.txt` / `Pipfile`。 |

## 粒度规则

- 每个含 `*.py` 的包目录（含 `__init__.py`）一个内部模块，列到叶子粒度，不合并、不折叠。

## 排除项（Python 特定补充）

除 SKILL.md 的通用排除项外，Python 还需排除：

- 虚拟环境目录（`.venv/` / `venv/` / `env/`）。
- 构建产物目录（`dist/` / `build/` / `*.egg-info/`）。
