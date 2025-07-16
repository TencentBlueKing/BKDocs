# 配置生成与渲染

本文主要介绍蓝鲸后台部署时配置文件的生成渲染方式，它的原理、局限性和注意事项。

> 本文如无特别说明，相对路径表示的文件，均相对于 CTRL_DIR(/data/install) 目录

## 变量生成

**实际搭建过程中，如果没有特殊要求，建议直接使用命令`./bkcli install bkenv`来完成下面的过程，然后再进行自定义。**

蓝鲸 3.0 重构优化了配置渲染的逻辑。运维需要先理解下新的变量定义方式。

部署脚本将配置文件拆分为 5 个目录，按加载顺序依次为：

0. ./bin/default/
1. ./bin/01-generate/
2. ./bin/02-dynamic/
3. ./bin/03-userdef/
4. ./bin/04-final/

第 0 层级是默认值，默认值目录下包含根据不同模块名字 + `.env` 后缀结尾的文件。其中有些变量值为空，说明需要在部署的环境一次性生成。比如密码类的变量值

第 1 层级是需要一次性生成的变量，用来填补默认值目录中缺失的部分，它由部署脚本 `./bin/generate_blueking_generate_envvars.sh` 脚本来处理并打印到 STDOUT，然后在安装阶段 `./bkcli install bkenv` 会封装前述脚本，将 STDOUT 的值写入到 `./bin/01-generate/` 对应模块文件名中。值得一提的是，有一个特殊的文件 `./bin/01-generate/dbadmin.env` 它记录的是数据库存储等需要的管理员账户信息。比如 MySQL 的 root 密码，RabbitMQ 的 Admin 密码。

第 2 层级是动态生成的变量，可以重复运行生成并覆盖的，目前只包含 `./bin/02-dynamic/hosts.env` 文件，它是由命令 `./bin/bk-install-config-parser.awk install.config > bin/02-dynamic/hosts.env` 生成的。每次执行 bkcli 时均会运行，保证主机列表是最新的。

第 3 层级是用户自定义的变量，可以覆盖第 1、2 层级中的同名变量。目前实现方式的局限性在于，不同模块的配置变量中，如果变量名相同，需要保证值也完全一致，不然会产生互相覆盖的问题，导致最终的变量值不符合预期。也就是说，假设要自定义修改 `BK_PAAS_PUBLIC_URL` 这个变量，需要在所有包含这个变量的模块的文件中，都重新定义一次。

第 4 层级是使用 `./bin/merge_env.sh <模块>` 命令，将 0~3 层级的同模块名的变量文件按优先顺序合并得到 `./bin/04-final/<模块>.env` 文件。在实际安装部署，生产配置文件时，只会从这个文件来读取变量。

合并完毕后，可以通过命令 `./bin/envdiff.sh <模块>` 命令，来输出 `./bin/04-final/<模块>.env` 和 `./bin/default/<模块>.env` 之间差异的变量取值。

## 配置渲染

配置渲染命令在安装和更新模块操作时都需要，也是日后运维时经常会使用的命令。它的底层实现逻辑只有一个脚本 `./bin/render_tpl` 为了足够通用会显得比较复杂，本质它和使用系统命令 `envsubst` 作用雷同。不过针对蓝鲸部署场景做了一些增强功能。

下面先介绍它的用法和注意事项，然后介绍部署脚本的封装。

每个蓝鲸模块需要自定义配置的地方分为两部分：

1. 抽象了配置变量的部分
2. 未定义变量的部分，写死在配置文件/代码文件

配置渲染处理的是第一部分内容。后台模块对于抽象了配置变量的部分，经过约定，采用 `__变量名__` 形式的占位符。（对照`envsubst`命令的占位符是 shell 格式的变量： `$变量名`）

假设 bkiam 模块的配置模板里包含 `__BK_HOME__`，而 `./bin/04-final.env` 中的变量 `BK_HOME=/data/bkce` ，那么通过脚本替换后，`__BK_HOME__` 变成了 `/data/bkce`

接下来需要处理配置占位符替换后的文件内容，落地到磁盘的路径问题。目前蓝鲸采用的方式是通过配置文件模板名里使用 `#` 作为分隔符，在渲染过程中，自动替换为 `/` 来生成实际路径的方式。

配置文件模板的存放路径是 `/data/src/<模块>/support-files/templates/` 目录。以 paas 的 2 个配置文件模板为例说明路径的转化：

1. `/data/src/open_paas/support-files/templates/#etc#uwsgi-open_paas-paas.ini`
2. `/data/src/open_paas/support-files/templates/paas#conf#settings_production.py.tpl`

渲染脚本还需要知道安装目录（-p, --prefix），以及模块的目录名（-m, --module），所以在渲染 paas 的配置时，调用的命令为：

```bash
$ /data/install/bin/render_tpl -m open_paas -p /data/bkce \
    -e /data/install/bin/04-final/paas.env \
    /data/src/open_paas/support-files/templates/#etc#uwsgi-open_paas-paas.ini \
    /data/src/open_paas/support-files/templates/paas#conf#settings_production.py.tpl

# 输出：
render /data/src/open_paas/support-files/templates/#etc#uwsgi-open_paas-paas.ini -> /data/bkce//etc/uwsgi-open_paas-paas.ini
render /data/src/open_paas/support-files/templates/paas#conf#settings_production.py.tpl -> /data/bkce/open_paas/paas/conf/settings_production.py
```

所以实际落地磁盘的路径，对于第一种配置文件模板以`#`开头的，规则是：PREFIX + / + **配置文件名替换 `#` 为 `/` 后的路径** 。对于第二种配置文件模板，没有以`#`开头的，规则是：PREFIX + MODULE + **配置文件名替换 `#` 为 `/` 后的路径** 

有一类变量比较特殊，如当前主机的内网 ip 地址，以前的方式是每次都通过 `get_lan_ip ()` 函数动态获取一遍。目前采取的策略是，主机初始化时自动获取一次，并写入到 `/etc/blueking/env/local.env` 文件中，在需要渲染 `LAN_IP` 和 `WAN_IP` 的模块配置时，通过额外的参数(-E, --extra-env)。

`render_tpl` 脚本默认行为是对没有变量值的占位符，保持原样不处理。比如，有一个占位符是 `__NON_EXISTS__`，但是对应的 `./bin/04-final/模块.env` 中并不存在`NON_EXISTS=`的定义。默认行为是保留 `__NON_EXISTS__` 的形式。但是有些模块要求如果不存在，则渲染为空。脚本增加了一个参数 `-u, --undefined`。于是最终 paas 模块的渲染命令如下：

```bash
$ /data/install/bin/render_tpl -m open_paas -p /data/bkce \
    -u -e /data/install/bin/04-final/paas.env \
    -E LAN_IP=$LAN_IP \
    /data/src/open_paas/support-files/templates/#etc#uwsgi-open_paas-paas.ini \
    /data/src/open_paas/support-files/templates/paas#conf#settings_production.py.tpl
```

由于这个命令输入很长，封装了一个脚本 `./bin/bkr.sh` 用于每台机器上的模块渲染。假设要渲染 paas 模块，则登录到 paas 机器上，运行：`./bin/bkr.sh paas`。

社区版是可以扩展为多机部署的，大多数操作在提供原子脚本的同时，也提供了中控机的批量执行操作。对于渲染命令，提供了`./render.sh` ，进而由 `./bkcli render <模块>` 来封装调用。

渲染配置的脚本调用链总结为：`./bkcli render paas` -> `./bin/bkr.sh paas` -> `./bin/render_tpl .....` 