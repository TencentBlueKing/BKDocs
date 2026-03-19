# 设置互斥组

## 关键字

`mutex`

定义互斥组，同一个组内的 Job 任务，同一时间只能运行一个。

值格式为：Object

包含如下属性：

| 属性 | 值格式 | 说明 | 备注 |
|------|--------|------|------|
| label | String | 互斥组的名称 | 项目下生效，即项目下同一个互斥组名称的 Job，将在同一个组内处理 |
| queue-length | Int | 互斥组内，如果需要排队，设置队列长度 | 默认值为 0，上限 10，即若资源已被占用，新来的任务都立即失败 |
| timeout-minutes | Int | 配合 queue-length 使用，排队超时时间 | 默认 10 分钟，上限为 480 分钟 |

> **生效范围**：项目下的流水线，即同一条流水线下的 Job，以及跨流水线的 Job，只要互斥组名称相同，即在同一个组内。

---

## 示例

### 流水线 1

```yaml
stages:
- name: stage_1
jobs:
job_1:
name: Job-1
mutex:
label: faye的互斥组
queue-length: 50
steps:
- name: run
run: |-
for i in {1..99}
do
# 演示bash如何转换1%～99%
rate=$(printf "%.2f" `echo "$i * 0.01" | bc`)
   echo "::set-progress-rate $rate"
              sleep 1
          done
        shell: auto
```

### 流水线 2

```yaml
jobs:
  job_1:
    runs-on: docker
    mutex:
      label: faye的互斥组
      queue-enable: true
      queue-length: 11
    steps:
      - run: echo "hello"
```
