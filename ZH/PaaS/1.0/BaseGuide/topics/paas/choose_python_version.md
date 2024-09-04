# 自定义 Python 版本

## 背景

自从 Python 官方宣布 EOL 计划，Python2 的生命周期即将终结于 2020 年 1 月 1 日，意味着在 2020 年以后 Python2 将不会有官方的支持和修复。
最近的几年里，Python 主流库都做了很多兼容的工作，以帮助我们从 Python2 迁移到 Python3，但是这类的兼容性代码会消耗相当大的人力和性能。
事实上，这种兼容的工作已经在不同程度上停止了，比如 Django 2.0 已宣布不再支持 Python2，可以预见的是，2020 年之后，基本上不会有库再会处理兼容问题了，这个网站列出了部分库的支持时间表：[https://python3statement.org/](https://python3statement.org/)。

## 如何选择 Python 版本

目前，蓝鲸 PaaS3.0 开发者中心所有新建应用均使用 **Python 3.6** 版本。如果你想切换到其他 Python 版本，请参考下面的操作说明。

如需更改 Python 版本，需要开发者在 **App 根目录下** 添加`runtime.txt`文件，并在其中写上自定义版本号，平台会根据这个版本号选择 Python 版本，例如：

```bash
# runtime.txt

python-3.6.12
```

然后提交到**版本仓库**，部署后即可使用 Python-3.6.12 了，Enjoy！

## 目前支持的 Python 版本

具体 Python 版本支持和基础镜像有关，请确认应用的环境配置：

> 应用引擎 -> 环境配置 -> 自定义运行时

以下是已有的镜像支持的版本列表：

```
python-2.7.16
python-2.7.17
python-2.7.18
python-3.6.6
python-3.6.7
python-3.6.8
python-3.6.9
python-3.6.12
python-3.7.0
python-3.7.2
python-3.7.4
python-3.7.6
python-3.7.7
python-3.7.8
python-3.7.9
python-3.8.0
python-3.8.2
python-3.8.4
python-3.8.6
python-3.10.5
python-3.10.6
python-3.10.7
python-3.10.8
python-3.10.9
```