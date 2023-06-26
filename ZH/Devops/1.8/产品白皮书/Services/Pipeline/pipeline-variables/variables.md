# 流水线变量

在流水线中，用户可以使用全局变量以及自定义变量来完成构建任务或者控制流水线的流程，全局变量可以在流水线的构建的全周期内引用，一些常用的全局变量可以在流水线插件编辑页面右上角「引用变量」获取，变量的引用方法：`${变量名称}`，可在大部分的流水线插件输入框内使用该方法引用变量；在Batchscript中引用变量稍微特殊，具体查看「变量的基本使用」。

![常用全局变量](../../../assets/image-variables-global-vars-view.png)

完整的全局变量可以查看：

-  [预定义变量列表](../../../reference/pre-define-var/README.md)


还可以查阅一下更多变量用法：

- [变量的基本使用](./pipeline-variables-shell-batch.md)
 
- [使用变量控制流水线流程](./pipeline-variables-flow-control.md)

- [凭证变量](./pipeline-variables-ticket.md)

- [使用备注变量](./pipeline-variables-remark.md)



