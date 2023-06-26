## 常见问题及排查方法

### 1. helmfile调试和等待时间长问题

调试问题，可以使用`helmfile --debug`进行来调试。

等待时间长，可能是下载镜像，或者helm仓库没添加，使用`helm repo list`来查看，同时可以通过`kubectl get pod -w`来实时看是否有pod拉起以及状态情况。

### 2. databus异常排查

检查注册信息是否有异常：

```
# 获得datahubapi的cluster ip
datahubapi_cluster_ip=`kubectl get service -n bkbase bkbase-datahubapi -o=jsonpath='{.spec.clusterIP}'`
​
# 检查channels是否注册
curl http://${datahubapi_cluster_ip}:8000/v3/databus/channels/
​
# 检查databus 异常集群注册是否正常
curl http://${datahubapi_cluster_ip}:8000/v3/databus/clusters/{cluster_name}/
curl http://${datahubapi_cluster_ip}:8000/v3/databus/clusters/get_cluster_info/?cluster_name={cluster_name}
curl http://${datahubapi_cluster_ip}:8000/v3/databus/clusters/{cluster_name}/connectors/
```

如channels注册异常，重新部署datahubapi，channels信息清理可以使用脚本：

```
# 清理channels信息
python scripts/delete_channels_register.py -d
```

如databus异常，可以重新部署databus尝试解决，清理databus可以使用脚本：

```
sh scripts/uninstall_databus.sh
```

出现使用接口`get_cluster_info`无法查询到信息，检查channel的tags是否注册成功，tags的数据存储在`bkdata_basic.tag_target`表：

```
datahubapi_cluster_ip=`kubectl get service -n bkbase bkbase-datahubapi -o=jsonpath='{.spec.clusterIP}'`
curl http://${datahubapi_cluster_ip}:8000/v3/databus/channels/?tags=inland
curl http://${datahubapi_cluster_ip}:8000/v3/databus/channels/?tags=op
```

### 3. datahubapi注册channel报错

#### 3.1 对象已存在，无法添加

当前使用`./scripts/delete_channels_register.py -d`删除所有channel后，重新部署datahubapi注册channel报"对象已存在, 无法添加"错误，需检查metadata数据库下的channel数据是否已经清除。

```
kubectl exec -it -n bkbase bkbase-mysql-mysql-master-0 -master-0 -- mysql -h bkbase-mysql-mysql-master-0  -uroot -pblueking bkdata_meta
select * from databus_channel_cluster_config;
-- 删除channel数据
delete from databus_channel_cluster_config;
```

#### 3.2 datahubapi注册scenario报错

当前使用hook脚本进行注册，方式如下：

```
datahubapi_cluster_ip=`kubectl get service -n bkbase bkbase-datahubapi -o=jsonpath='{.spec.clusterIP}'`
curl http://$datahubapi_cluster_ip:8000/v3/access/admin/init_scenario_channel/
```

检查数据库表记录信息：正常情况下会有记录

```
kubectl exec -it -n bkbase bkbase-mysql-mysql-master-0 -master-0 -- mysql -h bkbase-mysql-mysql-master-0  -uroot -pblueking bkdata_basic -e "select * from access_scenario_storage_channel;"
```


检查datahubapi的日志：

```
kubectl exec -it -n bkbase bkbase-datahubapi-6cc9d5764-q424m -- /bin/bash
cd /app/logs/
tail -f sys.log
```

### 4. pulsar重新初始化报错

如果使用持久化存储，再次执行初始化会报数据异常，需要清理zk和持久化的数据。
清理zk命令参考：

```
kubectl exec -it -n bkbase bkbase-zookeeper-0 -- zkCli.sh
deleteall /bkbase_pulsar
```

### 5. metaapi获取可用地域记录

```
curl http://bkbase-metaapi:8000/v3/meta/tag/geog_tags/
```

默认地域部署：metaapi 和 metadata values中 GEOG_AREA_CODE 设置为对应地域

### 6. dgraph部署使用HA集群模式

`.Values.dgraph.single.enabled` 改为false， dgraph会以HA集群模式部署，修改values.yaml的`dgraph.master.host1/host2/host3`为：bkbase-dgraph-bkbase-dgr-alpha
HA群模式部署初始资源：6实例(3zero, 3alpha), 单zero占用1c2g,单alpha占用4c8g

如Dgraph更换了地址，metadata会将信息写入到zookeeper，需要清理zookeeper的/metadata znode。

### 7. 处理接入页面授权ip为空问题

目前需要运维人员手动维护这些ip地址，操作方法如下：

```
insert into access_host_config(ip, data_scenario, action, ext,description) values(
'XXXXXXXXXXXXXX',
'db',
'deploy',
'inland',
'desc'
);
​
insert into access_host_config(ip, data_scenario, action, ext,description) values(
'XXXXXXXXXXXXX',
'http',
'deploy',
'inland',
'desc'
);
```

### 8. AIOps服务CreateContainerConfigError问题

因默认aiops-default命名空间在部署aiops服务时不存在，或权限不足，没有创建成功configmap，所以会出现CreateContainerConfigError问题，可以先destroy aiops，然后重新部署。

解决：

```
# 创建命名空间，并授权相应权限
​
# destroy aiops
helmfile -f 25-aiops.yaml destroy
​
# 部署aiops
helmfile -f 25-aiops.yaml sync
```

### 9. AIOps服务更新操作

因一些逻辑问题，进行更新操作时，需要先进行卸载，参考步骤：

```
kubectl delete configmaps -n aiops-default aiops-env
helmfile -f 25-aiops.yaml destroy
helmfile -f 25-aiops.yaml sync
kubectl get services -n aiops-default | grep service- | grep -v bkbase- | awk '{print $1}' | xargs -I {} kubectl delete service {} -n aiops-default
kubectl get deployments -n aiops-default | grep -v bkbase | awk '{print $1}' | xargs -I {} kubectl delete deployments {} -n aiops-default
```
