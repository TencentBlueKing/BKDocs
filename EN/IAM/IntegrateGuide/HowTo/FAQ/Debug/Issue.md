# 提单模板

注意事项:
1. 提单前, 请确保已经根据`问题排查`文档进行过问题排查(常见问题/错误码/FAQ 等等)
2. 请记录已获取的信息, 日志, 以及做过哪些定位, 结果是什么
3. 之后提单, 根据模板要求填写详细信息, 给到 IAM 开发

## 权限中心 SaaS 页面报错提单模板

前端大概率是 [常见: SaaS 回调接入系统失败](SaaS-Callback.md) 的问题, 先根据这个文档确认并找相关人员解决.

如果页面看到接口 500, 请到权限中心 SaaS 捞取 500 日志后再提单

如果不是上述文档中的问题

- 标题: `[权限中心 SaaS] xxx 页面报错`
- 内容:

```bash
环境: xxxx

现象描述: xxxxxx
报错截图: xxxx
报错信息: (需要将提示框中信息复制粘贴出来)
复现步骤: xxxxx

后端报错日志: (如果是接口 500)
```


## 接口调用报错提单模板

- 标题: `[xx系统] 调用权限中心错误xxxxxxx`
- 内容:

```bash
系统: xxxx
环境: 上云版/企业版xx环境/社区版xx环境

现象描述: xxxxxxxxxxxx
预期: xxxxxxxxxxx
复现步骤: xxxxxxxxxxxx [务必附加]
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

如果调用方无法提供上述信息, 那么打印记录详细的日志, 再提单!!!!!!(否则无法进行问题定位)

## 其他: 接入系统需要 记录详细日志

接入系统调用逻辑需要记录以下信息: (**以便在排查问题时提供**)

1. 请求时间
2. 请求基本信息: method / url / request body
3. 响应基本信息: status code / response body(包含`code`和`message`)
4. 响应 header 中的 `request_id` 


