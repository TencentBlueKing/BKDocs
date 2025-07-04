# 单产品更新
<!-- WARNING: DO NOT EDIT. this file was generated by script at 2025-07-06-00:30:49+0800. -->

单产品更新为蓝鲸快速发布软件更新的机制。主要有如下用途：
* 发行版补丁：蓝鲸发行版中各产品版本的新补丁，不会引入新功能，可安稳升级。
* 新功能体验：跨版本升级体验最新功能。维护期短，期满需要继续跨版本升级。

## 重要时间节点
* 2024-10-18 7.2.0 公开下载，部署文档陆续上线。
* 2024-10-23 7.2.0 正式公告发布。
* 2024-11-08 7.2.1 发布。
* 2024-12-05 7.2.2 发布。
* 2025-07-04 7.2.3 发布。
* 2025-07-04 7.2.4 发布。
* 2025-10-31 标准维护期结束，不提供普通问题修复补丁，仅提供安全补丁。
* 2026-10-31 扩展维护期结束，不再提供安全补丁。
* 2027-10-31 停止提供技术支持（包括企点客服系统、论坛官方解答等）。
* 2028-10-31 资源归档，不再提供公开访问（包括官方文档、安装包等）。

## 发行版补丁
随蓝鲸 7.2 发布的版本，视作长期支持版。提供为期 2 年的维护服务（1 年标准维护 + 1 年扩展维护）。

>**提示**
>
>* 点击包版本号查阅具体的升级文档。
>* Helm chart 的包版本号可能和软件版本号不同，其他类型制品的包版本号即软件版本号。
>* 已经发布的版本后续会收录到发行版中，会在标签列中显示蓝鲸版本号。
>* 标签列显示“安全更新”，说明此补丁修复安全问题，需要尽快安排更新。
>* 标签列显示“重要补丁”，说明此补丁修复了一些重要问题，强烈建议更新。

