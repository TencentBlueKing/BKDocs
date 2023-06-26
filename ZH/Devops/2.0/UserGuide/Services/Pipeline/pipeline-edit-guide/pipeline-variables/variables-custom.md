# 自定义流水线变量

可以在编排流水线过程中，将通用的设置、运行过程中动态变更的参数提取为流水线变量。

## 在编排中自定义流水线全局变量

在编辑流水线页面点击 Job1-1，可以添加流水线变量。
![Var](../../../../assets/variables_1.png)


## (推荐)在 Bash/RunScript 插件中使用`set-variable`方式设置全局变量

您可以通过 Shell Script 插件中的 特定的语法`echo "::set-variable name=<var_name>::<value>"`设置插件间传递的参数，用法如下：

```bash
#!/usr/bin/env bash
# echo "::set-variable name=<var_name>::<value>"
# eg:
# echo "::set-variable name=fooBarVarName:fooBarVarValue"
```

![Var](../../../../assets/variables_6.png)

- set-variable 设置的也是**全局变量**，如果两个Bash并发设置同名变量，设置结果不可预期

通过此方法设置的变量，在下游通过表达式引用：${{ variables.fooBarVarName }}

- 在 stage/job/task的流程控制条件中引用时，也是通过 variables.xxx 的方式来引用，如：

![Var](../../../../assets/variables_7.png)

## (推荐)在 Bash/RunScript 插件中使用`set-outputs`方式设置对应步骤的输出

您可以通过 Shell Script 插件中的 特定的语法`echo "::set-output name=<output_name>::<value>"`设置插件间传递的参数，用法如下：

```bash
#!/usr/bin/env bash
# echo "::set-output name=<output_name>::<value>"
# eg:
# echo "::set-output name=outputVarName:outputVarValue"
```

通过此方法设置的输出变量，不会被任何步骤的同名输出覆盖。

使用此方法时，需设置对应步骤的id：

![](../../../../assets/variables_8.png)

用于下游步骤引用此变量：

- 当在 job2 中访问前置的 job1 的 step_set_var 的输出 outputVarName 时：${{ jobs.job1.steps.step_set_var.outputs.outputVarName }}
- 当在 job2 中访问当前 job 下的 step_set_var 的输出 outputVarName 时，无需加 jobs 上下文，直接通过 steps 引用：${{ steps.step_set_var.outputs.outputVarName }}
- 在 stage/job/task的流程控制条件中引用时，变量名也需配置为 jobs.job1.steps.step_set_var.outputs.outputVarName 的格式

job id 在 job 配置上管理：（系统设置了一个默认值，可以修改为自己想要的id。需保证流水线下唯一）

![](../../../../assets/variables_9.png)
