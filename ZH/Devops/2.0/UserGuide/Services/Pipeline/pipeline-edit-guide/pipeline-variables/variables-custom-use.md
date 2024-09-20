
# 在流水线中引用变量

你可以在任意的插件表单中使用[自定义流水线变量](./variables-custom.md)定义的变量
- 引用系统变量：`${{ BK_CI_PIPELINE_ID }}`
- 引用全局变量：`${{variables.<var_name>}}`
- 引用 Task 的输出变量：`${{ jobs.<job-id>.steps.<step-id>.outputs.<output-var-name> }}`

![Var](../../../../assets/variables_3.png)

> 如图所示，在 Upload artifacts 插件的路径字段中引用全局变量 fooBarVarName

## 在手动触发流水线时设置变量值

1. 在编辑流水线时定义了流水线变量，并开启了“执行时显示”选项时，则会在运行流水线后进入**流水线预览页**；

![Var](../../../../assets/variables_4.png)

2. 进入预览页，你可以再次编辑你的变量 value 并运行流水线。

![Var](../../../../assets/variables_5.png)

> 变量 Key 在执行时不可修改，只能修改 value。