| 产品 | 包名 | 包版本号 | 软件版本号 | 发布日期 | 标签 |
|--|--|--|--|--|--|
| API 网关 | bk-apigateway | [1.13.21](updates/202411.md#bk-apigateway-1.13.21) | 1.13.21 | 20241108 | `重要补丁` `7.2.1` `7.2.2` `7.2.3` `7.2.4` |
| PaaS 3.0 | bkapp-log-collection | [1.1.16](updates/202505.md#bkapp-log-collection-1.1.16) | 1.1.16 | 20250529 | `重要补丁` `7.2.3` `7.2.4` |
| 代码分析 | bk-codecc | [3.1.2-beta.1](updates/202412.md#bk-codecc-3.1.2-beta.1) | 3.1.2-beta.1 | 20241205 | `重要补丁` `7.2.2` `7.2.3` `7.2.4` |
| 作业平台 | bk-job | [0.6.6-beta.6](updates/202410.md#bk-job-0.6.6-beta.6) | 3.9.6-beta.6 | 20241018 | `重要补丁` |
|  |  | [0.6.6-beta.7](updates/202411.md#bk-job-0.6.6-beta.7) | 3.9.6-beta.7 | 20241108 | `7.2.1` |
|  |  | [0.6.6-beta.8](updates/202412.md#bk-job-0.6.6-beta.8) | 3.9.6-beta.8 | 20241205 | `7.2.2` `7.2.3` `7.2.4` |
| 容器管理平台 | bcs-services-stack | [1.29.4](updates/202411.md#bcs-services-stack-1.29.4) | 1.29.4 | 20241108 | `重要补丁` `7.2.1` `7.2.2` `7.2.3` `7.2.4` |
| 持续集成平台 | bk-ci | [3.0.11-beta.5](updates/202411.md#bk-ci-3.0.11-beta.5) | 3.0.11-beta.5 | 20241108 | `7.2.1` |
|  |  | [3.0.11-beta.7](updates/202412.md#bk-ci-3.0.11-beta.7) | 3.0.11-beta.7 | 20241205 | `重要补丁` `7.2.2` |
|  |  | [3.0.13](updates/202502.md#bk-ci-3.0.13) | 3.0.13 | 20250213 | `7.2.3` `7.2.4` |
| 日志平台 | bk-log-collector | [0.4.4](updates/202507.md#bk-log-collector-0.4.4) | 7.7.2-rc.107 | 20250704 | `7.2.3` `7.2.4` |
|  | bk-log-search | [4.7.4-beta.7](updates/202411.md#bk-log-search-4.7.4-beta.7) | 4.7.4-beta.7 | 20241108 | `7.2.1` `7.2.2` `7.2.3` |
|  |  | [4.7.4-beta.9](updates/202507.md#bk-log-search-4.7.4-beta.9) | 4.7.4-beta.9 | 20250704 | `安全更新` `7.2.4` |
|  |  | [4.7.4-beta.10](updates/202507.md#bk-log-search-4.7.4-beta.10) | 4.7.4-beta.9 | 20250706 | `安全更新` |
|  | bkunifylogbeat | [7.7.2-rc.107](updates/202507.md#bkunifylogbeat-7.7.2-rc.107) | -- | 20250704 | `7.2.3` `7.2.4` |
| 标准运维 | bk_sops | [3.33.12](updates/202507.md#bk_sops-3.33.12) | -- | 20250704 | `安全更新` `7.2.3` `7.2.4` |
| 流程引擎服务 | bk_flow_engine | [1.9.0](updates/202412.md#bk_flow_engine-1.9.0) | -- | 20241212 | `7.2.3` |
|  |  | [1.9.4](updates/202507.md#bk_flow_engine-1.9.4) | -- | 20250705 | `安全更新` `7.2.4` |
| 流程服务 | bk_itsm | [2.7.3](updates/202412.md#bk_itsm-2.7.3) | -- | 20241217 |  |
|  |  | [2.7.6](updates/202507.md#bk_itsm-2.7.6) | -- | 20250704 | `安全更新` `7.2.3` |
|  |  | [2.7.7](updates/202507.md#bk_itsm-2.7.7) | -- | 20250705 | `安全更新` `7.2.4` |
| 消息通知中心 | bk_notice | [1.5.11](updates/202411.md#bk_notice-1.5.11) | -- | 20241108 | `7.2.1` `7.2.2` `7.2.3` `7.2.4` |
| 监控平台 | bk-collector | [0.76.2732](updates/202501.md#bk-collector-0.76.2732) | -- | 20250116 |  |
|  |  | [0.77.2871](updates/202503.md#bk-collector-0.77.2871) | -- | 20250306 | `7.2.3` `7.2.4` |
|  | bk-monitor | [3.9.0-beta.15](updates/202411.md#bk-monitor-3.9.0-beta.15) | 3.9.0-beta.9 | 20241108 | `7.2.1` `7.2.2` |
|  |  | [3.9.0-beta.17](updates/202504.md#bk-monitor-3.9.0-beta.17) | 3.9.0-beta.9 | 20250403 |  |
|  |  | [3.9.0-beta.19](updates/202507.md#bk-monitor-3.9.0-beta.19) | 3.9.0-beta.10 | 20250703 | `安全更新` `7.2.3` `7.2.4` |
|  | bkmonitor-operator-stack | [3.6.148](updates/202412.md#bkmonitor-operator-stack-3.6.148) | 3.6.0 | 20241212 |  |
|  |  | [3.6.151](updates/202501.md#bkmonitor-operator-stack-3.6.151) | 3.6.0 | 20250116 |  |
|  |  | [3.6.152](updates/202503.md#bkmonitor-operator-stack-3.6.152) | 3.6.0 | 20250306 |  |
|  |  | [3.6.155](updates/202504.md#bkmonitor-operator-stack-3.6.155) | 3.6.0 | 20250410 |  |
|  |  | [3.6.158](updates/202507.md#bkmonitor-operator-stack-3.6.158) | 3.62.3267 | 20250704 | `7.2.3` `7.2.4` |
|  | bkmonitorbeat | [3.53.2568](updates/202412.md#bkmonitorbeat-3.53.2568) | -- | 20241212 |  |
|  |  | [3.57.2872](updates/202503.md#bkmonitorbeat-3.57.2872) | -- | 20250306 |  |
|  |  | [3.62.3267](updates/202507.md#bkmonitorbeat-3.62.3267) | -- | 20250704 | `7.2.3` `7.2.4` |
| 管控平台 | bk-gse-ce | [2.1.6-beta.31](updates/202412.md#bk-gse-ce-2.1.6-beta.31) | 2.1.6-beta.31 | 20241205 | `7.2.2` `7.2.3` `7.2.4` |
|  | gse_agent | [2.1.6-beta.31](updates/202412.md#gse_agent-2.1.6-beta.31) | -- | 20241205 | `7.2.2` `7.2.3` `7.2.4` |
|  | gse_proxy | [2.1.6-beta.31](updates/202412.md#gse_proxy-2.1.6-beta.31) | -- | 20241205 | `7.2.2` `7.2.3` `7.2.4` |
| 节点管理 | bk-nodeman | [2.4.7](updates/202411.md#bk-nodeman-2.4.7) | 2.4.7 | 20241108 | `7.2.1` `7.2.2` |
|  |  | [2.4.8](updates/202506.md#bk-nodeman-2.4.8) | 2.4.8 | 20250605 |  |
|  |  | [2.4.11](updates/202507.md#bk-nodeman-2.4.11) | 2.4.11 | 20250704 | `安全更新` `7.2.4` |
| 运维开发平台 | bk_lesscode | [1.1.0-beta.18](updates/202410.md#bk_lesscode-1.1.0-beta.18) | -- | 20241024 | `重要补丁` `7.2.1` |
|  |  | [1.1.0-beta.24](updates/202411.md#bk_lesscode-1.1.0-beta.24) | -- | 20241128 | `7.2.2` |
|  |  | [1.1.0-beta.32](updates/202505.md#bk_lesscode-1.1.0-beta.32) | -- | 20250508 | `安全更新` |

## 新功能体验
应用户需求，我们会推出一些尝鲜新功能。这些新版本不属于长期维护版本，维护期一般为 3~4 个月，此后遇到的问题都需要持续升级到最新版本解决。

>**提示**
>
>* 以“功能”维度分表格展示初始版本及其可用更新。新版本如果适用于多个功能，则会多次出现。
>* 体验新功能时，如果一个包有多个版本，建议先参考初始版本的文档部署，然后升级到新版本。



## 发布记录
按发布时间编制的表格，方便回顾。

| 发布日期 | 产品 | 包名 | 包版本号 | 软件版本号 | 标签 |
|--|--|--|--|--|--|
| 20241018 | 作业平台 | bk-job | [0.6.6-beta.6](updates/202410.md#bk-job-0.6.6-beta.6) | 3.9.6-beta.6 | `重要补丁` |
| 20241024 | 运维开发平台 | bk_lesscode | [1.1.0-beta.18](updates/202410.md#bk_lesscode-1.1.0-beta.18) | -- | `重要补丁` `7.2.1` |
| 20241108 | API 网关 | bk-apigateway | [1.13.21](updates/202411.md#bk-apigateway-1.13.21) | 1.13.21 | `重要补丁` `7.2.1` `7.2.2` `7.2.3` `7.2.4` |
|  | 作业平台 | bk-job | [0.6.6-beta.7](updates/202411.md#bk-job-0.6.6-beta.7) | 3.9.6-beta.7 | `7.2.1` |
|  | 容器管理平台 | bcs-services-stack | [1.29.4](updates/202411.md#bcs-services-stack-1.29.4) | 1.29.4 | `重要补丁` `7.2.1` `7.2.2` `7.2.3` `7.2.4` |
|  | 持续集成平台 | bk-ci | [3.0.11-beta.5](updates/202411.md#bk-ci-3.0.11-beta.5) | 3.0.11-beta.5 | `7.2.1` |
|  | 日志平台 | bk-log-search | [4.7.4-beta.7](updates/202411.md#bk-log-search-4.7.4-beta.7) | 4.7.4-beta.7 | `7.2.1` `7.2.2` `7.2.3` |
|  | 消息通知中心 | bk_notice | [1.5.11](updates/202411.md#bk_notice-1.5.11) | -- | `7.2.1` `7.2.2` `7.2.3` `7.2.4` |
|  | 监控平台 | bk-monitor | [3.9.0-beta.15](updates/202411.md#bk-monitor-3.9.0-beta.15) | 3.9.0-beta.9 | `7.2.1` `7.2.2` |
|  | 节点管理 | bk-nodeman | [2.4.7](updates/202411.md#bk-nodeman-2.4.7) | 2.4.7 | `7.2.1` `7.2.2` |
| 20241128 | 运维开发平台 | bk_lesscode | [1.1.0-beta.24](updates/202411.md#bk_lesscode-1.1.0-beta.24) | -- | `7.2.2` |
| 20241205 | 代码分析 | bk-codecc | [3.1.2-beta.1](updates/202412.md#bk-codecc-3.1.2-beta.1) | 3.1.2-beta.1 | `重要补丁` `7.2.2` `7.2.3` `7.2.4` |
|  | 作业平台 | bk-job | [0.6.6-beta.8](updates/202412.md#bk-job-0.6.6-beta.8) | 3.9.6-beta.8 | `7.2.2` `7.2.3` `7.2.4` |
|  | 持续集成平台 | bk-ci | [3.0.11-beta.7](updates/202412.md#bk-ci-3.0.11-beta.7) | 3.0.11-beta.7 | `重要补丁` `7.2.2` |
|  | 管控平台 | bk-gse-ce | [2.1.6-beta.31](updates/202412.md#bk-gse-ce-2.1.6-beta.31) | 2.1.6-beta.31 | `7.2.2` `7.2.3` `7.2.4` |
|  |  | gse_agent | [2.1.6-beta.31](updates/202412.md#gse_agent-2.1.6-beta.31) | -- | `7.2.2` `7.2.3` `7.2.4` |
|  |  | gse_proxy | [2.1.6-beta.31](updates/202412.md#gse_proxy-2.1.6-beta.31) | -- | `7.2.2` `7.2.3` `7.2.4` |
| 20241212 | 流程引擎服务 | bk_flow_engine | [1.9.0](updates/202412.md#bk_flow_engine-1.9.0) | -- | `7.2.3` |
|  | 监控平台 | bkmonitor-operator-stack | [3.6.148](updates/202412.md#bkmonitor-operator-stack-3.6.148) | 3.6.0 |  |
|  |  | bkmonitorbeat | [3.53.2568](updates/202412.md#bkmonitorbeat-3.53.2568) | -- |  |
| 20241217 | 流程服务 | bk_itsm | [2.7.3](updates/202412.md#bk_itsm-2.7.3) | -- |  |
| 20250116 | 监控平台 | bk-collector | [0.76.2732](updates/202501.md#bk-collector-0.76.2732) | -- |  |
|  |  | bkmonitor-operator-stack | [3.6.151](updates/202501.md#bkmonitor-operator-stack-3.6.151) | 3.6.0 |  |
| 20250213 | 持续集成平台 | bk-ci | [3.0.13](updates/202502.md#bk-ci-3.0.13) | 3.0.13 | `7.2.3` `7.2.4` |
| 20250306 | 监控平台 | bk-collector | [0.77.2871](updates/202503.md#bk-collector-0.77.2871) | -- | `7.2.3` `7.2.4` |
|  |  | bkmonitor-operator-stack | [3.6.152](updates/202503.md#bkmonitor-operator-stack-3.6.152) | 3.6.0 |  |
|  |  | bkmonitorbeat | [3.57.2872](updates/202503.md#bkmonitorbeat-3.57.2872) | -- |  |
| 20250403 | 监控平台 | bk-monitor | [3.9.0-beta.17](updates/202504.md#bk-monitor-3.9.0-beta.17) | 3.9.0-beta.9 |  |
| 20250410 | 监控平台 | bkmonitor-operator-stack | [3.6.155](updates/202504.md#bkmonitor-operator-stack-3.6.155) | 3.6.0 |  |
| 20250508 | 运维开发平台 | bk_lesscode | [1.1.0-beta.32](updates/202505.md#bk_lesscode-1.1.0-beta.32) | -- | `安全更新` |
| 20250529 | PaaS 3.0 | bkapp-log-collection | [1.1.16](updates/202505.md#bkapp-log-collection-1.1.16) | 1.1.16 | `重要补丁` `7.2.3` `7.2.4` |
| 20250605 | 节点管理 | bk-nodeman | [2.4.8](updates/202506.md#bk-nodeman-2.4.8) | 2.4.8 |  |
| 20250703 | 监控平台 | bk-monitor | [3.9.0-beta.19](updates/202507.md#bk-monitor-3.9.0-beta.19) | 3.9.0-beta.10 | `安全更新` `7.2.3` `7.2.4` |
| 20250704 | 日志平台 | bk-log-collector | [0.4.4](updates/202507.md#bk-log-collector-0.4.4) | 7.7.2-rc.107 | `7.2.3` `7.2.4` |
|  |  | bk-log-search | [4.7.4-beta.9](updates/202507.md#bk-log-search-4.7.4-beta.9) | 4.7.4-beta.9 | `安全更新` `7.2.4` |
|  |  | bkunifylogbeat | [7.7.2-rc.107](updates/202507.md#bkunifylogbeat-7.7.2-rc.107) | -- | `7.2.3` `7.2.4` |
|  | 标准运维 | bk_sops | [3.33.12](updates/202507.md#bk_sops-3.33.12) | -- | `安全更新` `7.2.3` `7.2.4` |
|  | 流程服务 | bk_itsm | [2.7.6](updates/202507.md#bk_itsm-2.7.6) | -- | `安全更新` `7.2.3` |
|  | 监控平台 | bkmonitor-operator-stack | [3.6.158](updates/202507.md#bkmonitor-operator-stack-3.6.158) | 3.62.3267 | `7.2.3` `7.2.4` |
|  |  | bkmonitorbeat | [3.62.3267](updates/202507.md#bkmonitorbeat-3.62.3267) | -- | `7.2.3` `7.2.4` |
|  | 节点管理 | bk-nodeman | [2.4.11](updates/202507.md#bk-nodeman-2.4.11) | 2.4.11 | `安全更新` `7.2.4` |
| 20250705 | 流程引擎服务 | bk_flow_engine | [1.9.4](updates/202507.md#bk_flow_engine-1.9.4) | -- | `安全更新` `7.2.4` |
|  | 流程服务 | bk_itsm | [2.7.7](updates/202507.md#bk_itsm-2.7.7) | -- | `安全更新` `7.2.4` |
| 20250706 | 日志平台 | bk-log-search | [4.7.4-beta.10](updates/202507.md#bk-log-search-4.7.4-beta.10) | 4.7.4-beta.9 | `安全更新` |
