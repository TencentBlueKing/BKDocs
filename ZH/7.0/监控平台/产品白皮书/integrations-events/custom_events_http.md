# 自定义上报 HTTP JSON数据格式

自定义上报是支持用户不安装 Agent 的情况下，直接通过 HTTP 上报的方式，常见的就是是在程序里面进行打点打报。

自定义上报主要是注册自定义上报，只有先注册了才可以进行打点上报，分为自定义事件和自定义指标数据。

## 前置步骤


**自定义事件数据上报工作原理**：

![-w2021](media/15887429342933.jpg)


## 功能说明

导航： 集成 -> 自定义事件 -> 新建

![](media/16613202752414.jpg)

查看上报的情况

![](media/16613202949601.jpg)

查看相关数据，通过检查视图
![](media/16613203148233.jpg)




#### 自定义事件上报

自定义事件利用 http 协议，通过 bkmonitorproxy 上报事件数据。

1. 上报 IP 及端口
   bkmointorproxy 服务端口为 10205。而为了让在不同云区域下的主机都可以正常上报数据，监控平台将 bkmonitorproxy 部署到各个云区域：
    - 直连区域
      bkmonitorproxy 将会由部署到指定的直连区域主机上，。
    - 非直连区域
      bkmonitorproxy 将会部署到各个非直连区域的 GSE proxy 主机上。此时，需要参考页面上对应云区域的上报 IP。进一步，对于有条件搭建域名服务的环境，可以考虑在不同云区域下搭建独立的域名服务，为 GSE proxy 提供统一的域名，方便不同云区域的上报域名统一。
       如下图，页面查找上报 IP：
       
#### 上报格式说明

- 上报格式：json
- 参数说明：
- data_id：数据管道 ID，一个事件组使用同一个数据管道 ID
- access_token：数据通道标识验证码，防止数据误上报至其他管道
- data：上报事件集合
  - event_name：事件标识名
  - target：事件产生来源，可以理解为监控目标
  - event：事件详细内容
    - content：事件具体内容文字描述
  - dimension：事件维度，具体字段及内容可自定义填写
  - timestamp：事件发生时间，单位 ms

#### 使用样例-自定义事件上报

自定义系统事件监控，需要检查上报系统登录异常事件，通过 curl 上报样例：

```bash
curl -X POST http://${PROXY_IP}:10205/v2/push/ -d '{
    "data_id": 1500006,
    "access_token": "2e5a9c5c05394df2a6d0c0347f1d7c77",
    "data": [{
        "event_name": "login_failed",
        "target": "0:192.168.0.1",
        "event": {
            "content": "user->[user00] login failed"
        },
        "dimension": {
            "module": "db",
            "set": "guangdong"
        },
        "timestamp": 1587218838000
    }]
}'
#其中timestamp必须为13位，可由 date +%s000 生成
```

使用 Python 语言 requests 库上报事件样例

```python
# -*- coding: utf-8 -*-
import datetime
import time
import requests
import json
import random

timestamp=int(time.time() * 1000)

#PROXY_IP
PROXY_IP='X.X.X.X'  #直连区域可填此IP
PROXY_URL='http://%s:10205/v2/push/'%(PROXY_IP)

#data_id
DATA_ID=00000000    #修改为自己的data_id
#access_token
ACCESS_TOKEN="XXXXX" #修改为自己的access_token

result = requests.post(PROXY_URL, data=json.dumps({
 "data_id": DATA_ID,
 "access_token": ACCESS_TOKEN,
 "data": [{
     "event_name": str(random.random())+" my event __name__",
          "event": {
               "content": "user->[root] login failedt" #事件内容数据类型是字符串
      },

 "target": "0:192.168.0.1", #修改为自己的设备IP
 "dimension": {
     "module": "db",         #维度必须为字符串
     "location": "guangdong" #维度必须为字符串
 },
 "timestamp": timestamp
 }]
}))
print(result.text)
```

返回内容：

```bash
{"code":"200","message":"success","request_id":"a75ad22e-3c4f-4481-9096-c4947bf47187","result":"true"}
```

表示上报成功。


### 自定义命令行工具

具体查看[自定义命令行工具介绍](../integrations-events/custom_report_tools.md)

### 注意事项

- API 频率限制 1000/min，单次上报 Body 最大为 500KB；如果有更大量级数据的上报需求，请考虑使用插件方式上报数据.
- bkmonitorproxy 部署说明
  - 直连区域
    直连区域的部署依赖环境管理员通过监控后台提供的命令进行部署。需要注意，部署的直连区域机器 10205 端口应该保持可用，并确保直连区域机器到该机器间的网络可用。部署操作命令如下：

```bash
# 登录到中控机
source /data/install/utils.fc
ssh $BKMONITORV3_MONITOR_IP
workon bkmonitorv3-monitor
# 执行部署bkmonitorproxy
./bin/manage.sh deploy_official_plugin --plugin_name bkmonitorproxy --target_hosts ${target_ip},${target_ip}
```

> 其中填写的 target_ip 将会在页面上显示为云区域 0(直连区域)的上报 IP

- 非直连云区域
  - 只要是创建了自定义上报，非直连的云区域会自动创建并下发配置。需要等待 5 分钟左右。默认是部署在和 GSE Proxy 相同的服务器上。


