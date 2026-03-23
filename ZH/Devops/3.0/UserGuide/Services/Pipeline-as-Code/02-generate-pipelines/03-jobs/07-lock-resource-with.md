# 设置节点复用

## 关键字

`lock-resource-with`

要复用某 Job 的节点，请将此值设为该 Job 的 ID。

---

## 适用场景

使第三方构建资源池、且多个 Job 希望调度到同一个节点的场景。

详见：[多个 Job 使用集群中的同一台机器进行构建](../../../Pipeline/pipeline-edit-guide/multiple-jobs-one-machine.md)

---

## 配置示例

```yaml
version: v3.0
name: 构建资源锁定
on:
manual: enabled
stages:
- name: stage-1
label:
- Build
jobs:
job_wNF:
name: 构建环境-Linux
runs-on:
self-hosted: true
pool-name: my-pool
agent-selector:
- linux
steps:
- name: RunScript
id: drjukI
run: "echo \"job.container.node_alias is ${{job.container.node_alias}}\""
shell: auto
- name: stage-2
label:
- Build
jobs:
job_sHJ:
name: 构建环境-Linux
runs-on:
self-hosted: true
lock-resource-with: job_wNF # 复用 job_wNF 所使用的节点
   agent-selector:
        - linux
      steps:
      - name: RunScript
        id: ndAquY
        run: "echo \"job.container.node_alias is ${{job.container.node_alias}}\""
        shell: auto
notices:
- if: FAILURE
  type:
  - email
  - wework-message
  receivers:
  - "${{ci.actor}}"
  content: "【${{ci.project_name}}】- 【${{ci.pipeline_name}}】#${{ci.build_num}}
  执行失败，耗时${{ci.pipeline_execute_time}}, 触发人: ${{ci.actor}}。"
concurrency:
  queue-timeout-minutes: 10
syntax-dialect: INHERIT
cancel-policy: RESTRICTED
```
