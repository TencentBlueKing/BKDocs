## bkui init 命令

`bkui init` 是 `BKUI-CLI` 的重要命令之一。通过前面的章节我们知道，任何命令带 `-h` 或 `--help` 参数时，都会输出当前命令的帮助信息。命令行输入 `bkui init -h`，`bkui init` 命令的帮助信息如下图：

![help-init](../pictures/bkui-help-init.png)

`bkui init` 命令支持一个可选参数 `DIRECTORY_NAME`，表示要创建项目的名称。

- 如果不设置 `DIRECTORY_NAME` ，那么默认会在当前命令行执行目录下初始化项目，项目的名称就是当前目录的名称；
- 如果设置了 `DIRECTORY_NAME`，那么会在当前命令行执行目录下创建 `DIRECTORY_NAME` 并在 `DIRECTORY_NAME` 目录里生成项目模板，项目的名称就是 `DIRECTORY_NAME`。

`bkui init` 命令执行过程中，会采用交互问答的形式向使用者提出几个问题，获取答案作为初始化项目的参数，[接下来我们分别解释这几个问题的作用](./question-explain.md)。
