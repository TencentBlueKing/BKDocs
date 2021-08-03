# 安装 节点管理 详解

节点管理原本是直接使用 S-mart SaaS 部署，由于性能和功能的要求，改为 SaaS + 后台独立部署的方式。


## 配置节点管理

节点管理的配置相对比较复杂，容易混淆地方先说明一下：

S-mart SaaS 的应用名（APP_CODE）是 `bk_nodeman`，PaaS 为它分配的正式环境数据库名也是 `bk_nodeman`

节点管理后台和 SaaS 必须公用同一个数据库实例。这是第一个依赖。

其次是 RabbitMQ，前后台分别独立使用不同的 RabbitMQ vhost 和账号密码。S-mart SaaS 使用的是 `bk_nodeman` 的 vhost 和账户。
后台使用的 `bk_bknodeman` 的 vhost 和账户

后台使用的 app_code 和 SaaS 保持一致，都是 bk_nodeman，但 app_secret 是后台部署时生成的，和 SaaS 自动分配的 secret 并不一致（但不影响鉴权）。

## 安装节点管理

节点管理 SaaS 先安装，并对数据库（bk_nodeman）做初始化。

接着安装后台：

```bash
./bkcli sync nodeman
./bkcli install nodeman
./bkcli initdata nodeman
./bkcli start nodeman
```

说明：

1. 安装 nodeman(api) 的 Python 工程：`/data/install/bin/install_bknodeman.sh -e /data/install/bin/04-final/bknodeman.env -s /data/src -p /data/bkce --python-path /opt/py36_e/bin/python3.6 -b $LAN_IP -w $WAN_IP`
2. 注册权限模型
3. 安装节点管理使用的 Nginx 和 配套的 consul-template
4. 初始化节点管理（initdata nodeman）

    - 将节点管理安装 agent 的脚本工具拷贝到 nginx 对应的目录下
    - 生成 gse_client 的安装包并推送到 节点管理 nginx 对应的目录下
    - 拷贝官方的 gse 插件包到节点管理 nginx 对应目录下，并执行初始化插件的脚本注册插件到数据库和 GSE 中
    - 同步 python 解释器包到节点管理 nginx 对应目录下，安装 Proxy 下的 p-agent 需要在 Proxy 机器上运行 Python 脚本

5. 启动进程