# 组件导入

兼容[Prometheus Exporter](https://prometheus.io/docs/instrumenting/exporters/)的导入能力，从 Github 获取源码编译二进制或直接获取 release，按照蓝鲸监控的组件导入规范，即可实现组件的一键导入、出图、监控及自动处理，同时你也可以将其分享至蓝鲸的[S-mart 市场](http://bk.tencent.com/s-mart/market)供行业伙伴使用，提升你的影响力。

![exporter_timing_graph](../../assets/exporter_timing_graph.png)

## 下载组件

从[S-mart 市场](http://bk.tencent.com/s-mart/market)下载组件采集器

接下来上传

![import_component-w356](../../assets/import_component.png)

## 填写配置项

填写蓝鲸采集器获取 prometheus exporter metrics 的访问地址的参数（下图中步骤 1、2、3） 和 exporter 启动的运行参数（下图中步骤 4、5）
![-w2020](../../assets/config_schema.jpg)
上述参数请在组件采集器对应的 [S-mart](http://bk.tencent.com/s-mart/market)说明中获取。

## 采集测试

![-w2020](../../assets/collection_test.jpg)

## 设置采集周期

![-w2020](../../assets/collection_policy_set.jpg)
注： 趋势数据保存周期正在开发中.

## 自动出图

![-w2020](../../assets/component_graph.jpg)

## 设定策略

在仪表盘中选中刚导入的组件名称，然后设定监控策略。
![-w705](../../assets/component_monitor_policy.jpg)
