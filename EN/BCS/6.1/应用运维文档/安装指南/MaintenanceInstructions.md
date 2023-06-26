# 安装步骤
## 容器服务 SaaS

蓝鲸智云 -\> 开发者中心 -\> S-mart 应用 -\> 上传部署新应用

### 容器服务 WebConsole

以下，\${ INSTALL_PATH } 为安装时指定根路径，若不指定, 默认为 /data/bkee 。

1\. 安装基础模块， 安装 MySQL, Redis 数据存储模块

参考 PaaS 平台，安装好基础模块和 MySQL, Redis 数据存储模块

2\. 安装 Web-Console

\# 安装 Python,虚拟环境和包依赖

安装 Python 版本为 3.6.x 版本
```bash
python –version

Python 3.6.7
```

\# 安装 virtualenv
```bash
pip install virtualenv virtualenvwrapper

source /usr/local/bin/virtualenvwrapper.sh
```

\# 安装虚拟环境和包依赖
```bash
mkvirtualenv bcs-web-console

pip install -r requirements.txt
```

\# 替换环境变量

环境变量参考[附录-配置参考文档](../附录/ConfigurationReferenceDocument.md)，替换对应的变量

\# 拉起进程
```bash
$ supervisord -c /{INSTALL_PATH}/etc/supervisor-bcs-web_console.conf
```

\# 进程管理

查看状态：
```bash
supervisorctl -c /{INSTALL_PATH}/etc/supervisor-bcs-web_console status
```

重启服务：
```bash
supervisorctl -c /{INSTALL_PATH}/etc/supervisor-bcs-web_console.conf restart all
```

### 容器监控 SaaS

蓝鲸智云 -\> 开发者中心 -\> S-mart 应用 -\> 上传部署新应用

### 容器监控后台

以下，\${ INSTALL_PATH } 为安装时指定根路径，若不指定, 默认为 /data/bkee 。

3\. 安装基础模块， 安装 MySQL, Redis 数据存储模块

参考 PaaS 平台，安装好基础模块和 MySQL, Redis 数据存储模块

4\. 安装 Grafana

\# 创建 DB
```bash
CREATE DATABASE IF NOT EXISTS bcs_grafana DEFAULT CHARACTER SET utf8 COLLATE
utf8_general_ci;
```

\# 替换环境变量

环境变量参考[附录-配置参考文档](../附录/ConfigurationReferenceDocument.md)，替换对应的变量

\# 拉起进程
```bash
$ supervisord -c /{INSTALL_PATH}/etc/supervisor-bcs-grafana.conf
```

\# 进程管理

查看状态：
```bash
supervisorctl -c /{INSTALL_PATH}/etc/supervisor-bcs-grafana.conf status
```
重启服务：
```bash
supervisorctl -c /{INSTALL_PATH}/etc/supervisor-bcs-grafana.conf restart all
```

5\. 安装 Monitor

\# 创建 DB
```bash
CREATE DATABASE IF NOT EXISTS bk_bcs_monitor DEFAULT CHARACTER SET utf8 COLLATE
utf8_general_ci;
```

\# 安装 Python,虚拟环境和包依赖

安装 Python 版本为 3.6.x 版本
```bash
python –version

Python 3.6.7
```

\# 安装 virtualenv
```bash
pip install virtualenv virtualenvwrapper

source /usr/local/bin/virtualenvwrapper.sh
```

\# 安装虚拟环境和包依赖
```bash
mkvirtualenv bcs-monitor

pip install -r requirements.txt
```

\# 替换环境变量

环境变量参考[附录-配置参考文档](../附录/ConfigurationReferenceDocument.md)，替换对应的变量

\# 执行 migrate

migrate 表结构
```bash
python manage.py migrate --settings=conf.worker.settings.ce.prod
```

\# 初始化 metric
```bash
python manage.py init_monitor_metric --settings=conf.worker.settings.ce.prod
```

\# 拉起进程
```bash
supervisord -c /data/bkee/etc/supervisor-bcs-monitor.conf
```

\# 进程管理

查看进程状态：
```bash
supervisord -c {INSTALL_PATH}/etc/supervisor-bcs-monitor.conf
```
重启进程：
```bash
supervisorctl -c {INSTALL_PATH}/etc/supervisor-bcs-monitor.conf
```

### 配置中心

安装环节由自动化脚本执行完成，不涉及单步执行，以下安装步骤将流程以及关键指令进行介绍，为运维人员提供参考：

- 执行 on_migrate 初始化脚本

添加环境 `source utils.fc`

执行`./on_mgrate`

- 启动 BCS CC 服务
```bash
/opt/py27/bin/python /opt/py27/bin/supervisord -c /data/bkee/etc/supervisor-bcs-cc.conf
```
