## 1 场景 1： JSON hijacking

### 1.1 漏洞描述

`JSON hijacking`是 csrf 漏洞的一种，CGI 以 JSON 形式输出数据，黑客控制的第三方站点以 CSRF 手段强迫用户浏览器请求 CGI 得到 JSON 数据，黑客可以获取敏感信息

### 1.2 漏洞检测

使用工具获取 json 数据

### 1.3 漏洞修复

可使用以下任意办法防御 JSON Hijacking 攻击

1. 在请求中添加 token（随机字符串）

2. 请求 referer 验证(限制为合法站点，并且不为空)

### 1.4 注意事项

在线 json 防御被外域恶意调用只限制了 referer，但是允许空 referer 访问：比如本地 html，还有某些伪协议远程调用时是没有 referer 的。从而导致问题持续。所以空 referer 也是不安全的

### 1.5 解决

蓝鲸应用开发框架已经集成了 django 的 csrf 中间件来预防 csrf 攻击，一般比较重要的增删改操作都会使用 post 请求，一般不会出现问题。但是如果是 get 请求去获取敏感信息的话，就有可能存在上述问题，对于使用 get 方式获取有敏感信息的 cgi，建议换成 post 方法或增加 referer 校验
