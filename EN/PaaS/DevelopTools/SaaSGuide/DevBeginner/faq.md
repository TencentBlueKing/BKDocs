# 常见问题
## IDE 有哪些推荐

比如 `Visio Studio Code`
![Visio_Studio_Code](../assets/Visio_Studio_Code.png)

- 语言设置为中文
    - macOS: `Command+Shift+P` 选择 `Configure Display Language`
    - Windows: `Ctrl+Shift+P` 选择 `Configure Display Language`

- 记住 git 账号

```bash
git config --global credential.helper store
```

## 如何隔离多套开发环境

通过[pipenv](https://zhuanlan.zhihu.com/p/37581807)，在本地隔离多套开发环境
![pipenv](../assets/pipenv.png)

- 进入 `pipenv` 环境没有加载用户环境变量如何处理？

    可以修改通过 `pipenv shell` 进入虚拟环境时提示的 `activate` 文件，在该文件中追加对应的命令即可

    例如新增如下一行，可以使用 `ll` 查看文件列表.

    ```bash
    alias ll="ls -lh"
    ```

详细方案可参考[python 多环境开发方案](../DevBasics/PYTHON2_3.md)。
