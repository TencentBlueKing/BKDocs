# PaaS 登陆无响应

**校验登陆接口**

- 登陆`open_paas`服务器，进入日志目录(`cd /data/bkce/logs/open_paas`)，并运行命令`tail -f *login*`
- 点击浏览器出错的平台链接，观察日志是否滚动，请求到，且有`is_login`字样
- 通过查看日志中的`is_login`接口调用日志对应的域名来确认调用登录校验接口的方式，是直接调用 login 还是通过 ESB 调用。
- 在服务器上用 curl 模拟调用`is_login`方法看是否 OK `curl -v http://xxxx/is_login?bk_cookie=xxxxxxxx`
- 查看 logs/open_paas/login 相关日志特别是 login_uwsgi 的日志，看是否有请求到

常见原因：

1. 其他机器到 paas 请求时有 http 代理被劫持。
2. 浏览器 cookie 缓存等问题（换 chrome 无痕，或者其他浏览器）

**请求到了 PaaS 但校验失败**

应用日志里提示"Login validity is illegal"

这种常出现在 paas 两台机器之间的时间不同步。表现为有时候可以正常登陆，有时候不能。 原因是，A 机器生成的 cookie，到 B 机器校验时间时，因为时间间隔大于默认的 1 分钟，会 判断为过期，导致失败

解决方法：

- 调整两台服务器时间，保持同步。
- 若客观原因导致没法同步时间，可以通过 `open_paas/login/conf/default.py` 中的 `BK_TOKEN_OFFSET_ERROR_TIME` 配置修改默认容忍的时间间隔。

- 因没有正确修改 `/data/install/globals.env` 下的域名配置。
    ```bash
    vim /data/install/globals.env
    # 域名信息
    export BK_DOMAIN="bk.com"            # 蓝鲸根域名(不含主机名)
    export PAAS_FQDN="paas.$BK_DOMAIN"       # PAAS 完整域名
    export CMDB_FQDN="cmdb.$BK_DOMAIN"       # CMDB 完整域名
    export JOB_FQDN="job.$BK_DOMAIN"         # JOB 完整域名
    export DOCS_FQDN="docs.$BK_DOMAIN"       # 私有文档准备
    export APPO_FQDN="o.$BK_DOMAIN"          # 正式环境完整域名
    export APPT_FQDN="t.$BK_DOMAIN"          # 测试环境完整域名
    ```
    如上 PAAS CMDB JOB 完整域名格式 “.” 这个连接符一定是在变量 `$BK_DOMAIN` 前面，`$BK_DOMAIN` 变量不可修改为实际值，保留变量格式。