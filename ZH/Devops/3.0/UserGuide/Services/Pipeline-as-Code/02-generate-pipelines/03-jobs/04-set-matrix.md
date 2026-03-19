# 使用 Matrix Job

## 关键字

`strategy`

job 运行的策略

值格式为：Object

包含如下属性：

| 属性 | 值格式 | 说明 | 备注 |
|------|--------|------|------|
| matrix | Object | 参数矩阵，**必填**。格式为 `Object<String, Array<String>>`，定义的每个选项都有键和值，键将作为 matrix 上下文中的属性。包含两个特殊属性：<br>• `include`（Array）：用于给 matrix 的指定组合增加额外的属性，或者新增 1 个或多个组合，每个元素为一个 `Object<String, String>`<br>• `exclude`（Array）：用于排除 matrix 中的一些组合，每个元素为一个 `Object<String, String>`<br>解析时，先进行 exclude，再进行 include<br>**数据组合不超过 256 组，超过则失败退出** | |
| fast-kill | Boolean | 当其中一个 job 失败时，是否立即结束所有 job。非必填，默认为 `true` | |
| max-parallel | Number | 允许的最大并发数，默认为 5，不超过 20。非必填 | |

更多说明见：[启用 Matrix Job(构建矩阵)](../../../Pipeline/pipeline-edit-guide/pipeline-matrix-job.md)

---

## 示例

```yaml
stages:
- name: stage_1
jobs:
prepare:
name: Job-1
steps:
- name: run
        id: set-matrix
        run: |
          # 根据变更文件判断哪些模块发生变更（需自行通过脚本判定，这里仅示例如何将结果传给 Matrix Job）
          echo "::set-output name=parameters::{\"service\": [\"manager\", \"webhook\"]}"
          echo "::set-output name=service:: [\"manager\", \"webhook\"]"
          echo "::set-output name=include:: [{\"service\":\"api\"}]"
          echo "::set-output name=exclude:: [{\"service\":\"webhook\"}]"
    build:
      name: "build ${{ matrix.service }} image"
      steps:
      - checkout: self
        name: checkout
      - name: run
        run: |
          echo matrix.service is ${{ matrix.service }}
      strategy:
        matrix: "${{ fromJSON(jobs.prepare.steps.set-matrix.outputs.parameters) }}"
        fast-kill: false
        max-parallel: 5
      depend-on:
   - prepare
    build_1:
      name: use fromJSON under matrix
      steps:
      - checkout: self
        name: checkout
      - name: run
        run: "echo matrix.service is ${{ matrix.service }}"
      strategy:
        matrix: |
          ---
          service: "${{ fromJSON(jobs.prepare.steps.set-matrix.outputs.service) }}"
        fast-kill: false
        max-parallel: 5
      depend-on:
      - prepare
    build_2:
      name: include/exclude
      steps:
      - checkout: self
        name: checkout
      - name: run
        run: "echo matrix.service is ${{ matrix.service }}"
      strategy:
        matrix: "${{ fromJSON(jobs.prepare.steps.set-matrix.outputs.parameters) }}"
        include: "${{ fromJSON(jobs.prepare.steps.set-matrix.outputs.include) }}"
        excl
ude: "${{ fromJSON(jobs.prepare.steps.set-matrix.outputs.exclude) }}"
        fast-kill: false
        max-parallel: 5
      depend-on:
      - prepare
```
   
