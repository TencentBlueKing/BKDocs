# 设置 Job 依赖

## 关键字

`depend-on`

用于设置当前 stage 下的 job 的执行顺序。可以配置一个或多个 job id，当依赖的所有 job 执行完毕时，才执行当前 job。

值格式为：Array

> - 循环依赖时报错
> - 依赖的 job 不支持由变量指定

---

## 示例

```yaml
stages:
- name: stage-2
label:
- Build
jobs:
job_Xww:
name: 构建环境-Linux
steps:
- name: RunScript
run: echo "hello world"
shell: auto
job_LHA:
name: 构建环境-Linux
steps:
- name: RunScript
run: echo "hello world 2"
shell: auto
depend-on:
- job_Xww
```

相同 stage 下的两个 job `job_Xww` 和 `job_LHA` 原本并行。

通过 `depend-on` 设置后运行顺序改为串行，即先运行 `job_Xww`，完成后再运行 `job_LHA`。
