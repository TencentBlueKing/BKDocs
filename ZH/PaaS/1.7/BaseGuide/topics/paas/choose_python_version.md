# 自定义 Python 版本

目前，蓝鲸开发者中心所有新建应用默认为 **Python 3.10** 版本。如果你想切换到其他 Python 版本，请参考下面的操作说明。

如需更改 Python 版本，需要开发者在应用构建目录（未设置则默认为根目录）下添加`runtime.txt`文件，并在其中写上自定义版本号，平台会根据这个版本号选择 Python 版本，例如：

```bash
# runtime.txt

python-3.6.12
```

然后提交到**代码仓库**，部署后即可使用 Python-3.6.12 了，Enjoy！

## 目前支持的 Python 版本

以下是社区版本默认支持的版本列表：

```
python-2.7.18
python-3.6.8
python-3.6.12
python-3.10.5
```

## Python 多版本维护

平台管理员可以在蓝鲸制品库的 bkpaas 项目下的 `bkpaas3-platform-assets/runtimes/python` 目录下查看当前环境所有支持的 Python 版本。

如果需要其他 Python 版本也可以参考 [上传 PaaS runtimes 到制品库](https://bk.tencent.com/docs/markdown/ZH/DeploymentGuides/7.1/paas-upload-runtimes.md)上传。

![查看可用的 Python 版本](../../assets/images/available_python_versions.png)
