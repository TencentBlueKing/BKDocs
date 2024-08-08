# stage 下支持的属性

## name

值格式为：String
stage 名称，缺省值为 stage-<stageNum>

## id

值格式为：String
当前 pipeline 下 stage 的唯一标识，用户可以自定义。当前 pipeline 下不能重复。
缺省时系统自动生成 16 位随机ID


## label

值格式为：String | Array<String>
可以给当前stage设置一个或多个标签
目前支持的标签为：
- Build
- Test
- Deploy
- Approve


## if

值格式为：String
满足条件时才执行当前 stage，不满足时跳过不执行
支持条件表达式，表达式中支持通过上下文方式引用变量，如
	${{[ci.xxx](http://ci.xxx/)}} 
	${{[variables.xxx](http://variables.xxx/)}}
	${{[settings.xxx](http://settings.xxx/)}}
	${{[envs.xxx](http://envs.xxx/)}}等
	
示例：
	
	
 ```
version: v3.0

on:
  push:
    branches: [ "master" ]
    paths:
      - ".ci/base/if.yml"
  
variables:
  a: hello1
  b: 2

stages:
- name: code check
  if: ${{ variables.a }} == 'hello' || ${{ variables.b }} == 1
  jobs:
    check:
      steps:
      - run: echo codecc
- name: say hi
  jobs:
    check:
      steps:
      - run: echo hi

```
 
## if-modify -- `尚未实施`

值格式为：List<String>
当指定的文件变更时才运行当前 stage，不满足时跳过不执行
支持 glob 通配
注意：
- 按照list中的配置逐个匹配，匹配到则为 true
- 仅在push、mr、定时触发下有效
- finally 下暂不支持


示例：

 ```
- name: 第一个stage
  if-modify:
    - "*.md"
  jobs:
```

## check-in

值格式为：Object
stage 准入，在 stage 开始时判定
支持人工审核，详见 [stage 准入](./04-stage-check-in.md)

 

## jobs

定义一个或多个 job
值格式为：Object<job_id, Job>， key 为 job id， value 为 job 相关配置
key 命名规范：
- template 为保留关键字，不能作为自定义 job id

每个 job 定义详见 [在 YAML 中添加作业 Job](../03-jobs/01-add-job.md)
 
 
## fast-kill

是否有 job 失败时立即结束当前 stage
值格式为：Boolean，缺省值为 false