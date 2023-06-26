# 安装指南

## 部署前准备

需有kubernetes集群的管理权限，并在Master节点进行部署，Pod内能访问Kubernetes Apiserver的地址(因计算和AIOps依赖，keys.yaml配置文件中会定义其地址)

因AIOps需要兼容日志聚类等场景，平台的Api服务需要提供一个域名，需提前进行域名解析，保证容器内和外都能解析。

域名地址：bkbase-api.${BK_DOMAIN}

将该地址解析为ingress controller的地址或对应的clb地址，配置参考蓝鲸基座的文档（“配置DNS”，如没有使用域名服务，需要静态配置coredns，可以使用基座的/scripts/control_coredns.sh脚本）部分。


