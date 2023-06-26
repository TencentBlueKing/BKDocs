# 容器数据采集介绍

容器的数据采集分为：容器基础性能数据采集、容器的日志采集（标准输出日志采集、非标准输出日志采集）、容器内运行的应用程序的 Metric 采集。

数据的采集机制是：在容器应用的配置文件中打 label，GSE AGENT 采集器通过 label 采集数据上报到数据平台。

## 容器基础性能数据采集

基础性能数据，包含容器 CPU、内存、磁盘等数据。蓝鲸容器服务会统一给容器添加 label：*"io.tencent.bkdata.baseall.dataid": "6566"*。
容器部署后 GSE AGENT 会采集容器的基础性能数据并上报的数据平台，`整个过程用户无需任何操作`。

## 容器的日志采集

### 容器标准输出日志采集

标准输出日志是指容器 stdout 输出的日志。蓝鲸容器服务会给每个接入的项目申请一个标准日志采集的 dataid，并写入到容器的 label：*"io.tencent.bkdata.container.stdlog.dataid": "{{SYS_STANDARD_DATA_ID}}"* (Kubernetes 需要写入到容器的环境变量中)。
容器部署后 GSE AGENT 会采集容器的基础性能数据并上报到数据平台，`整个过程用户无需任何操作`。

### 容器非标准输出日志采集

非标准输出日志采集是指从指定的日志路径采集日志，蓝鲸容器服务会给每个接入的项目申请一个非标准日志采集的 dataid。用户只需要在容器的配置模板中指定`自定义采集的日志绝对路径`，如下图所示：

<img src='../assets/image0101.png' alt='image0101.png' width='750'>

应用实例化时，会进行以下操作（`整个过程用户无需任何操作`）：

a. 将日志采集的路径和项目的非标准日志采集 dataid 写入到一个 ConfigMap 文件中
```bash
kind: ConfigMap
metadata:
  name: deploy-log-container-1-non-standard-configmap
  namespace: namespace1
data:
  deploy-log.conf: >-
    {"inners": [{"logpath": "{{log_path}}", "dataid": {{SYS_NON_STANDARD_DATA_ID}}, "selectors": []}],
    "mounts": []}
```

b. 将上面的 ConfigMap 配置文件挂载到应用容器的 */etc/{{app_name.conf}}* 路径下

c. 在应用容器的 label 中指定日志采集配置文件在容器内的绝对路径：*"io.tencent.bkdata.container.log.cfgfile": "/etc/{{app_name.conf}}"* (k8s 需要写入到容器的环境变量中)。

```bash
kind: Deployment
metadata:
  name: deploy-log
  labels:
    io.tencent.bcs.namespace: namespace1
    io.tencent.bkdata.baseall.dataid: '6566'
    io.tencent.bkdata.container.stdlog.dataid: {{SYS_STANDARD_DATA_ID}}
    io.tencent.bkdata.container.log.cfgfile: /etc/deploy-log.conf
  namespace: namespace1
spec:
  template:
    spec:
      containers:
        - name: container-1
          volumeMounts:
            - name: non-standard-configmap-1531455724
              mountPath: /etc/
              readOnly: false
          image: 'hub_address.com/paas/k8stest/http-server:latest'
          imagePullPolicy: IfNotPresent
          env:
            - name: io_tencent_bkdata_container_stdlog_dataid
              value: {{SYS_STANDARD_DATA_ID}}
            - name: io_tencent_bkdata_container_log_cfgfile
              value: /etc/deploy-log.conf
      volumes:
        - name: non-standard-configmap-1531455724
          configMap:
            name: deploy-log-container-1-non-standard-configmap

```

### 附加日志数据

用户还可以在应用上设置一些附加数据，这些数据会追加到容器的日志数据中，一起上报到数据平台，标准日志和非标准日志都会追加上这些数据。

<img src='../assets/image0202.png' alt='image0202.png' width='750'>

日志效果如下图：

<img src='../assets/image03.png' alt='image03.png' width='750'>

## Metric 采集

首先，在容器服务->Metric 管理中添加 Metric；

<img src='../assets/image04.png' alt='image04.png' width='750'>

然后，在应用模板中->更多设置中，勾选启用 Metric 数据采集，并选择相应上一步设置的 Metric;

<img src='../assets/image05.png' alt='image.png' width='750'>

最后，实例化应用时，会将相关的 Metric 配置文件一起下发。

<img src='../assets/image06.png' alt='image.png' width='750'>

说明：
- Metric 配置中，勾选了**Prometheus 格式设置**，会在数据平台申请 dataid，并根据 Prometheus 的数据格式在数据平台配置好默认的字段清洗规则，同时将清洗好的字段入库到 ES 中。
- 没有勾选**Prometheus 格式设置**，则只会在数据平台申请 dataid，用户可以页面上点击**数据清洗**，去数据平台配置相应的清洗和入库规则。

### Metric 数据查看

Metric 的数据可以在 监控中心 Dashboard 中查看，具体的使用方法见：

- [监控中心/Dashboard 查询](../monitor/Dashboard/DashboardSearch.md)
