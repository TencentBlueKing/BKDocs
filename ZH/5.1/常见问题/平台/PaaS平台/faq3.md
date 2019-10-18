# PaaS 重置访问密码

```bash
# admin密码修改错误后，无法登陆。如何后台重置密码？  
source /data/install/utils.fc

ssh $PAAS_IP
workon login
export BK_ENV='production'
python manage.py shell
# 看到python终端后输入, 密码'xxxxxx'改为自己要重置的内容
from bkaccount.models import BkUser
password = 'xxxxx'
all_user = BkUser.objects.filter(username='admin')
for user in all_user:
	user.set_password(password)
	user.save()
# 然后退出终端
unset BK_ENV
```

# PaaS 登陆提示 502 Bad GateWay

访问`集成平台`（open_paas）容易出现 502，原因比较多

- 确认 open_paas 4 个 web 服务启动正常，且可以访问（最可能的原因），注意如果端口被占用，web 访问将启动失败；
- 确认防火墙策略，即 nginx 所在服务器能够请求到`open_paas`所在机器的对应服务`curl http://{open_paas_ip}:8000`
- 确认 nginx 中 paas.conf-server{listen 80;}，如果此时 502，可能是 nginx 部署机器多块网卡，而 listen 使用的网卡和访问域名配置的网卡不同导致的，变更 server{listen{网卡}:80}

# appt 访问报 502 bad gateway

- `http://paas.blueking.com/t/bk_framework/`访问报 502 错误，确认实际访问路径

```bash
# 在paas.conf查到对应访问请求路径
    location ~ ^/t/ {
        proxy_pass http://PAAS_AGENT_TEST;

# 真实访问服务器及端口
upstream PAAS_AGENT_TEST {
    server 10.x.x.x:8010 max_fails=1  fail_timeout=30s;
}
```

- 在 paas 服务器上进行测试`curl http://10.178.181.35:8010`

```bash
[root@nginx-1 /data/bkee/etc/nginx]# curl http://10.x.x.x:8010
curl: (7) Failed connect to 10.x.x.x:8010; 拒绝连接
```

- 在 appt 上进行确认

```bash
# 8010未监听起来
[root@rbtnode2 /data/bkee/etc/nginx]# netstat -lnpt|grep 8010
[root@rbtnode2 /data/bkee/etc/nginx]#

# 确认nginx的路径
[root@rbtnode2 /data/bkee/etc/nginx]# ps -ef|grep nginx
root     17847 26444  0 12:12 pts/1    00:00:00 grep --color=auto nginx
root     20934     1  0 Jul18 ?        00:00:00 nginx: master process nginx
[root@rbtnode2 /data/bkee/etc/nginx]# ll /proc/20934/|grep exe

# 重新reloadnginx，8010起来
[root@rbtnode2 /data/bkee/etc/nginx]# /usr/sbin/nginx -s reload
[root@rbtnode2 /data/bkee/etc/nginx]# netstat -lnpt|grep 8010
tcp        0      0 0.0.0.0:8010            0.0.0.0:*               LISTEN      20934/nginx: master
```

- 重新测试，`http://paas.blueking.com/t/bk_framework/`访问 OK

```bash
[root@nginx-1 ~]# curl http://10.X.X.X:8010
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
        <title>Test Page for the Nginx HTTP Server on Fedora</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <style type="text/css">
            /*<![CDATA[*/

```

# SaaS 部署的超时时间可以自行配置

蓝鲸智云 PaaS 平台部署应用时, 存在一个超时时间, 当应用部署超过超时时间后, 系统主动将部署任务设置为失败.

当前存在两个地方的配置:

- PaaSAgent 默认超时时间: `300s`, 当部署作业执行超过 300s 时, 设置任务状态为失败
- PaaS 部署默认超时时间: `360s`, 注意一定要大于 PaaSAgent 设置的超时时间; 某些情况下网络超时或 PaaSAgent 失联, 确保部署任务不会卡在`正在部署`状态

如果要变更超时时间:

## 1. PaaS Agent 变更

- 登录 PaaSAgent 服务器(APPO/APPT)
- 编辑`paas_agent_config.yaml`, 修改 `EXECUTE_TIME_LIMIT` 字段值
- 重启 PaaSAgent

## 2. PaaS 变更

- 登录 PaaS 服务器
- 编辑 `open_paas/paas/conf/default.py` 中的`EVENT_STATE_EXPIRE_SECONDS`值
- 重启 PaaS

### 如何确认 PaaS 部署正常

首先 `ping {PAAS_DOMAIN}` 确定通域名通

其次 确认所有 healthz 接口正常:

- http://{PAAS_DOMAIN}/healthz/ 开发者中心
- http://{PAAS_DOMAIN}/login/healthz/ 登录服务
- http://{PAAS_DOMAIN}/api/healthz/ esb 接口
- http://{PAAS_DOMAIN}/console/healthz/ 桌面
- http://{PAAS_DOMAIN}/v1/healthz/  appengine

healthz 接口会检查服务本身及其所有外部依赖, 若服务不可用或依赖有问题则非 200 并提示错误

如果有问题, 根据相应错误处理  

### 在开发者中心无法查看日志

- 确认 es 服务正常, 且 PaaS 中配置的 es 地址正确
- 确认在 appo/appt 服务器上均部署了 `paas_plugins/log_agent`
- 确认部署了 `paas_plugins/log_parser`
- 确认 `log_agent`及`log_parser`的 redis 配置一致
- 确认所有机器的时区及时间一致(**重要**)


