# 回调接入系统失败

## 1. 背景

在权限中心配置权限, 选`资源实例/属性`时会调用对应接入系统的接口

如果接入系统本身服务不可用(unavailable/接口非 200), 或者网络问题等, 会导致调用失败, 页面报错提示, 用户无法配置或申请权限

相关[错误码](../ErrorCode.md): 
- 19020xx, 调用第三方请求的通用错误，比如网络不通等;
- 19022xx：回调第三方接口错误

接入系统回调接口本身协议及错误码: 
- [资源拉取 API 说明](../../../Reference/API/03-Callback/01-API.md)

## 2. 产品页面表现

`接入系统资源接口请求失败`

![-w2021](../../../assets/HowTo/FAQ/Debug/Callback_01.jpg)

内容示例:

```
接入系统资源接口请求失败: bk_job's API response status code is `500`, should be 200! call bk_job's API fail! you should check the network/bk_job is available and bk_job's log for more info. request: [POST /iam/api/v1/resources/task/template body.data.method=fetch_instance_info](system_id=bk_job, resource_type_id=job_template)
```

注意这里 message 会包含的内容: 

```python
request_detail_info = (
            f"call {self.system_id}'s API fail! "
            f"you should check: "
            f"1.the network is ok 2.{self.system_id} is available 3.get details from {self.system_id}'s log. "
            f"[POST {urlparse(self.url).path} body.data.method={data['method']}]"
            f"(system_id={self.system_id}, resource_type_id={self.resource_type_id})"
        )

error_message = f"{reason}. {request_detail_info}"        
```

- reason: 报错原因描述
- request_detail_info
    - 系统: system_id
    - 资源类型: resource_type_id
    - http method
    - url
    - body.data.method

## 3. 处理

**重要: 从提示信息中可以获取的信息**:

- 哪个接入系统
- 哪个接口
- 参数/请求/返回/状态码/报错等详情

**重要: 该找谁来进一步处理问题**:

- 根据报错信息, 理解问题
- 如果是环境/网络等问题, 找**运维**解决,
- 如果是接入系统接口问题, 根据报错信息, 到接入系统捞取对应日志, 确定问题, 找对应的**开发/负责人**解决(注意是对应系统的`开发/负责人`, 不是找权限中心`开发/负责人`)

**报错的日志在哪里**:

- 权限中心 SaaS 日志 `component.log / bk_iam.log`


**注意**: 一定不要单纯截一张图后提单到`权限中心`模块, 请务必获取到详细报错信息, 并且按照以上说明定位问题. 确实无法确定的再提单!

## 接入系统实现回调接口

权限中心资源拉起时, 会根据资源拉取协议[文档](../../../Reference/API/03-Callback/01-API.md)向接入系统发起请求, 接入系统需要返回协议规定的内容

当资源拉取接口失败, 此时无法配置权限; 

所以接入系统实现相关接口时, 需要**记录相关的流水日志**

- 请求时间
- 请求基本信息
- 响应基本信息
- request_id
- 如果 500, 需要记录详细报错堆栈


