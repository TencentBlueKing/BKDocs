# Nginx

蓝鲸平台的 Web 接入层统一使用 [OpenResty](https://openresty.org/cn/) ，因为部分模块依赖 lua 模块。在模块分布配置文件 install.config 中，为了兼容以前的配置，以 nginx 代替。

## 安装部署

蓝鲸使用 OpenResty 1.15.8.3 版本，通过官方的 rpm 包安装。安装路径为默认的 `/usr/local/openresty/`

安装后，默认的配置文件不符合蓝鲸的需求，通过部署脚本包的配置模板文件（$CTRL_DIR/support-files/templates/nginx/nginx.conf) 渲染生成 Nginx 的主配置文件 `/usr/local/openresty/nginx/conf/nginx.conf`，并新建子配置目录 `/usr/local/openresty/nginx/conf/conf.d/`。以上安装逻辑，统一由 `$CTRL_DIR/bin/install_openresty.sh` 脚本封装。

在安装了 OpenResty 服务的机器上，还会配套安装 `consul-template` 服务，用来动态渲染 nginx 的子配置。通过 `$CTRL_DIR/bin/install_consul_template.sh` 脚本封装：

1. 安装 consul-template rpm 包
2. 读取和 nginx 相关的环境变量，并初始化 consul kv 节点信息，位于 consul kv 的 bkcfg/ 节点下。
3. 将 `$CTRL_DIR/support-files/templates/nginx/*` 的配置模板拷贝到 `/etc/consul-template/templates/` 目录下。
4. 生成 `paas`、`cmdb`、`job`、`nodeman`等模块的 consul-template 配置描述文件到 `/etc/consul-template/conf.d/` 目录下。
5. 启动 consul-template，并设置开机启动

## Nginx 子配置管理

Nginx 的子配置，通过 `consul-template` 服务和 consul 服务以及 kv 存储配置来动态渲染。
以 `paas` 项目的配置为例，先查看 `/etc/consul-template/conf.d/paas.conf` 配置：

```bash
template {
  source = "/etc/consul-template/templates/paas.conf"
  destination = "/usr/local/openresty/nginx/conf/conf.d/paas.conf"
  command = "/bin/sh -c '/usr/local/openresty/nginx/sbin/nginx -t && echo reload openresty && systemctl reload openresty'"
  command_timeout = "10s"
}
```

该配置表明：源配置模板位于 `/etc/consul-template/templates/paas.conf` ，生成的目标文件位于 `/usr/local/openresty/nginx/conf/conf.d/paas.conf`，生成后，执行重载 openresty 的命令

consul-template 的模板使用 golang 的 模板语言，具体可参考官方文档：https://github.com/hashicorp/consul-template/blob/master/docs/templating-language.md 

## 蓝鲸 Nginx 转发规则简介

### 最外接入层 Nginx

在模块分布配置 install.config 中配置的 nginx 服务器上运行的 openresty 服务是对应蓝鲸 web 最外层接入层模块。用户在浏览器中输入蓝鲸平台域名，经由 DNS 解析或者 /etc/hosts 配置，访问该 Nginx。根据访问的域名不同，请求根据配置转发到不同后端。由以下四个配置组成：

- paas.conf, app_upstream.conf (PaaS 平台接入层配置)
- cmdb.conf (配置平台 Web 接入层配置)
- job.conf （作业平台 Web 和 api 接入层）
- nodeman.conf (节点管理 api 接入层和静态资源上传下载服务)

#### PaaS 平台

PaaS 平台包含五个后端服务，分别通过五个 consul service 来动态渲染。括号内是哪些 url 开头的规则会转发给这些服务：

- paas-appengine (/v1)
- paas-esb (/api/)
- paas-login (/login/)
- paas-apigw (/api/apigw/、/apigw/)
- paas-paas (/console/、/)
- web-console (/o/bk_bcs_app/web_console/) (可选，安装 BCS 后才有用) 

这些 consul service 是在 安装 PaaS 模块的时候，通过 consul 接口注册服务地址和服务端口的。

另外值得单独提出的是，访问 `/o/` 和 `/t/` 开头的 url 的时候，会将请求转发到 `app_upstream.conf` 文件中定义的 appo 和 appt 所在服务器的 Nginx 端口。
`app_upstream.conf` 文件的动态渲染也是经由 `consul-template` 服务读取 consul kv 中以 `bkapps/` 开头的键值对来完成的。

bkapps/ 开头的 kv 数据，是通过 paas-appengine 模块在 SaaS 部署的时候，选择的部署服务器 IP：PORT 后，将 app_code 和 部署服务器信息关联，区分部署环境后，写入到 bkapps/下。可以通过命令 `consul kv get -recurse bkapps/` 来查看相关数据结构，结合 `/etc/consul-template/templates/app_upstream.conf.tpl` 文件来理解。

#### 配置平台

配置平台仅通过 nginx 暴露 cmdb-web 的服务端口。cmdb-api 的服务，由 esb 模块，直接通过配置文件配置 `cmdb-web.service.consul` 的内部域名来访问，不经过 nginx 代理。

#### 作业平台

新版作业平台的架构，前后端代码分离。前端静态资源由一个域名提供访问（$BK_JOB_PUBLIC_URL）。前端静态资源需要配置一个后端 jobapi 的访问地址来调用后端 api 服务（$BK_JOB_API_PUBLIC_ADDR），所以 作业平台的 nginx 分为两个 server block，分别是：

- 静态资源配置
- job-gateway 后端 api 访问配置

#### 节点管理

节点管理对于 Nginx 的需求可以分为四个方面：

1. 提供静态资源下载能力，安装 gse_agent 和监控插件需要通过 http 协议下载包
2. 提供静态资源上传能力，供蓝鲸其他平台调用，供用户上传文件存储（nginx+upload 模块）
3. 提供内部网络 api 接口，供 esb 调用
4. （可选）提供外网 api 接口，在跨云安装 Proxy/agent 时，提供 API 访问。

所以 节点管理的 nginx 配置是最为复杂的一个。

## 常见问题

### 修改了 consul kv 配置，但是 nginx 子配置没生效

1. 确认该 nginx 机器上的 openresty 处于运行状态：

    ```bash
    systemctl status consul-template
    ```

2. 确认 consul-template 的日志是否包含错误

    ```bash
    journalctl -u consul-template
    ```

3. 手动一次性运行，并开启 debug 输出。以 paas.conf 为例

    ```bash
    consul-template \
    -once -log-level debug -dry \
    -template '/etc/consul-template/templates/paas.conf:/tmp/paas.conf'
    ```
