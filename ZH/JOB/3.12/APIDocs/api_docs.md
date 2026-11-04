## 作业平台 V3 API 简介

作业平台（Job）是一套运维基础操作管理系统，除了支持脚本执行、文件分发、定时任务等一系列基础运维场景以外，还支持通过流程调度能力将零碎的单个任务组装成一个自动化作业流程；而每个作业都可做为一个原子节点，提供给上层或周边系统/平台使用，实现调度自动化。作业平台通过API的方式向其他系统提供原子能力，所有API及相关文档全部通过蓝鲸API Gateway提供，可前往已部署环境中的API Gateway页面查看，网关名称默认为：bk-job。

也可在代码仓库中查看API文档原材料：https://github.com/TencentBlueKing/bk-job/tree/3.12.x/support-files/bk-api-gateway/v3/apidocs/zh