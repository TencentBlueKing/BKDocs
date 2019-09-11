## 安装脚本功能概述

### bkcec 脚本原理

![bkcec脚本原理](/assets/bkcec_flow.png)

### bkcec 说明

bkcec 是蓝鲸社区版的安装维护主脚本；bk_install 是封装了 bkcec 的集成安装脚本

bkcec 的调用语法为：`bkcec <command> <module> [project] [1]`

其中可用的 command 有：

* `sync`  
从中控机的 src/同步安装`<module>`依赖的文件和目录到对应机器的 src/下
* `install`  
安装`<module>`到$INSTALL_PATH（默认/data/bkce）下
* `install <module> 1`  
等同于先执行 `sync <module>`，再执行`install <module>`，合二为一
* `initdata`  
安装后初始化，常用于模块的用户创建，sql 导入，权限设置等操作
* `render`  
渲染模块的模板文件，install 过程中会调用它，做模板变量替换。
* `status`  
检查模块的进程是否运行
* `start`  
启动模块的进程
* `stop`  
停止模块的进程
* `upgrade`  
升级更新模块

其中模块名，对应 install.config 里的名称，当前社区版包含以下模块，按模块特点分为两类，一是开源外部组件，二是蓝鲸自研产品

* 开源组件
  - `nginx`  web 服务器和反向代理
  - `rabbitmq` 消息队列服务
  - `kafka` 分布式数据流处理服务
  - `zk` zookeeper 分布式配置服务
  - `es` elasticsearch 分布式搜索和数据分析引擎
  - `consul` 分布式服务发现和域名服务
  - `mongodb` 面向文档的数据库管理系统
  - `mysql` 关系数据库管理系统
  - `beanstalk` 消息队列服务
  - `redis` 键值对存储数据库

* 蓝鲸组件
  - `paas` 蓝鲸 PaaS 平台
  - `cmdb` 蓝鲸配置平台
  - `job` 蓝鲸作业平台
  - `gse` 管控平台后台
  - `license` 证书服务
  - `appo`  SaaS 部署的正式环境
  - `appt` SaaS 部署的测试环境
  - `bkdata` 数据平台基础服务
    - `dataapi` 数据平台 api 接口服务
    - `databus` 数据平台总线服务
    - `monitor` 监控后台
  - `fta` 故障自愈后台

**启动蓝鲸监控后台服务示例： `./bkece start bkdata monitor`**

### 文件用途

#### 脚本包的文件说明

* RELEASE.md  
版本日志
* VERSION  
版本号
* agent_setup/  
存放安装 Agent 相关的脚本以及脚本模版
* appmgr/  
存放构建 SaaS 和运行 SaaS 所需的脚本，社区版采用 virtualenv 方式
* bk_install  
封装 bkcec 用来做集成安装部署
* bkcec  
安装和维护的主脚本
* bkco.env bkco.fc bkco_install  
网络管理模块所用的安装部署相关环境变量和函数定义
* clean.fc  
卸载清理相关函数
* configure_ssh_without_pass  
一键配置免密 ssh 登陆用的脚本
* control.rc  
定义进程启停的函数库
* crontab.rc  
crontab 新增和删除相关的函数定义
* deck/saas.py  
命令行部署 SaaS 应用的工具
* deliver.rc  
定义从中控机同步文件目录到对应模块机器的函数
* dependences.env  
各模块依赖的命令和 rpm 包定义
* errors.env  
错误码定义
* functions  
通用的 bash 函数
* globals.env  
定义蓝鲸组件用到的全局变量配置
* health_check/check_proc_exists  
Consul 使用的健康检查脚本
* install.config  
定义模块在主机的分布部署方式
* install_minibk  
最小化单机部署的封装脚本
* migrate/  
蓝鲸套件迁移升级的脚本，目前没有用
* parse_config  
解析 install.config 并生成 Consul l 主配置和服务定义的配置， `config.env` 等文件
* pip/  
存放安装脚本所需的 pip 依赖包
* ports.env  
定义所有组件需要设定的端口信息
* process_watch + watch.rc  
进程监控脚本
* register.rc  
自动注册主机到 CMDB 的函数
* scripts/  
gse_agent 和 gse_proxy 安装所需要启停脚本，在安装 GSE 时会自动打包进去
* status.rc  
检查进程状态相关的函数
* summary.rc  
打印相关模块和所有模块的版本信息
* templates/  
安装脚本初始依赖的配置模版，目前只是 Consul 的 Supervisor 配置
* templates_render.rc  
渲染配置模版，根据读取配置文件和动态生成的变量去替换模版里的占位符。
* update.rc  
一些更新配置或者证书的操作定义
* upgrade.rc  
各模块的升级操作封装
* utils.fc  
安装、初始化主要函数都在这里先找。

#### 完成安装或日常升级后会生成的文件

* .agreed  
同意安装协议后的标记文件

* .app.token  
后台程序和 SaaS ，访问 ESB 接口时需要使用的 `app_code` 和 `app_token` 的键值对。

* .bk_install.step  
集成安装的步骤进度标记文件

* .controller_ip  
中控机的 IP 地址

* .migrate/   
成功导入的 SQL 文件的标记文件。使用了 chattr +i ，具有不可删除属性。

* .path  
蓝鲸的安装路径。

* .rcmdrc  
使用 rcmd() 函数远程执行命令时，会加载的 rc 文件

* /tmp/bkc.log  
bkeec 等脚本输出的日志
