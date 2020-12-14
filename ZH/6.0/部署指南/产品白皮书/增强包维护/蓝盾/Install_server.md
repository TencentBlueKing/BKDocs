## 安装服务端

在完成了 jre.zip 的准备工作后，参考 “安装蓝盾” 章节在蓝鲸中控机重新安装 `dispatch` 及 `environment` 服务即可。
大致操作如下：
```bash
./bin/merge_env.sh ci   # 汇总新的env
./bkcli sync common     # 同步公共文件(其中包含env)到其他节点
./bkcli sync ci   # 因为更新了 ci/agent-package/jre目录，所以需要同步至其他CI节点。以备安装。
# 仅需安装 dispatch 及 environment
pcmd -m ci_dispatch 'cd ${CTRL_DIR:-/data/install}; export LAN_IP; ./bin/install_ci.sh -e ./bin/04-final/ci.env -p "$BK_HOME" -m dispatch 2>&1;'
pcmd -m ci_environment 'cd ${CTRL_DIR:-/data/install}; export LAN_IP; ./bin/install_ci.sh -e ./bin/04-final/ci.env -p "$BK_HOME" -m environment 2>&1;'
# 如果agent依旧安装失败，可能服务存在缓存，可以重启dispatch及enviroment服务。
```
