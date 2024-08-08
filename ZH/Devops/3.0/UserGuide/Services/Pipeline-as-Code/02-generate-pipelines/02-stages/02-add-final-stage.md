# 添加收尾阶段 finally

## 关键字：finally

值格式为：Object<Job>
当流水线执行结束时进行的一组操作，由一个或多个 job 组成，支持 job、step模板。
在此 stage 下，job 执行支持如下条件：`（不支持其他的自定义条件）`
- 缺省等同于 ALWAYS，当前 stage 开始时
- FAILURE 上游 stage 失败时
- SUCCESS 上游 stage 成功时
- CANCELED 上游 stage 取消时


```
version: v3.0

on:
  push: [ master]

variables:
  a: 11111

steps:
- run: |
    echo "hello, world!"

finally:
  f_job_1:
    name: f-job-1
    if: FAILURE
    steps:
    - run: |
        echo "[f-job-1]variables.a is ${{ variables.a }}"
  f_job_2:
    name: f-job-2
    steps:
    - run: |
        echo "[f-job-2]variables.a is ${{ variables.a }}"
```