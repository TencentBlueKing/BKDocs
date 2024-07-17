# 添加作业 Job

# 关键字： jobs

由** stages.jobs **属性来定义一个或多个 Job
值格式为：Object<job_id, Job>， key 为 job id， value 为 job 相关配置
key 命名规范：
- template 为保留关键字，不能作为自定义 job id
- 同一条流水线下，job id 不能重复

示例：

 ```
version: v3.0

on:
  push:
    branches: [ "master" ]
    paths:
      - ".ci/base/jobs.yml"

stages:
  - name: stage1
    jobs:
      job_1:
        steps:
          - run: echo hi, job 1
      job_2:
        steps:
          - run: echo hi, job 2
```