# 回调第三方系统失败

## 1. 背景
权限中心在配置权限，选资源实例时会调用对应接入系统的接口进行查询，由于接入系统提供的接口和网络等问题导致权限中心调用失败，进而可能出现用户无法配置或申请权限等问题，所以需要根据错误码和日志进行排查解决

## 2. 回调接入系统接口依赖服务
1. MySQL
2. Redis，主要用于缓存
3. IAM Backend，查询回调接口的Host和URL Path等信息
4. Component - ResourceProvider, 回调接入系统API

## 3. 错误码
1. 19020xx：调用第三方请求的通用错误，比如网络不通等
2. 19021xx：IAM 后台请求错误
3. 19022xx：回调第三方接口错误

详细错误码可以点击查询[错误码](../ErrorCode.md)

回调接口本身返回的错误码可点击查询[资源拉取 API说明](../../../Reference/API/03-Callback/01-API.md)

## 4. 通用排查步骤
### 4.1 healthz 接口查询

1. 确认 SaaS 服务健康`curl -vv http://{PAAS_HOST}/o/bk_iam/healthz`, 正常应该返回`ok`
2. healthz 接口检测包括：MySQL、Redis、Celery、IAM 后台、用户管理 ESB 接口

### 4.2 错误码与日志结合排查

1. 首先确认错误码，若有错误码，则根据错误码类型进行 [查询](../ErrorCode.md)
2. 依次查询权限中心 SaaS 日志 component.log / bk_iam.log，根据查询到的日志信息进行错误分析即可

## 5. 常见回调异常场景
1. 接入系统回调接口502
![](../../../assets/HowTo/FAQ/Debug/Callback_01.jpg)

* 原因：回调接入系统接口502，可能是接入系统服务未启动或回调的HOST&Path有错误

* 解决方式
```
查询具体IAM SaaS日志 component.log，获取详细报错信息，给到对应接入系统进行更近一步的排查
```


