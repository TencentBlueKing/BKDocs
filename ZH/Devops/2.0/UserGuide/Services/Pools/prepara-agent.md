# 私有构建机环境准备

BKCI 流水线的插件，是由官方或第三方开发者提供。插件开发语言支持 Java、Python、NodeJs 或 Golang，执行时对环境有所依赖。 私有构建机导入 BKCI 作为流水线执行机之前，需先准备好环境，以免流水线执行失败。

## 准备 Python 插件执行环境
研发商店支持开发 python 插件，如果想在你的构建机上能正常运行 python 插件，需要进行如下设置：

* 安装 python
  * 鉴于 python2 即将不提供服务，建议安装 python3.6
  * 插件需能兼容 python2 和 python3，所以执行环境安装的 python 版本影响不大
* 安装最新版本的 pip 工具
*   若企业内部有专用的 pip 源，请设置 pip 源

    ```
    index-url = <内部pip源>
    extra-index-url = <备用pip源>
    timeout = 600

    [install]
    trusted-host = <pip源的host>
    ```

    * 配置步骤（以 Linux 为例）
      *   以安装 BKCI Agent 的用户身份登录机器

          > 配置 pip 的用户，和启动 BKCI Agent 的用户需一致，否则配置不生效。 执行 ps -ef |grep devops 命令确认启动 BKCI Agent 的用户
      * vi \~/.pip/pip.conf，将上述配置添加进去，注意换行符不能是\r
      * 保存配置
      * 重启 BKCI Agent

## 准备 Nodejs 插件执行环境
研发商店支持开发 NodeJS 插件，如果想在你的构建机上能正常运行 NodeJS 插件，需要进行如下设置：

*   安装 NodeJS

    > 建议安装[node LTS 版本](https://nodejs.org/en/download/)，支持更多 es 特性
*   若企业内部有专用的 npm 源，配置 npm 仓库为内网版本

    ```
      npm config set registry <内网npm仓库地址>
    ```

