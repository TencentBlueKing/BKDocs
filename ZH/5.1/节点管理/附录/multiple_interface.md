# 多网卡配置

**目前蓝鲸页面暂不支持多网卡的配置，如有要进行多网卡的获取，需手动修改配置文件。**

## 操作步骤

1. 修改 `agent_setup.sh` (如果是通过 proxy 进行安装的则修改 `agent_setup_pro.sh` 方法同下)。

```shell
vim /data/install/agent_setup/download#agent_setup_pro.sh	# 使用 vim 搜索功能搜索 "get_lan_ip" 修改成如下
get_lan_ip () {
    ip addr | \
	awk '!/ lo/'| \
	awk -F '[ /]+' '/\s*inet.*global/{print$3}'| \
	head -1

    return $?
}

```

2. 重新获取环境变量。

   ```shell
   source /data/install/utils.fc
   ```



3. 重新同步文件并安装 nginx。

   ```shell
   cd /data/install
   ./bkce sync common
   ./bkce stop nginx
   ./bkce install nginx 1
   ./bkce start nginx
   ./bkce status nginx
   ```

4. 进入蓝鲸节点管理控制台，重新安装即可。
