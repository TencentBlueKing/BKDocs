## 标准部署

>**部署说明：**请严格 按顺序执行 以下操作完成蓝鲸智云社区版基础包的安装，以下步骤若有报错/失败，需要根据提示修复错误后，在重新执行相同的命令（支持断点续装）。

**每一个步骤执行如果有报错，需要修复错误，保证安装成功后，才可以继续**。因为安装顺序是有依赖关系的，如果前面的平台失败扔继续往下安装，会遇到更多的报错导致整体安装失败。


修复错误所需要了解的相关命令，请参考 [维护文档](../../维护手册/日常维护/maintain.md)。

```bash
cd /data/install

# 安装 PaaS 平台及其依赖服务，该步骤完成后，可以打开 PaaS 平台。
./bk_install paas

# 安装配置平台及其依赖服务，该步骤完成后，可以打开配置平台，看到蓝鲸业务及示例业务。
./bk_install cmdb  

# 该步骤完成后，可以打开作业平台，并执行作业。同时在配置平台中可以看到蓝鲸的模块下加入了主机。
# 安装作业平台及其依赖组件，并在安装蓝鲸的服务器上装好 gse_agent 供验证。
./bk_install job

# 部署正式环境及测试环境
# 该步骤完成后可以在开发者中心的服务器信息和第三方服务信息中看到已经成功激活的服务器
# 同时也可以进行 SaaS 应用(除蓝鲸监控和日志检索)的上传部署
./bk_install app_mgr

# 安装蓝鲸数据平台基础模块及其依赖服务。安装该模块后，可以开始安装使用 SaaS 应用: 蓝鲸监控和日志检索
./bk_install bkdata

# 安装故障自愈的后台模块及依赖其服务
# 安装该模块后，可以开始安装使用 SaaS 应用: 故障自愈
./bk_install fta

# 重装 gse_agent 并注册正确的集群模块到配置平台
# 执行完该操作后，可以在配置平台中看到主机按照 install.config 中的配置分布到对应拓扑下
./bkcec install gse_agent

#部署官方 SaaS 到正式环境(通过命令行从 /data/src/official_saas/ 目录自动部署 SaaS )
# 执行完该操作后，可以在蓝鲸工作台看到并使用所有官方 SaaS
./bkcec install saas-o

```

完成以后以上步骤后， 就可以按照部署完成的提示，开始使用蓝鲸智云社区版基础包了。

### 合作商软件包安装：

  [网络管理](../../合作方软件包安装/网络管理/net_man.md)

  [CICDKit](../../合作方软件包安装/CICDKit/CICDKit.md)


### bk_install 安装命令解析

- bk_install 其实是调用一连串的 bkcec 命令来执行安装过程。

- bkcec 的命令如果执行成功，则将执行成功的参数写入 `/data/install/.bk_install.step`。

- 例如执行 `bkcec start rabbitmq` ，如果执行失败，手动通过一些命令让 RabbitMQ 拉起后，可以自行 `echo start rabbitmq >> /data/install/.bk_install.step` 追加，然后继续运行 `./bk_install xxx` 这样会自动跳过 `bkcec start rabbitmq` ，继续下面的安装指令。
