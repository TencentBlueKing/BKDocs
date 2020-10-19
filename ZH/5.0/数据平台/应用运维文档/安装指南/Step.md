# 安装步骤

安装环节由自动化脚本执行完成，不涉及单步执行，以下安装步骤将流程以及关键指令进行介绍，为运维人员提供参考：

1. 安装 Java 环境

- 拷贝安装目录

`rsync -aL $PKG_SRC_PATH/service/java $INSTALL_PATH/service/`

- 设置 JAVA 相关环境变量
```bash
echo "export INSTALL_PATH=$INSTALL_PATH" >>$HOME/.bkrc

echo 'export JAVA_HOME=$INSTALL_PATH/service/java' >> $HOME/.bkrc

echo 'export CLASS_PATH=$JAVA_HOME/service/java/lib' >> $HOME/.bkrc

echo 'export PATH=$JAVA_HOME/bin:$PATH' >> $HOME/.bkrc
```
2. 拷贝数据服务模块安装包

`rsync -aL $PKG_SRC_PATH/$module $INSTALL_PATH/`

`rsync -a  $PKG_SRC_PATH/cert $INSTALL_PATH/`

3. 初始化数据文件夹
```bash
install -o es -g es -d $INSTALL_PATH/{public,logs}/es

install -d $INSTALL_PATH/{logs,public}/kafka

install -d $INSTALL_PATH/public/redis

install -d $INSTALL_PATH/public/beanstalkd
```
4. 初始化子模块虚拟环境

5. 设置 APP_CODE 和 APP_TOKEN

6. 按模板生成子模块的配置文件

    配置文件参数见附件

7. 通过 Supervisord 拉起服务

- 总线服务
```bash
$BK_HOME/.envs/databus/bin/supervisorctl -c
$BK_HOME/etc/supervisor-bkdata-databus.conf start all
```
- DataAPI 服务
```bash
$BK_HOME/.envs/databus/bin/supervisorctl -c
$BK_HOME/etc/supervisor-bkdata-dataapi.conf start all
```
- Processor API 服务
```bash
$BK_HOME/.envs/databus/bin/supervisorctl -c
$BK_HOME/etc/supervisor-bkdata-processorapi.conf start all
```
- 监控服务
```bash
$BK_HOME/.envs/databus/bin/supervisorctl -c
$BK_HOME/etc/supervisor-bkdata-monitor.conf start all
```
8. 初始化 dataflow 环境

    JAVA_HOME ： JAVA 按照目录

    HADOOP_PREFIX ：HDFS 安装目录
