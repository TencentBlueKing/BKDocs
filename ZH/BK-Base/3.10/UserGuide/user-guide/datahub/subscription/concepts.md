# 队列服务

提供了一种数据订阅的功能, 通过队列服务消费数据. 适用于队列订阅 / 实时性较高/ 数据量较大的场景

* 支持同时订阅多个 topic, 支持订阅正则 topic
* 支持集群无感知切换

# 授权

使用前需要针对表授权, 获取授权码 token. 参见 [权限管理-授权管理](../../auth-management/token.md)。

# 安装客户端

## 客户端下载地址

* Python: [queue_client_python-1.1.3-py2.py3-none-any.whl](https://bktencent-1252002024.file.myqcloud.com/queue_client_python-1.1.3-py2.py3-none-any.whl)

* Java: [queue-client-java-1.0.5-jar-with-dependencies.jar](https://bktencent-1252002024.file.myqcloud.com/queue-client-java-1.0.5-jar-with-dependencies.jar)

## python 客户端本地安装

> pip install queue\_client\_python-x.x.x-py2.py3-none-any.whl

## python 客户端蓝鲸 app 源安装

> pip install queue\_client\_python=x.x.x

# 使用

参考示例代码

