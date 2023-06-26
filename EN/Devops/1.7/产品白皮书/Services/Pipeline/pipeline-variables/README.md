# 流水线变量

在流水线中，用户可以使用全局变量以及自定义变量来完成构建任务或者控制流水线的流程，全局变量可以在流水线的构建的全周期内引用，一些常用的全局变量可以在流水线插件编辑页面右上角「引用变量」获取，变量的引用方法：`${变量名称}`，可在大部分的流水线插件输入框内使用该方法引用变量；在 Batchscript 中引用变量稍微特殊，具体查看「变量的基本使用」。

![常用全局变量](../../../.gitbook/assets/image-variables-global-vars-view.png)

完整的全局变量可以查看：

{% content-ref url="../../../reference/pre-define-var/" %}
[pre-define-var](../../../reference/pre-define-var/)
{% endcontent-ref %}

还可以查阅一下更多变量用法：

{% page-ref page="pipeline-variables-shell-batch.md" %}

{% page-ref page="pipeline-variables-flow-control.md" %}

{% page-ref page="pipeline-variables-ticket.md" %}

{% page-ref page="pipeline-variables-remark.md" %}
