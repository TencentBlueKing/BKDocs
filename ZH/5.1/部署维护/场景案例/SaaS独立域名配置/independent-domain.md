# 企业版社区版 SaaS 独立域名配置

## 说明

- 假设 PaaS 平台的域名 `PAAS_DOMAIN` 是: `paas.bking.com`。
- SaaS 通过 PaaS 平台部署到正式环境, 可以通过 `http:/paas.bking.com/o/{app_code}/` 正常访问到。
- 此时, 通过配置独立域名, 可以通过 `http://{app_code}.bking.com/` 访问到。
- 注意: 独立域名必须同 `PAAS_DOMAIN`处于同一个一级域名下, 因为要使用 Cookie 进行登录态同步( PaaS 项目配置 `BK_COOKIE_DOMAIN`)。
- 该文档支持配置使用独立域名访问 SaaS 应用, 但是保持 `/o/{app_code}/` 路径, 这样做的好处: 1) 应用代码不需要做修改 。2) 同时独立域名及在桌面访问该应用。

目前的流量链路: `PaaS 一级 Nginx 服务器 -> APPO 二级 Nginx 服务器 -> {app_code}.sock`。

切入点在: `PaaS 一级 Nginx 服务器` 这里, 增加一个独立域名配置, 使得 `独立域名 一级 Nginx 服务器 -> APPO 二级 Nginx 服务器 -> {app_code}.sock`

## Nginx 配置

到 `PaaS 一级 Nginx 服务器` (PaaS 域名配置的 Nginx 服务器), 新增 `独立域名配置`

以开发框架为例: app_code = `bk_framework`; 由于域名不支持下划线, 配置实例中独立域名使用 `bk-framework.bking.com`

增加 Nginx 配置文件 `bk_framework.conf`, `reload` 生效后, 可以通过 `http://bk-framework.bking.com/` 独立域名访问

## HTTP 配置

```bash
server {
    listen 80;
    server_name  bk-frameowrk.bking.com;

    client_max_body_size    512m;
    access_log  /data/bkee/logs/nginx/bk_framework_access_fqdn.log;

    # route to the /o/{app_code}/
    location / {
        proxy_pass http://PAAS_AGENT_PROD/o/bk_framework/;
        proxy_pass_header Server;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_read_timeout 600;
    }

    location ~ ^/o/bk_framework/ {
        proxy_pass http://PAAS_AGENT_PROD;
        proxy_pass_header Server;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_redirect off;
        proxy_read_timeout 600;
    }
}
```


## HTTPS 配置

HTTPS 配置(除了 `server_name`, `access_log` 和 `location`, 其他 SSL 相关配置需要同 `PaaS` 域名配置)

```bash
server {
    listen 443 ssl;
    listen 80;
    server_name  bk-frameowrk.bking.com;

    client_max_body_size    512m;
    access_log  /data/bkee/logs/nginx/bk_framework_access_fqdn.log;

    include /data/bkee/etc/nginx/bk.ssl;
    # force https-redirects
    if ($scheme = http) {
        return 301 https://$server_name$request_uri;
    }

    # route to the /o/{app_code}/
    location / {
        proxy_pass http://PAAS_AGENT_PROD/o/bk_framework/;
        proxy_pass_header Server;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_read_timeout 600;
    }

    location ~ ^/o/bk_framework/ {
        proxy_pass http://PAAS_AGENT_PROD;
        proxy_pass_header Server;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Host $http_host;
        proxy_redirect off;
        proxy_read_timeout 600;
    }
}
```
