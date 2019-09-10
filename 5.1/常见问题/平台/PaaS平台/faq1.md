## PaaS登陆无响应

**校验登陆接口**

- 登陆`open_paas`服务器，进入日志目录(`cd /data/bkce/logs/open_paas`)，并运行命令`tail -f *login*`
- 点击浏览器出错的平台链接，观察日志是否滚动，请求到，且有`is_login`字样
- 通过查看日志中的`is_login`接口调用日志对应的域名来确认调用登录校验接口的方式，是直接调用login还是通过ESB调用。
- 在服务器上用curl 模拟调用`is_login`方法看是否OK `curl -v http://xxxx/is_login?bk_cookie=xxxxxxxx`
- 查看 logs/open_paas/login 相关日志特别是login_uwsgi的日志，看是否有请求到

常见原因：

1. 其他机器到paas请求时有http代理被劫持。
2. 浏览器cookie缓存等问题（换chrome无痕，或者其他浏览器）

**请求到了PaaS但校验失败**

应用日志里提示"Login validity is illegal"

这种常出现在paas两台机器之间的时间不同步。表现为有时候可以正常登陆，有时候不能。 原因是，A机器生成的cookie，到B机器校验时间时，因为时间间隔大于默认的1分钟，会 判断为过期，导致失败

解决方法：

- 调整两台服务器时间，保持同步
- 若客观原因导致没法同步时间，可以通过`open_paas/login/conf/default.py` 中的`BK_TOKEN_OFFSET_ERROR_TIME`配置修改默认容忍的时间间隔
