# 在 YAML 文件中添加流水线设置

## name

pipeline 名称，缺省则设置为 YAML 文件相对于代码仓库根目录的路径
值格式为：String
`值不支持通过上下文变量设置。`

## label

值格式为：String | Array<String>
可以给当前 pipeline 设置一个或多个标签
	
## concurrency

使用 concurrency 来设置同一个组内同一时间仅运行一个流水线任务
值格式为：Object
支持如下属性：


| |
|:--|
|**属性** |**值格式** |**说明** |**备注** |
|group |String |concurrency 组名<br>**项目下**生效，即项目下多条流水线如果组名一样，将放到同一个组内处理<br>支持使用 ci 上下文内的部分变量占位，如 ci.pipeline_id、ci.branch、ci.head_ref、ci.base_ref |同一个组内，当有新任务进入时，默认将`取消正在运行的任务`，并启动新任务 |
|cancel-in-progress |bool |新任务进入时，是否取消正在运行的任务。默认为 true | |
|queue-length |Int |当 cancel-in-progress = false 时生效，排队的任务数量最大值。<br>1～20 之间的整数 |当队列满，且有新任务到达时，先进队列的任务会被取消，新任务进入队列 |
|queue-timeout-minutes |Int |当 cancel-in-progress = false 时生效，排队的任务的超时时间。<br>1～1440 之间的整数 | |

示例：
 ```
concurrency:
  group: ${{ ci.branch }} 

```
	
## custom-build-num

自定义构建号格式
	
 ```
custom-build-num: ${{DATE:"yyyyMMdd"}}.${{BUILD_NO_OF_DAY}}
```