# 初始化并检查安装环境

为了简化文档描述，以 `./` 开头的脚本和文件，均指相对于部署脚本安装路径 $CTRL_DIR(默认为/data/install)，其他提到的变量可以参照 [术语解释](../../术语解释/Term.md)。

## 初始化安装环境

一键安装的命令为：`./bk_install common`，本文档主要详细描述具体的部署逻辑，方便出错时对照排查。

首次运行 ./bk_install 脚本会在中控机上做如下操作：

1. 创建安装进度文件：`./.bk_install.step` 它在安装过程中会按时间顺序记录目前一键安装脚本成功执行的步骤。

2. 输出安装蓝鲸的协议文本，需要同意后才可继续。同意协议后，会创建 `./.agreed` 的标记文件。

接着因为传给 ./bk_install 的第一个参数为 common，依次执行以下操作：

1. 运行 `./bkcli` 时会在中控机上自动做一些初始化

    - 检查是否能正确获取内网 ip，并设置（LAN_IP）变量。
    - 将 `$LAN_IP` 的值写入到 `./.controller_ip` 文件中。
    - 检查本机是否中控机，不是则退出。根据上一步的文件内容和 $LAN_IP 比对判断。
    - 设置蓝鲸产品的安装路径，并写入到 `./.path` 文件中。
    - 检查基础路径: 产品包解压路径和上一步配置的安装路径不能相同。
    - 调用脚本 `./bin/install_controller.sh` 执行以下操作

        - 安装中控机需要的基础命令
        - 根据 `./install.config` 生成 `./bin/02-dynamic/hosts.env` 变量文件

    - 设置并加载安装阶段远程执行命令时会加载的环境变量文件 `./.rcmdrc`，它在 `$HOME/.bkrc` 基础上多增加了一些变量。

2. `./bkcli install bkenv`: 根据用户配置生成安装阶段所需要的变量文件。

    - 根据用户配置的安装目录和安装脚本目录，生成 `$HOME/.bkrc` 文件，并配置 `$HOME/.bashrc` 文件加载它。具体内容以实际生成的为准。

    - 根据默认的 `/data/install/bin/default/*.env` 加上用户自定义的 `/data/install/bin/03-userdef/*.env` 合并生成最终的配置变量文件 `/data/install/bin/04-final/*.env`。具体逻辑详见 [变量配置与渲染](../../维护手册/日常维护/config_generate.md)

3. `./bkcli install python`: 在中控机上安装蓝鲸自带的 Python 解释器。关于蓝鲸 Python 运行环境的说明详见 [蓝鲸 Python 运行环境简介](../../维护手册/日常维护/python_interpreter.md)。

4. `./bkcli sync common`: 同步安装脚本目录 (/data/install) 到所有主机 (${ALL_IP[@]} 数组包含的 IP 列表)，初次同步会自动创建父目录。

5. `./bkcli update bkenv`: 登录到所有主机执行主机环境初始化。

    - 根据用户配置的安装目录和安装脚本目录，生成 `$HOME/.bkrc` 文件，并配置 `$HOME/.bashrc` 文件加载它。具体内容以实际生成的为准。
  
    - 调用 `./bin/update_bk_env.sh` 进行主机初始化，包含以下操作

        - 创建 blueking 用户和同名用户组，UID=10000 GID=10000，固定 UID、GID 是为了多机部署通过 nfs 共享目录时权限一致。
  
        - 创建 /etc/blueking/env 文件夹用于放置每台主机差异性的环境变量文件，比如 LAN_IP、WAN_IP 等。

        - 创建 systemd 管理服务用的 `/usr/lib/systemd/system/blueking.target` 文件，便于统一管理蓝鲸服务，并设置为开机启动。

        - 增加 `/etc/security/limits.d/bk-nofile.conf` 配置 blueking 账户的的最大文件打开数和最大进程数配置

        - 修改 `/etc/systemd/system.conf` 中的 `DefaultLimitNOFILE` 默认值为 204800

        - 优化内核参数

        - 尝试自动获取本机有效的内网 IP，并写入 `/etc/blueking/env/local.env` 文件中

        - 安装基础命令和编译相关的依赖库头文件

6. `./bkcli sync cert`: 将 `$BK_PKG_SRC_PATH/cert` 目录同步到所有机器的 `$BK_PKG_SRC_PATH/cert` 目录
7. `./bkcli install cert`: 将每台机器的 `$BK_PKG_SRC_PATH/cert/` 目录同步到 `$BK_HOME/cert/` 下，并设置属主为 blueking
8. `./bkcli install yum`

    - 在中控机上调用脚本 `./bin/install_yum.sh -P 8080 -p /opt/yum -python /usr/bin/python` 配置名为 bk-yum.service 的服务，启动命令为 `/usr/bin/python -m SimpleHTTPServer 8080`，工作目录为 `/opt/yum`，这一步需要注意，如果 /usr/bin/python 不是 python2 的版本，需要修改启动命令参数。

    - 上一步成功后，需要在所有机器上配置 yum 仓库增加它，因为安装第三方组件时均是通过 yum 命令安装，需要能找到中控机上 /opt/yum 下的 rpm 包。在所有机器上调用脚本：`./bin/setup_local_yum.sh -l http://中控机ip:8080 -a`。会新增 /etc/yum.repos.d/Blueking.repo 文件，设置名为 `bk-custom` 的仓库。

至此初始化环境完毕

## 检查安装环境

安装脚本使用 `./health_check/check_bk_controller.sh` 来检查中控机的环境配置。使用 `./health_check/check_bk_node.sh` 来检查所有机器的环境配置。

1. check_bk_node.sh 主要检查以下几个方面：

    - 检查是否为 centos7 (check_centos7)

    - selinux 是否关闭 (check_selinux)

    - 检查 root 的 umask (check_umask)

    - 检查 yum 是否配置正确 (check_yum_repo)

    - 检查是否存在 http 代理 (check_http_proxy)

    - 检查最大文件打开数 (check_open_files_limit)

    - 检查 rsync 命令是否存在 (check_rsync)

    - 检查 glibc 的版本 (check_glibc_version)

    - 检查 firewalld 是否关闭 (check_firewalld)

2. check_bk_controller.sh 主要检查以下几个方面：

    - 检查免密是否完成 (check_ssh_nopass)

    - 检查证书和 mac 地址是否匹配 (check_cert_mac)

    - 检查 install.config 文件匹配是否合理 (check_install_config)

    - 检查域名配置 (check_domain)

    - 检查 src 目录是否按文档要求解压完毕 (check_src_dir)

    - 检查 python 版本是否符合预期 (check_python_version)
