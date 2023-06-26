# 日志关键字监控

日志关键字监控指的是通过日志的里面关键字匹配出来的数量进行告警判断是否有问题，是一种比较常见的监控需求。在监控平台有两种日志关键字配置方法。 

## 前置步骤

先了解两种日志关键字的工作原理：

### 第一种：基于日志平台数据的日志关键字

日志平台的数据不敢是自采集的，第三方 ES 的还是数据平台的最终都是存储在 ES 的存储里面。所以这类数据的日志关键字都是基于 ES 查询语法日志关键。

* **优点**：日志集中存储，当接到日志关键字告警后可以直接在日志平台进行查询和定位

* **缺点**：如果日志量很大将占用大量的带宽和存储资源。另外就是查询方法是依据分词原理。像 I/O 默认会拆分 I 和 O 来进行匹配

具体配置方法： [日志关键字告警-基于ES存储的数据](./log_monitor.md)

### 第二种：在 Agent 端进行日志匹配生成事件

在日志所在的服务器进行日志关键字的匹配，将周期内的统计值和样本数据进行上报。再通过告警策略生成告警事件达到告警的目的。

* **优点**：在日志量很大，存储资源不够的情况下也可以满足日志关键字的需求。匹配方法为正则方式更容易配置和理解。满足及时告警需求不受日志传输的延迟影响
* **缺点**：只有一条最新的采样数据，如果需要更多信息需要通过其他方式去查看

接下来就主要介绍第二种日志关键字事件的配置方法

## 依赖 

 确保采集进程已经启动

- Linux

    ```bash
    ps -ef | grep bkmonitorbeat
    ```

- Windows

    ```bat
    tasklist | findstr bkmonitorbeat
    ```
    
- 如果没有，则需要通过**节点管理**应用安装，并托管启动。并且确保是最新的版本。

## 第一步：配置采集

导航：集成 -> 数据采集 -> 新建采集

![](media/16617837359174.jpg)

![](media/16617837617833.jpg)



### 日志路径

填写轮转的日志绝对路径就可以。如：

```bash
/var/log/nginx/nginx.log 
```

```bash
/var/log/xxxx/error.%Y%m%d.log
```

## 关键字是如何被匹配的

在配置关键字的过程中，关键字规则中有2个输入框，第1个输入框是规则的名称，注意不要输入空格，格式为[a-z][A-Z][0-9],第2个输入框是这表达式


![](media/16617838961057.jpg)


![](media/16617839102006.jpg)

用python代码表示如下：

```
from __future__ import print_function
import re
pattern = 'ERROR'
logtext = "2020-05-22 11:13:16 ERROR 28276 access.data processor.py[172] strategy(503),item(504) query records error"
r = re.compile(pattern)
print(r.search(logtext))
```
![](media/16617839555604.jpg)



### 关键字正则规则 

正则使用的是 Golang 的正则语法，如果是有复杂的需求建议先进行调试得到正确的正则表达式， [在线正则调试地址](https://www.debuggex.com/)。

正则参考语法样例：

```bash
([^\s]*)              # 匹配 $http_host
(\d+\.\d+\.\d+\.\d+)  # 匹配 $server_addr,$remote_addr
(\"\d+\.\d+\.\d+\.\d+\,\s\d+\.\d+\.\d+\.\d+\"|\"\d+\.\d+\.\d+\.\d+\") #匹配 "$http_x_forwarded_for"
(\[[^\[\]]+\])     #匹配[$time_local]
(\"(?:[^"]|\")+|-\")  # 匹配"$request","$http_referer"，"$http_user_agent"
(\d{3})               # 匹配$status
(\d+|-)               # 匹配$body_bytes_sent
(\d*\.\d*|\-)         # 匹配$request_time,$upstream_response_time'
^                     # 匹配每行数据的开头
$                     # 匹配每行数据的结局
```

### 维度提取

关键字不单可以匹配正则还可以从行日志中提取出维度信息，来细化关键字的内容，可以使用正则提取，例如：

```bash
    # 假如我的日志文本是这样的
    "2020-05-22 11:13:16 ERROR    28276   access.data             processor.py[172] strategy(503),item(504) query records error, System Request 'metadata_v3' error"
        
    # 那么可以填如下正则，匹配上ERROR的同时，将我的代码模块、文件名信息提取出来
    "ERROR[ 0-9]+(?P<module>[a-z\.]+) +(?P<filename>[^\[]+).*"
```


## 如何配置关键字告警

![](media/16617840637294.jpg)
![](media/16617840714593.jpg)



## 使用建议

- 单行日志大小：单行太长，会导致正则匹配性能较差，建议 < 1k 字节
- 日志每秒产生速率：建议 < 5w 每秒
- 日志文件大小速率：建议 < 50M 每秒
- 正则数量限制：即页面配置的规则数：建议 < (50M / 实际产生大小速率)每秒
    - 假如当前机器所有需要监听的日志文件，日志产生速率为 1M/s。则建议规则数 < 50 个
    - 假如当前机器所有需要监听的日志文件，日志产生速率为 2M/s。则建议规则数 < 25 个
- 正则表达式，尽可能的精确，减少".*"这种用法，提高效率。

超过上面限制，会导致处理不过来，队列积压。 每个周期上报的统计数值会不准确。

## 问题排查

六、问题排查
如以上配置均正确，日志关键字功能还是异常，那么可以开启bkmonitorbeat的debug级别日志，然后重启bkmonitorbeat。运行两分钟后将日志打包发给我们的开发人员排查

linux

```
vim /usr/local/gse/plugins/etc/bkmonitorbeat.conf
# 修改logging.level级别为debug
# 手动重启bkmonitorbeat，或者通过节点管理
cd /usr/local/gse/plugins/bin/ && ./restart.sh bkmonitorbeat
# 两分钟后，打包/var/log/gse/bkmonitorbeat*相关日志文件
```

Windows

```
打开 c:\gse\plugins\etc\bkmonitorbeat.conf
rem 修改logging.level级别为debug
rem 手动重启bkmonitorbeat，或者通过节点管理
cd c:\gse\plugins\bin && restart.bat bkmonitorbeat
rem 两分钟后，打包c:\gse\logs\bkmonitorbeat*相关日志文件  
```


