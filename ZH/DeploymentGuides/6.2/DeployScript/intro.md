# 部署脚本

安装蓝鲸时所用的部署脚本包 install/ 目录下也包含了日常维护用的脚本，用来做发布更新和故障排查。

运维脚本目录本身包含了用户配置的数据，主要体现在 install/bin/{01-generate,02-dynamic,03-userdef,04-final} 文件夹中。

中控机的 install 目录本身做任何变更前，请记得做好备份。其他机器的 install 目录，应该和中控机保持完全一致，所以无需额外备份。

由于部署过程会生成各个存储组件的随机密码到 install/01-generate 下，或者用户配置了相关的存储密码到 03-userdef/ 下，这些密码是明文存储的，请注意设置好相关访问权限，以免泄露。其中有一些以 BYTES 结尾的变量的值，用于 AES 加密，请妥善备份，丢失后，会无法解密数据库中加密存储的数据。

## 常用脚本说明

相关重要运维脚本的作用作简要说明：

- **bk_install：**  初次集成部署蓝鲸各模块时使用，安装完蓝鲸组件后，一般不需要使用它。
- **bkcli：** 命令行操作蓝鲸各模块的入口脚本，维护过程中会经常使用。
  - **deliver.sh：** 对应 `bkcli sync` 操作实际调用的脚本，用来从中控机同步文件到其他模块主机。
  - **install.sh：**  对应 `bkcli install` ，用来安装组件。
  - **initdata.sh：** 对应 `bkcli initdata`，用来初始化数据。
  - **control.sh：** 搭配 action.rc 对应 `bkcli <start/stop/restart>`，用来操作进程的启停。
  - **status.sh：** 对应 `bkcli status`，用来查看进程的运行与否状态。
  - **check.sh：** 对应 `bkcli check`，查看蓝鲸组件和依赖存储的健康状态。
  - **render.sh：** 对应 `bkcli render`，根据环境变量渲染模块的配置模板。
  - **upgrade.sh：** 对应 `bkcli upgrade`，用来升级更新组件版本，包括更新证书。
  - **update.rc：** 对应 `bkcli update`，主机节点更新。
