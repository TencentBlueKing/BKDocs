## 容器管理平台组件

1. BCS API
- 组件简介：bcs-api 是容器管理平台对外提供服务的 API 接入层，负责将用户请求转发至对应的 kubernetes 集群中，兼容 kube-apiserver 的接口，同时打通了 kubernetes 的 rbac 体系
- 服务名称：bcs-api
- 部署路径：/data/bkce/bcs/bcs-api
- BIN 文件：/data/bkce/bcs/bcs-api/bcs-api
- 配置文件：/data/bkce/etc/bcs/bcs-api.json
- 日志路径：/data/bkce/logs/bcs/bcs-api.[INFO|WARNING|ERROR]
2. BCS DNS Service
- 组件简介：bcs-dns-service 是容器管理平台系统中为集群提供域名解析服务的组件，同时支持集群内部和跨集群的 service 域名解析，并提供自定义域接口
- 服务名称：bcs-dns-service
- 部署路径：/data/bkce/bcs/bcs-dns-service
- BIN 文件：/data/bkce/bcs/bcs-dns-service/bcs-dns-service
- 配置文件：/data/bkce/etc/bcs/bcs-dns-service.json
- 日志路径：/data/bkce/logs/bcs/bcs-dns-service.[INFO|WARNING|ERROR]
3. BCS Storage
- 组件简介：bcs-storage 是容器管理平台系统的动态数据管理组件，负责存储和汇聚容器管理平台系统中所有 kubernetes 集群上报的资源动态数据，对外提供统一的数据查询和事件订阅接口
- 服务名称：bcs-storage
- 部署路径：/data/bkce/bcs/bcs-storage
- BIN 文件：/data/bkce/bcs/bcs-storage/bcs-storage
- 配置文件：/data/bkce/etc/bcs/bcs-storage.json
- 日志路径：/data/bkce/logs/bcs/bcs-storage.[INFO|WARNING|ERROR]
4. BCS OPS
- 组件简介：bcs-ops 为容器管理平台的创建集群、添加节点、删除节点、删除集群、导入集群等功能提供接口
- 服务名称：bcs-ops
- BIN 文件：/data/bkce/bcs/bcs-ops/bcs-ops
- 配置文件：/data/bkce/etc/bcs/bcs-ops.json
- 部署路径：/data/bkce/bcs/bcs-ops
- 日志路径：/data/bkce/logs/bcs/bcs-ops.[INFO|WARNING|ERROR]
5. BCS CC
- 组件简介：容器管理平台配置中心是容器集群及节点等的配置中心，具备保存项目信息及绑定的蓝鲸 CMDB 业务信息、集群版本信息及集群快照信息、生成集群 ID，保存 master 及 node IP 信息及状态等功能
- 服务名称：bcs-cc
- 部署路径：/data/bkce/bcs/cc
- BIN 文件：/data/bkce/bcs/cc/bin/bcs_cc
- 配置文件：/data/bkce/etc/bcs/cc.yml
- 日志路径：/var/log/messages
6. WebConsole
- 组件简介：提供 kubectl 命令行工具，可以快捷查看集群内资源
- 服务名称：bcs-web-console
- 部署路径：/data/bkce/bcs/web_console
- BIN 文件：/data/bkce/.envs/bcs-web_console/bin/python
- 配置文件：参数-m backend.web_console
- 日志路径：/var/log/messages
7. BCS 导航页
- 组件简介：项目信息管理服务，负责项目创建及基本信息管理
- 服务名称：devops
- 部署路径：/data/bkce/devops
- BIN 文件：/usr/local/openresty/nginx/sbin/nginx
- 配置文件： /usr/local/openresty/nginx/conf/nginx.conf
- 日志路径：/data/bkce/logs/nginx
8. Harbor API
- 组件简介：封装了部分 harbor 接口，提供给容器服务 SaaS 访问镜像资源
- 服务名称：harbor_api
- 部署路径：/data/bkce/harbor/api
- BIN 文件：/opt/java/bin/java
- 配置文件：/data/bkce/harbor/api/conf/application.yml
- 日志路径：/data/bkce/logs/harbor/harbor_api.log
