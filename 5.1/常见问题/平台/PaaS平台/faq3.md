## PaaS重置访问密码


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

## PaaS登陆提示502 Bad GateWay

访问`集成平台`（open_paas）容易出现502，原因比较多

- 确认open_paas 4个web服务启动正常，且可以访问（最可能的原因），注意如果端口被占用，web访问将启动失败；
- 确认防火墙策略，即nginx所在服务器能够请求到`open_paas`所在机器的对应服务`curl http://{open_paas_ip}:8000`
- 确认nginx中paas.conf-server{listen 80;}，如果此时502，可能是nginx部署机器多块网卡，而listen使用的网卡和访问域名配置的网卡不同导致的，变更server{listen{网卡}:80}

## appt访问报502 bad gateway

- `http://paas.blueking.com/t/bk_framework/`访问报502错误，确认实际访问路径

```bash
# 在paas.conf查到对应访问请求路径
    location ~ ^/t/ {
        proxy_pass http://PAAS_AGENT_TEST;

# 真实访问服务器及端口
upstream PAAS_AGENT_TEST {
    server 10.x.x.x:8010 max_fails=1  fail_timeout=30s;
}
```

- 在paas服务器上进行测试`curl http://10.178.181.35:8010`

```bash
[root@nginx-1 /data/bkee/etc/nginx]# curl http://10.x.x.x:8010
curl: (7) Failed connect to 10.x.x.x:8010; 拒绝连接
```

- 在appt上进行确认

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

- 重新测试，`http://paas.blueking.com/t/bk_framework/`访问OK

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

## SaaS部署的超时时间可以自行配置

蓝鲸智云PaaS平台部署应用时, 存在一个超时时间, 当应用部署超过超时时间后, 系统主动将部署任务设置为失败.

当前存在两个地方的配置:

- PaaSAgent默认超时时间: `300s`, 当部署作业执行超过300s时, 设置任务状态为失败
- PaaS部署默认超时时间: `360s`, 注意一定要大于 PaaSAgent 设置的超时时间; 某些情况下网络超时或PaaSAgent失联, 确保部署任务不会卡在`正在部署`状态

如果要变更超时时间:

#### 1. PaaSAgent变更

- 登录 PaaSAgent 服务器(APPO/APPT)
- 编辑`paas_agent_config.yaml`, 修改 `EXECUTE_TIME_LIMIT` 字段值
- 重启 PaaSAgent

#### 2. PaaS变更

- 登录 PaaS 服务器
- 编辑 `open_paas/paas/conf/default.py` 中的`EVENT_STATE_EXPIRE_SECONDS`值
- 重启 PaaS

## 如何确认PaaS部署正常

首先 `ping {PAAS_DOMAIN}` 确定通域名通

其次 确认所有healthz接口正常:

- http://{PAAS_DOMAIN}/healthz/ 开发者中心
- http://{PAAS_DOMAIN}/login/healthz/ 登录服务
- http://{PAAS_DOMAIN}/api/healthz/ esb接口
- http://{PAAS_DOMAIN}/console/healthz/ 桌面
- http://{PAAS_DOMAIN}/v1/healthz/  appengine

healthz接口会检查服务本身及其所有外部依赖, 若服务不可用或依赖有问题则非200并提示错误

如果有问题, 根据相应错误处理  

## 在开发者中心无法查看日志

- 确认es服务正常, 且PaaS中配置的es地址正确
- 确认在appo/appt服务器上均部署了 `paas_plugins/log_agent`
- 确认部署了 `paas_plugins/log_parser`
- 确认 `log_agent`及`log_parser`的redis配置一致
- 确认所有机器的时区及时间一致(**重要**)


## 登录页面无限跳转

- 确保两台PaaS机器上, login/conf/settings_production.py配置一致
- 两台PaaS机器的机器时间一致(需设置时间同步保证绝对一致)
- 确认网络: 即PaaSAgent服务器能访问到PaaS域名 / cc和job部署所在服务器能访问到PaaS域名

逻辑:
- 到login登录
- 签名token到cookie
- 到SaaS应用, 例如开发框架/作业平台/配置平台, 此时, 该平台会发起post请求到PaaS 服务, 访问login校验, 校验失败, 又跳转回登录页面

极大可能:
- 两台PaaS所在机器时间不一致
- 应用机器到PaaS域名网络不通
