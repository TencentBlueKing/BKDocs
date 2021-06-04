# Python 插件执行环境

研发商店支持开发 python 插件，如果想在你的构建机上能正常运行 python 插件，需要进行如下设置：

- 安装 python
  - 鉴于 python2 即将不提供服务，建议安装 python3.6
  - 插件需能兼容 python2 和 python3，所以执行环境安装的 python 版本影响不大
- 安装最新版本的 pip 工具
- 若企业内部有专用的pip源，请设置 pip 源

    ```[global]
    index-url = <内部pip源>
    extra-index-url = <备用pip源>
    timeout = 600

    [install]
    trusted-host = <pip源的host>
    ```

  - 配置步骤（以 Linux 为例）
    - 以安装bk-ci Agent 的用户身份登录机器
      > 配置 pip 的用户，和启动bk-ci Agent 的用户需一致，否则配置不生效。
      > 执行 ps -ef |grep devops 命令确认启动bk-ci Agent 的用户
    - vi ~/.pip/pip.conf，将上述配置添加进去，注意换行符不能是\r\n
    - 保存配置
    - 重启bk-ci Agent
