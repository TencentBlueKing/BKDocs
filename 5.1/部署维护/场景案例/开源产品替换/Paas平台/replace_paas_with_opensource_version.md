# 开源版 PaaS 平台替换社区版部署指南

- 本方案目前仅适用于社区版 `V5.0.4` 以后的版本

- 替换前请务必手动备份 DB 数据 `MySQL`

## Open_Paas 替换指南

- 备份原社区版 `open_paas` 目录,将开源的 PaaS 代码解压到中控机的 `/tmp` 目录下

  ```bash
  mv /data/src/open_paas /data/open_paas-bak  #备份原 PaaS 工程
  cp -a /tmp/bk-PaaS-master/paas-ce/paas /data/src/open_paas #拷贝开源代码到 src 目录
  cp -a /data/open_paas-bak/support-files  /data/src/open_paas/ #拷贝原配置模版文件
  rsync -a /data/open_paas-bak/esb/components/*  /data/src/open_paas/esb/components/
  cp -a /data/open_paas-bak/esb/lib/gse /data/src/open_paas/esb/lib/
  ```

- 安装开源 PaaS 平台

  - 替换已经部署好的社区版 PaaS 平台

  ```bash
  ./bkcec sync paas
  ./bkcec install paas
  ./bkcec initdata paas
  ./bkcec stop paas
  ./bkcec start paas
  ```

  - 全新安装: 替换完 `/data/src/open_paas` 目录后，参考社区版 [标准部署](../../../基础包安装/多机部署/quick_install.md) 文档即可：

  ```bash
  ./bk_install paas
  ```

## paas_agent 替换指南

- 将开源版编译后生成的二进制：paasagent/bin/paas_agent 拷贝替换社区版 /data/src/paas_agent/paas_agent/bin/paas_agent

  ```bash
  cp -f paasagent/bin/paas_agent /data/src/paas_agent/paas_agent/bin/  # 将生成的开源二进制文件拷贝到 src/paas_agent 目录下
  ```

- 安装开源 `paas_agent`

  ```bash
  # 安装 appo
  ./bkcec stop appo
  ./bkcec sync appo
  ./bkcec install appo
  ./bkcec initdata appo
  ./bkcec start appo
  ./bkcec activate appo

  # 安装 appt
  ./bkcec stop appt
  ./bkcec sync appt
  ./bkcec install appt
  ./bkcec initdata appt
  ./bkcec start appt  
  ./bkcec activate appt
  ```

## 蓝鲸官方 SaaS 应用组件的维护

1.以标准运维 `bk_sops` 为例进行说明

**（1）场景一：**

复制 SaaS 为新应用，访问 SaaS 应用组件时，请求转发到新的 SaaS 应用。假定新标准运维应用为 `bk-sops-ce`。

- 打开 `$INSTALL_PATH/paas/esb/components/confapis/sops/sops.yaml`，将每个组件配置中 `dest_path` 替换为新应用 `bk-sops-ce` 提供的 API 地址比如，将 `dest_path` 改为 `/o/bk-sops-ce/apigw/get_template_list/{bk_biz_id}/`

- 更新配置参考：API 网关服务常用指令/更新配置

- 重启服务参考：API 网关服务常用指令/重启 API 网关服务

**（2）场景二：**

复制 SaaS 为新应用，并为新应用提供新的组件。假定新标准运维应用为 `bk-sops-ce`。

- 将 `$INSTALL_PATH/paas/esb/components/bk/apisv2/sops` 复制为 `$INSTALL_PATH/paas/esb/components/bk/apisv2/bk_sops_ce`；

  并将 `bk_sops_ce/toolkit/configs.py 中的 SYSTEM_NAME` 改为 `BK_SOPS_CE`（新应用 ID 的大写形式）。

- 将 `$INSTALL_PATH/paas/esb/components/confapis/sops` 复制为 `$INSTALL_PATH/paas/esb/components/confapis/bk_sops_ce`；

  将 `bk_sops_ce/sops.yaml 文件名更新为 bk_sops_ce/bk_sops_ce.yaml`；

  将 `bk_sops_ce/bk_sops_ce.yaml` 每个组件配置中 path 替换为新组件的路径，如：`/v2/bk_sops_ce/get_template_list/`；

  将 `bk_sops_ce/bk_sops_ce.yaml` 每个组件配置中 `comp_codename` 替换为新组件的组件代号，比如： `generic.v2.bk_sops_ce.sops_component`；

  将 `bk_sops_ce/bk_sops_ce.yaml` 每个组件配置中 `dest_path` 替换为新应用 `bk_sops_ce` 提供的 API 地址，比如：`/o/bk-sops-ce/apigw/get_template_list/{bk_biz_id}/`。

- 在 API 网关管理端->系统管理中，添加一个新的系统，系统名称为：`BK_SOPS_CE`（同步骤 1  中的 `SYSTEM_NAME`）

- 更新配置参考：API 网关服务常用指令/更新配置

- 重启服务参考：API 网关服务常用指令/重启 API 网关服务

- 新组件访问路径
  `/api/c/compapi/ + {path}（bk_sops_ce/bk_sops_ce.yaml 中的配置项 path）`
