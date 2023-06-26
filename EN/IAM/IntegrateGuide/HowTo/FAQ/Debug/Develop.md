# 开发接入

# 1. 鉴权问题

> 请按照步骤自行排查问题, 如果需要咨询 IAM 开发, `请按以下模板提供相应信息`

接入系统, 调用权限中心接口进行策略拉取/鉴权时, 会构造相应的 http 请求, 发送请求, 获取返回结果, 同本地资源的基本信息进行计算

## 1.1 记录详细日志

所以接入系统调用逻辑需要记录以下信息: (**以便在排查问题时提供**)

1. 请求时间
2. 请求基本信息: method / url / request body
3. 响应基本信息: status code / response body(包含`code`和`message`)
4. 响应 header 中的 `request_id` 

## 1.2 问题排查基本步骤

1. curl 或 ping, 确认可以正常访问到 iam 服务 (网络)
2. 确认 HTTP 状态码 (网络)
3. 查看 response body 错误码, 根据 `code`到 [错误码](../ErrorCode.md) 文档指引确定问题; (大部分问题可以在错误码中找到)
4. 联系 IAM 开发解决
    4.1 描述清楚问题(现象/截图)
    4.2 提供请求详细信息:  上面`1.1 记录详细日志`要求的详细内容
5. 如果有条件能重现请求, 可以看下面的 `3. 接口Debug` 文档, 加入 debug 获取更详细的信息

## 1.3 提单模板

- 标题: `[xx系统] 调用权限中心错误xxxxxxx`
- 内容:

```bash
系统: xxxx
环境: 上云版/企业版xx环境/社区版xx环境

现象描述: xxxxxxxxxxxx
预期: xxxxxxxxxxx
复现步骤: xxxxxxxxxxxx
截图: [better to have]

请求基本信息:
- method: POST
- path: http://xxxxxx/api/v1/policy/query
- request_body: `{xxxx}`

响应基本信息:
- status code: 2000
- response body: `{}`
- request_id: `xxxxxxxxxxx`

从权限中心查询request_id日志结果 (具体见本文档   附录: 权限中心的日志)
```

注意: 如果接入系统前端页面报错, 需要到后台查询`接入系统`访问权限中心打印的详细流水日志; (具体日志位置咨询相关系统的开发)

-----------

# 2. 资源拉取问题(被调用)

权限中心资源拉起时, 会根据资源拉取协议[文档](../../../Reference/API/03-Callback/01-API.md)向接入系统发起请求, 接入系统需要返回协议规定的内容

所以接入系统实现相关接口时, 需要记录相关的流水日志

当资源拉取接口失败, 此时无法配置权限; 接入系统可以查看注册接口的回调流水日志:  请求时间/请求基本信息/响应基本信息/request_id 等, 如果 500, 需要查看下 500 报错原因;

TODO: 补充 saas debug trace 根据 request_id 查看报错堆栈 文档链接