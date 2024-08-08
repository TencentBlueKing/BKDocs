# 执行脚本 run

## run

可以直接配置需要执行的单行或多行命令。
执行引擎：
- 当在类 linux 系统下时，使用 bash
	- 若自定义镜像中未安装bash，可以在脚本头部通过 #!/bin/sh 的方式指定解释器 
- 当在 windows 系统下时，使用 cmd 或者 git 自带的命令行工具执行


`注意事项`：
- 在脚本中进行环境变量操作时，注意变量命名，不要和流水线全局变量同名。避免脚本执行前${xxx} （`BK-CI旧的变量引用方式，已不推荐使用`）被替换为全局变量。


### 如何设置输出参数

在 run 插件中，使用 echo ::set-output name=<my_var_1>::<my_var_value_1> 的方式设置输出变量，详见 [流水线命令字](../../../Pipeline/pipeline-edit-guide/pipeline-variables/pipeline-command.md)
 
`注意：run 插件中设置输出，不会在当前步骤生效，在当前步骤结束后的下游步骤（后续step或stage）中，才能生效。`

示例

```yml
version: v3.0

steps:
- run: |
    echo "hello stage1-job1-step1"
- name: say hello
  id: step_2
  run: |
    echo "hello world"
    echo ::set-output name=key::value
- run: |
    echo "var_1 is ${{ steps.step_2.outputs.key}}"
```

### 自定义执行引擎的入口  shell 属性

支持 python、bash、batch、powershell 四种脚本语法

```yml
version: v3.0
jobs:
  job1:
    runs-on:
      self-hosted: true
      pool-name: ALL-ENV
      agent-selector: [ windows ]
    steps:
      - run: echo "不指定shell时，按照batch脚本执行"
      - run: echo "指定shell=cmd时，也是按照batch脚本执行"
        shell: cmd
      - run: print('指定shell=python时，是按照python3脚本执行')
        shell: python
      - run: Write-Host "指定shell=pwsh时，是按照PowerShell脚本执行"
        shell: pwsh
  job2:
    runs-on:
      self-hosted: true
      pool-name: ALL-ENV
      agent-selector: [ linux, macos ]
    steps:
      - run: echo "不指定shell时，按照bash脚本执行"
      - run: echo "指定shell=bash时，也是按照bash脚本执行"
        shell: bash
      - run: print('指定shell=python时，是按照python3脚本执行')
        shell: python
      - run: Write-Host "指定shell=pwsh时，是按照PowerShell脚本执行"
        shell: pwsh

```

	