# 登录指定服务器

一般维护操作时，均从中控机出发，跳转到其他模块服务器进行操作。

假设发现作业平台模块启动失败，想登录到作业平台模块所在服务器查看相关日志：

```bash
# 均以默认路径(/data/install)为例，请根据实际安装路径修改相关命令
cd /data/install/
source utils.fc

# 这个命令用来加载环境变量（/data/install/bin/{01-generate,02-dynamic,03-userdef,04-final}/*.env）加载一些通用函数。

```

如登录至 JOB 模块所在机器：

```bash
ssh $BK_JOB_IP
# /data/install/bin/02-dynamic/hosts.env 文件通过解析 install.config ，生成了模块对应的 IP。
# 所以，我们可以直接用 $BK_MODULE_IP 这样的方式来访问。
# MODULE，用 install.config 里模块名的大写形式进行替换。例如 paas 所在机器 IP 为 $BK_PAAS_IP ，配置平台所在机器 IP 为 $BK_CMDB_IP ，依此类推。
# 也可以输入 $ 符号后，用 $BK_<tab> 补全试试。
```
