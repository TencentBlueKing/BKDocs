# 社区版 5.1-6.0 蓝鲸业务拓扑升级指引

> 适用版本，5.1 升级至 6.0.3

## 注意事项

* <font color="#dd0000">此升级文档只针对用户蓝鲸业务拓扑中，不存在自定义层级、自定义服务模板的场景，如遇自定义升级的场景，请针对用户自身情况进行处理 </font>
* <font color="#dd0000">**升级过程中会删除蓝鲸业务当前的所有业务拓扑，服务模板与集群模板**</font>
* 蓝鲸后台服务部署完成后，方可执行相关业务拓扑升级操作

## 开始升级

### 转移主机

1. 确认蓝鲸后台服务器中 `/data/bkce/.installed_module` 内容，该文件描述了蓝鲸后台部署分布，用作蓝鲸后台服务器 IP 转移至蓝鲸业务对应的模块

2. 转移蓝鲸业务中所有的主机至蓝鲸业务空闲机

### 删除原有拓扑结构

1. 蓝鲸后台服务器请求 CMDB 接口，开放页面修改蓝鲸业务拓扑限制

    ```bash
    source /data/install/utils.fc
    curl -H 'BK_USER:admin' -H 'BK_SUPPLIER_ID:0' -H 'HTTP_BLUEKING_SUPPLIER_ID:0' -X POST $BK_CMDB_IP0:9000/migrate/v3/migrate/system/user_config/blueking_modify/true 
    
    # 预期返回内容
    {
     "result": true,
     "bk_error_code": 0,
     "bk_error_msg": "success",
     "permission": null,
     "data": "modify system user config success"
    }
    ```

2. 删除蓝鲸业务各个集群

    * 上一步执行成功后，蓝鲸业务集群的节点信息中即可看到 `删除节点` 选项，请手动删除所有蓝鲸业务下的集群

    ![bktopo](../../assets/bk_topo.png)

3. 删掉所有的蓝鲸集群模板与进程模板

    ```bash
    cd /data/install && source utils.fc && /opt/py36/bin/python ${CTRL_DIR}/bin/create_blueking_set.py -c ${BK_PAAS_APP_CODE}  -t ${BK_PAAS_APP_SECRET} --delete
    ```

### 重建蓝鲸业务拓扑

* 蓝鲸后台中控机执行

    ```bash
    ./bkcli initdata topo
    ```

#### 温馨提示

重建 topo 后如果在主机监控-点击进程，出现 `KeyError` 的报错，请在 10 分钟后再进行查看是否恢复了正常。前提是已经将相关主机的 processbeat 插件升级至最新版本。