- **configure_ssh_without_pass：** 用来配置 ssh 免密。
- **configure：** 用来初次安装配置自定义域名和安装目录。
- **pcmd.sh：** 封装 pssh 命令的脚本，并行 ssh 到远端机器执行命令。
- **sync.sh：** 封装 prsync 命令的脚本，并行 rsync 同步文件到远端机器。
- **functions：** 一些通用共享的 bash 函数。
- **tools.sh：** 一些和蓝鲸安装逻辑相关的共享 bash 函数库。
- **load_env.sh：** 加载环境变量，通常用来 source 它，可以使用到一些变量来传递给维护脚本。
- **utils.fc：** 兼容以前脚本的习惯，它除了加载 load_env.sh，还加载 functions。
- **health_check/*.sh：** 一些健康检查的脚本，部分脚本会用 `bkcli check` 封装。
  - **check_bk_controller.sh：** 检查中控机的环境是否满足安装需求，对应之前的 precheck。
  - **check_bk_node.sh：** 检查安装蓝鲸的所有主机 node 节点的环境。
  - **check_cmdb_blueking_id：** 查询 cmdb 上 名字为蓝鲸的业务 ID。
  - **check_cmdb_config_on_zk.sh：** 检查 cmdb 在 zk 节点上的配置文件内容和本地的是否一致。
  - **check_cmdb_proc_on_zk.sh：** 检查 cmdb 在 zk 节点上注册的服务 ip 和 port。
  - **check_consul_resolv.sh：** 检查本机的 consul client 的 dns 解析功能是否正常。
  - **check_consul_svc_health.sh：** 检查本机注册的 consul service 的健康情况，支持服务健康检查的列表在脚本中 hardcode。
  - **check_gse.sh：** 检查 gse 的后台进程是否有不断重启。
  - **check_openresty.sh：** 检查 openresty 上 nginx 的配置语法和 consul-template 进程是否存在。
  - **deploy_check.py：** 检查蓝鲸依赖的存储/队列组件的连通性。
- **monitor/*.sh：** 一些自定义事件上报的监控脚本，用于辅助蓝鲸自监控的建设。
- **install.config.*.sample：** 初次部署的时候，配置 install.config 的参考分布文件。
- **install_minibk：** 安装单机的最小化部署蓝鲸（不推荐实际使用，仅用于测试部署脚本的流程）。
  - **minimal_tweak_config.sh：** 配合 install_minibk 用，调整一些引起资源使用量大的参数，降低 cpu 和内存的消耗。
- **qq.py**
  - 解析蓝鲸工程目录下的 projects.yaml，拼成 bash 的环境变量，供安装脚本使用。
  - 解析 default/port.yaml 获取开源组件的部署信息。
- **release.md：** 部署脚本的发行说明文档。
- **saas_var.env：** 初次部署 SaaS 时，自动初始化这些 SaaS 运行所依赖的环境变量列表到 PaaS 数据库。
- **storage/dbbackup/*.sh：** 数据库的备份脚本，请严格按照相应文档的说明使用。
- **support-files/sql/*.sql：** 部署脚本依赖的一些 mysql 库表初始化。
- **support-files/templates/nginx/*.conf：** 部署 nginx 时，需要从这些模板来生成实际的 nginx 子配置，如果有调整，请自行备份恢复。
- **uninstall/uninstall.sh：** 卸载脚本，本脚本需要在每台机器上单独运行且需要拷贝到上一级目录下才能正常运行，防止误操作。

运维脚本还有存放在 install/bin/ 目录下的脚本/配置，单独说明如下，以下文件名都是相对于 install/bin 目录而言这些脚本的共同点是，它们可以在每台机器上单独执行，不依赖 ssh 免密登录，为了便于固化到《标准运维》本身调用而设计。

- **merge_env.sh：** 合并出厂默认配置和用户配置，生成最终渲染配置文件的变量列表，它正常工作依赖以下几个文件夹中的文件：
  - **default/*.env：** 存放蓝鲸出厂默认的各个组件配置渲染依赖的变量，每次更新脚本的时候，该目录直接覆盖更新。
  - **01-generate/dbadmin.env：** 存放自动生成的存储组件随机密码，请注意妥善备份和保管。
  - **01-generate/{模块}.env：** 存放初次部署时一次性生成的密码类变量，理论上整个蓝鲸运行生命周期中，不需要改动如果需要改动，得严格按照相关文档说明操作请注意妥善备份和保管。
  - **02-dynamic/hosts.env：** 存放根据 install.config 文件自动生成的主机 IP 相关的变量和数组，它是程序维护的文件列表，可重复生成。
    - **bk-install-config-parser.awk：** 用于生成 hosts.env 的 awk 脚本，它的参数是 install.config 的路径，输出是 STDOUT。
  - **03-userdef/{模块}.env：** 存放针对该模块自定义的变量文件，会覆盖 default/01-generate 中同名文件中的值，优先级最高。
  - **04-final/{模块}.env：** 通过 merge_env.sh <模块> 自动生成它是程序维护的文件列表，可重复生成。
- **install_*.sh install：** 开头的脚本是安装部署用的，分三类：
  1. install_<开源组件名>.sh：** 安装和部署相关开源组件的脚本（一般是作为单实例安装），某些分布式模块，需要在安装后，做构建集群的配置，添加用户授权，会多一些脚本，列举如下：
     - **setup_mongodb_rs.sh：** 将 mongodb 单实例转换成 mongodb replica set 集群。
     - **setup_rabbitmq_cluster.sh：** 将 rabbitmq 单实例构建为集群模式。
     - **setup_es_auth.sh：** 配置 elasticsearch 的 auth 功能。
     - **add_rabbitmq_user.sh：** 添加 rabbitmq 的账户和同名 vhosts。
     - **add_mongodb_user.sh：** 添加 mongodb 的普通账户。
     - **grant_mysql_priv.sh：** 给指定的 IP 列表，授权 mysql 的访问权限。
     - **setup_mysql_loginpath.sh：** 配置 mysql 的 login-path，依赖 expect 自动输入密码。

  2. install_<蓝鲸模块>.sh：** 安装和部署蓝鲸模块的脚本，可在每台机器上独立运行。
  3. install_<其他辅助功能>.sh：** 安装一些辅助功能，供其他脚本调用。
     - **install_controller.sh：** 在中控机上调用，通过`bkcli`命令，每次调用 bkcli 都会执行它它安装一些必备的命令，并将 install.config 生成为 hosts.env。
     - **install_py_venv_pkgs.sh：** 对于 python 工程，第一步需要安装虚拟环境，然后根据 requirements.txt 来安装依赖的 pip 包，该脚本主要完成这一动作。
     - **install_yum.sh：** 安装蓝鲸的开源组件需要依赖一些 rpm 包，统一使用一个自定义的 yum 仓库（bk-custom）来解决，install_yum.sh 辅助安装部署阶段启动一个临时的 yum 源。
     - **setup_local_pypiserver.sh：** 配置本地的 pypi server。
     - **setup_local_yum.sh：** 配置本地的 repo 文件，使用 install_yum.sh 搭建的 yum 仓库。
- **release_<蓝鲸模块>.sh：** 更新蓝鲸模块的脚本，可在每台机器上独立运行。
- **render_tpl：** 最底层的 render 逻辑，通过读入的 env 文件，替换目标模块文件中的\_\_占位符变量。
- **bkr.sh：** 封装 render_tpl 的脚本，根据传入的模块名，采取不同的在每台机器上通过变量文件，渲染对应的模块。
- **bks.sh：** 查看本机安装的蓝鲸组件的进程运行情况。
- **update_bk_env.sh：** 初始化/更新一台 linux 机器，做蓝鲸初始化用，这是新机器加入蓝鲸后台部署时，最先运行的脚本。
- **add_or_update_appcode.sh：** 往 paas 数据库的 esb_app_account 表中注册 appcode 和 secret，并添加到免登录态验证的白名单一般后台部署的服务需要使用，SaaS 的 app_code 和 app_secret，由 PaaS 自动维护。
- **add_skip_auth_appcode.sh：** 往 esb 的免登录态验证字段中追加 app_code，豁免校验登录态一般是新增加的 SaaS 如果需要后台任务请求 esb 时，需要调用它来豁免。
- **bkiam_do_migrate.sh：** 注册权限模型到权限中心的封装，并将注册成功的 json 文件做好标记到$HOME/.migrate/下。
  - **bkiam_do_migrate.py：** 实际调用的这个 python 脚本，bash 脚本是为了获取一些变量拼接参数。
- **bk_zkcli.sh：** 操作的 zk，主要为 gse 和 cmdb 的 zk 节点内容查看提供便利，它依赖 zookeepercli 二进制，可通过 yum 安装。
- **check_agent_info.sh：** 检查 agent 的连接状态，用法 `cat iplist | ./check_agent_info.sh`。
- 创建蓝鲸拓扑的系列脚本：
  - **create_blueking_service_template.sh：** 创建服务模板。
  - **create_blueking_topo_template.sh：** 根据服务模板创建集群模板。
  - **create_blueking_set.py：** 根据集群模板实例化为具体的集群。
- **create_gse_zk_base_node.sh：** 创建 gse 启动时依赖的 zk 的基础节点。
- **create_gse_zk_dataid_1001_node.sh：** 创建 basereport 上报的基础性能数据依赖的 1001 dataid 的 zk 节点。
- **reg_consul_svc、dereg_consul_svc：** 注册 consul 服务 / 解除注册 consul 服务，通过传入服务名，tag，以及监听的 port，生成服务定义的 json 文件。
- **esb_api_test.sh：** 调用 esb 的 api，主要是为其他脚本服务，对于简单的蓝鲸 api 调用提供便利。
- **es_delete_expire_index.sh:** 根据一定的命名规则，删除指定天数之前的 elasticsearch index，用于自动清理过期的索引。
- **es_clean_index_by_query.sh:** 根据日期删除指定 index 中的过期 document，通过_delete_by_query 接口查找后删除。
- **generate_blueking_generate_envvars.sh：** 为了初次部署的时候，自动生成 01-generate/*.env 文件。
- **get_version.sh：** 获取蓝鲸组件/开源软件的版本号。
- **mongodb_drop_joblog_collection.sh:** 清理 mongodb 中的过期的 joblog 表数据脚本。
- **pack_gse_client_with_plugin.sh：** 根据 gse 的包和 plugins 的包，合并为符合 nodeman 的安装的 gse_client 包。
- **prepare-bk-ci.sh：** 转化 CI（蓝盾）的开源部署包适配部署脚本。
- **saas.py：** 通过后台接口，部署 SaaS 的脚本。
- **sql_migrate.sh：** sql 导入的封装脚本，通过配置好免密的 mysql-login-path 名字导入对应的 sql 文件，并做好标记，标记存放到$HOME/.migrate/下，且`chattr +i` 防止误删除。
- **single_host_low_memory_config.sh:**  单机部署时，调低运行中进程的相应配置，减少内存消耗。
- **zk4lw.sh** 往 zookeeper 发送四字命令，获取返回结果的纯 bash 脚本，不依赖 nc 和 telnet
