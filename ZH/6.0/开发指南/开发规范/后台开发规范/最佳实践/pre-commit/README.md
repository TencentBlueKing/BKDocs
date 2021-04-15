## 1. 背景

为了尽早发现代码问题，防止不符合规范的代码提交到仓库，强烈推荐每位开发者配置 `pre-commit` 代码提交前检查

## 2. Git Hooks 本地配置

`pre-commit` 检查通过本地配置实现，因此每个开发者在开发之前都必须先配好本地的 Git Hooks。

推荐使用 [pre-commit](https://pre-commit.com/) 框架对 Git Hooks 进行配置及管理。**pre-commit**是由 python 实现的，用于管理和维护多个 pre-commit hooks 的实用框架。它提供了插件式的管理机制，并拥有大量的官方与第三方插件（需要时可自行开发），能够快速实现常见的代码检查任务，如 `eslint` 检查（支持跨语言），`flake8` 检查，`isort` 代码美化等。

### 配置方式 (新接入项目)

1. 使用 pip 安装 pre-commit

```bash
# pip
pip install pre-commit
```

2. 在有.git 的项目配置 pre-commit

```bash
pre-commit install
```

执行后，查看 `.git/hooks` 目录，若存在名为 `pre-commit` 新文件，则配置成功 。

### 触发 Git Hooks

- pre-commit 代码检查无需手动触发，只要执行 `git commit` 命令，就会自动触发（无论是在终端还是 IDE）。请注意，代码检查的范围只是本次提交所修改的文件，而非全局。

- 若代码检查不通过，提交会被中断。可以根据具体的错误信息去调整代码，只有所有的检查项全部通过方可 push。

- 配置 `pre-commit` 后，第一次执行 `git commit` 命令时会联网下载所需的插件依赖，大概需要一分钟的时间，请耐心等待。

## 3 . 常用插件说明

### pyupgrade

提升 Python 代码风格

https://github.com/asottile/pyupgrade

### python-modernize

**【Python2 项目专用】** 将 python2 风格代码自动转换为 2-3 兼容风格。 **Python3 项目无需安装此插件**

https://python-modernize.readthedocs.io/en/latest/fixers.html#

### check-merge-conflict

通过匹配 conflict string，检查是否存在没有解决冲突的代码

### isort

自动调整 python 代码文件内的 import 顺序

若该项结果为 `failed`，通过 `git diff` 查看自动调整的地方，确认无误后，重新 `git add` 和 `git commit` 即可

### seed-isort-config

提升 isort 排序的准确度，会在项目根目录下生成 `.iosrt.cfg` 配置文件，需要提交

### autopep8

根据 `.flake8` 给出的配置自动调整 python 代码风格。

若该项结果为 `failed`，通过 `git diff` 查看自动调整的地方，确认无误后，重新 `git add` 和 `git commit` 即可

### flake8

根据 `.flake8` 给出的配置检查代码风格。

若该项结果为 `failed`，需要根据给出的错误信息手动进行调整。（autopep8 会尽可能地把能自动修复的都修复了，剩下的只能手动修复）

关于 flake8 规则代码与具体示例，可查阅 https://lintlyci.github.io/Flake8Rules/

## 4. 已知问题

1. isort 排序不准

    解决方案：在 `.pre-commit-config.yaml` 中去掉 `seed-isort-config` 配置，然后自行修改 `.isort.cfg`

2. Stackless 版本的 Python 可能无法使用 pre-commit
