## 1 场景1： JSON hijacking

### 1.1 漏洞描述

`JSON hijacking`是csrf漏洞的一种，CGI以JSON形式输出数据，黑客控制的第三方站点以CSRF手段强迫用户浏览器请求CGI得到JSON数据，黑客可以获取敏感信息

### 1.2 漏洞检测

使用工具获取json数据

### 1.3 漏洞修复

可使用以下任意办法防御JSON Hijacking攻击

1. 在请求中添加token（随机字符串）

2. 请求referer验证(限制为合法站点，并且不为空)

### 1.4 注意事项

在线json防御被外域恶意调用只限制了referer，但是允许空referer访问：比如本地html，还有某些伪协议远程调用时是没有referer的。从而导致问题持续。所以空referer也是不安全的

### 1.5 解决

蓝鲸应用开发框架已经集成了django的csrf中间件来预防csrf攻击，一般比较重要的增删改操作都会使用post请求，一般不会出现问题。但是如果是get请求去获取敏感信息的话，就有可能存在上述问题，对于使用get方式获取有敏感信息的cgi，建议换成post方法或增加referer校验
