## 对接 Open-falcon
对接 Open-falcon 的机制：Open-falcon 模板中包含 callback（回调）功能，在回调地址中填写故障自愈分配给 Open-falcon 的告警接收地址.
![](media/15360334804753.jpg)

### 1. Open-falcon 模板中添加故障自愈的 Callback 地址
![](media/15259229587200.jpg)
图 1. Open-Falcon 配置 Callback 地址)

### 2. Open-falcon 告警自愈历史
下面是 Nginx 模块磁盘告警的自愈示例，匹配 Nginx 模块的磁盘清理套餐，清理 Nginx 模块的日志文件，整个过程不到 30 秒。
![](media/15259231536432.jpg)
图 2. 磁盘告警的自愈示例

### 3. Open-falcon 告警处理的特别之处

Open-Falcon 的资源标识 `endpoint` 默认是主机名，于是故障自愈将蓝鲸 CMDB 自动上报的主机名转换为 IP，然后在做匹配、告警自动处理。




