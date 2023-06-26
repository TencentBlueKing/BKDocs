## 容器监控

1. BCS Thanos Query
- 组件简介：thanos API 查询模块，提供统一的兼容 PromQL 的查询层，支持跨集群，不存储类型异构查询等
- 服务名称：bcs-thanos-query
- 部署路径：/data/bcs/monitoring/bcs-thanos
- BIN 文件：/data/bcs/monitoring/bcs-thanos/thanos
- 配置文件：/data/bcs/monitoring/bcs-thanos/bcs-thanos-query.yml
- 日志路径：/var/log/messages
2. BCS Thanos Relay
- 组件简介：thanos 跨云代理模块, 可通过 websocket 隧道，打通不同网络的 prometheus 服务注册和代理请求
- 服务名称：bcs-thanos-relay
- 部署路径：/data/bcs/monitoring/bcs-thanos
- BIN 文件：/data/bcs/monitoring/bcs-thanos/thanos
- 配置文件：service 参数
- 日志路径：/var/log/messages
3. BCS Thanos SD SVC
- 组件简介：thanos 服务注册中心，提供 thanos-sidecar, thanos-relay 注册自身的地址
- 服务名称：bcs-thanos-sd-svc
- 部署路径：/data/bcs/monitoring/bcs-thanos
- BIN 文件：/data/bcs/monitoring/bcs-thanos/thanos
- 配置文件：/data/bcs/monitoring/bcs-thanos/bcs-thanos-sd-svc.yml
- 日志路径：/var/log/messages
4. BCS Thanos SD Target
- 组件简介：thanos 服务发现模块，通过请求 sd-svc，把 sidecar, relay 地址提供给 query 查询
- 服务名称：bcs-thanos-sd-target
- 部署路径：/data/bcs/monitoring/bcs-thanos
- BIN 文件：/data/bcs/monitoring/bcs-thanos/thanos
- 配置文件：service 参数
- 日志路径：/var/log/messages
5. BCS Monitor Ruler
- 组件简介：BCS 告警策略执行模块，通过执行兼容的 prom alerting rule 规则，生成告警，推送到 alertmanager
- 服务名称：bcs-monitor-ruler
- 部署路径：/data/bcs/monitoring/bcs-monitor
- BIN 文件：/data/bcs/monitoring/bcs-monitor/thanos
- 配置文件：/data/bcs/monitoring/bcs-monitor/bcs-monitor-prod.yml
- 日志路径：/data/bcs/logs/bcs/monitoring/ruler.log
6. BCS Monitor Alertmanager
- 组件简介：BCS 告警汇总，通知模块，对 ruler 模块推送的告警，做汇总收敛，最后按规则通知用户
- 服务名称：bcs-monitor-alertmanager
- 部署路径：/data/bcs/monitoring/bcs-monitor
- BIN 文件：/data/bcs/monitoring/bcs-monitor/thanos
- 配置文件：/data/bcs/monitoring/bcs-monitor/bcs-monitor-prod.yml
- 日志路径：/data/bcs/logs/bcs/monitoring/alertmanager.log
7. BCS Monitor API
- 组件简介：BCS Monitor API 模块，对 SaaS 提供告警策略预览，常用告警策略列表接口等
- 服务名称：bcs-monitor-api
- 部署路径：/data/bcs/monitoring/bcs-monitor
- BIN 文件：/data/bcs/monitoring/bcs-monitor/thanos
- 配置文件：/data/bcs/monitoring/bcs-monitor/bcs-monitor-prod.yml
- 日志路径：/data/bcs/logs/bcs/monitoring/api.log
8. BCS Grafana
- 组件简介：BCS Monitor Dashboard，开源的 grafana，内置 paas-grafana-datasource，piechart 等插件
- 服务名称：bcs-grafana
- 部署路径：/data/bcs/monitoring/bcs-grafana
- BIN 文件：/data/bcs/monitoring/bcs-grafana/bin/grafana-server
- 配置文件：/data/bcs/monitoring/bcs-grafana/conf/bcs-grafana.ini
- 日志路径：/var/log/messages