# 蓝鲸监控错误码


一共 7 位, 前两位 33, 中间两位模块编号, 最后两位具体错误码

## 自身服务出错
```
1.#告警配置
2.E01000 = ErrorCode("01000", u"告警配置异常：排查告警配置表")
3.E01001 = ErrorCode("01001", u"告警配置异常，排查告警配置表 alarm_source")
4.E01002 = ErrorCode("01002", u"告警配置异常，排查通知配置表 notice_config")
5.E01003 = ErrorCode("01003", u"告警配置异常，排查收敛配置表 shield_config")
6.E01004 = ErrorCode("01004", u"告警配置异常，排查自动处理配置表 solution_config")
7.# collect
8.E01010 = ErrorCode("01010", u"告警汇总模块异常，排查 collect 模块")
9.# data_access
10.E01020 = ErrorCode("01020", u"数据接入模块异常，排查 data_access 模块")
11.# detect
12.E01030 = ErrorCode("01030", u"异常检测模块异常，排查 detect 模块")
13.# converge
14.E01040 = ErrorCode("01040", u"告警收敛模块出错，排查 converge 模块")
```
## 依赖第三服务出错
```
1.E02010 = ErrorCode("02010", u"调用ESB出错，排查ESB服务")
2.E02020 = ErrorCode("02020", u"数据模块查询异常，排查数据模块数据查询服务")
3.E02030 = ErrorCode("02030", u"Ping告警格式错误，排查GSE SERVER服务")
```

## 依赖基础服务出错
```
1.E03010 = ErrorCode("03010", u"redis 服务出错，排查 redis 服务")
2.E03020 = ErrorCode("03020", u"beanstalk 服务出错，排查 beanstalk 服务")
3.E03030 = ErrorCode("03020", u"kafka  服务出错，排查 kafka 服务")
```

>参考 PaaS 的做法

- 定义枚举或常量错误码到工程

- 关键路径错误, 将错误码打到日志 message 前面, 空格分隔 `logger.exception("%s %s" % (code, message))`

- 关键路径: 调用第三方服务出错 依赖基础服务出错 本身配置出错等

- 最后给出添加的错误码-原因-解决方案, 例如 1301000 settings_error配置错误 排查配置 1301001 appengienNotAvailable 无法访问 排查 appengine 服务正常
