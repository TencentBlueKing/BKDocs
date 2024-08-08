# 设置构建环境

## 关键字：runs-on

必填项，值格式为：String | Object 
配置当前 job 的构建环境。
支持如下公共构建资源池：

| |
|:--|
|**标识** |**说明** |**备注** |
|docker | linux 集群，使用 Docker 来运行<br>Docker 容器默认（和实际部署有关，如 8 核，10 内存，100G 硬盘） |缺省时使用此构建集群执行流水线 |
|agentless | 使用 docker 来运行。内存最大 2G。 | 无编译环境，用来运行和编译无关，对环境无特殊要求的任务，不能指定运行镜像 |

## 支持如下属性

以下是构建资源池相关属性的配置说明：

### 1. pool-name

- **类型**: String
- **说明**: 构建资源池的名称，可以是系统提供的公共构建资源池，或者是用户自定义的第三方构建资源池。

### 2. agent-selector

- **类型**: list
- **说明**: 目前仅支持选择 `windows`, `linux`, `macos` 作为构建代理。
- **配置示例**: `[ "macos" ]`

### 3. container

- **类型**: Object
- **生效条件**: 当 `pool-name=docker/私有构建机使用镜像` 时生效
- **说明**: 用于设置执行镜像的相关属性。

#### 3.1 image

- **类型**: String
- **缺省值**: `bkci/ci:latest`
- **说明**: 镜像地址，如果未指定，则使用默认值。自定义镜像需要满足基本要求，具体参见：[怎么制作自己的CI镜像](../../../Store/ci-images/docker-build.md)。

#### 3.2 credentials

- **类型**: String | Object
- **说明**: 拉取镜像所需的凭据，可以是指定凭据ID，或者是提供用户名和密码的组合。

#### 3.3 options

- **类型**: Object
- **生效条件**: 仅私有构建机生效
- **说明**: Docker run 的参数，目前支持以下三个属性。

| 属性       | 值格式   | 说明                                                         |
|------------|----------|--------------------------------------------------------------|
| volumes    | list     | docker run 的 `--volume`, `-v` 参数：用于绑定挂载卷 |
| gpus       | string   | docker run 的 `--gpus` 参数: 添加到容器的 GPU 设备（使用`all`表示全部GPU） |
| mounts     | string   | docker run 的 `--mounts` 参数 |


#### 3.4 image-pull-policy

- **类型**: String
- **生效条件**: 仅私有构建机生效
- **说明**: 镜像拉取策略。
  - 值为 `always` 时，每次运行都从仓库拉取对应版本的镜像。
  - 值为 `if-not-present` 时，只有当镜像在本地不存在时才会拉取。
- **缺省策略**:
  - 标签是 `latest`，自动设置为 `always`。
  - 没有指定标签，自动设置为 `always`。
  - 非 `latest` 的标签，自动设置为 `if-not-present`。

### 4. self-hosted

- **类型**: Boolean
- **缺省值**: `false`
- **说明**: 当使用第三方构建资源池时，设置为 `true`。

### 5. workspace

- **类型**: String
- **生效条件**: 当 `self-hosted=true` 时生效
- **说明**: 用于指定工作空间。系统指定的工作空间会带上流水线ID等信息，比较长，在 Windows 下，有可能会报路径超长。

### 6. queue-timeout-minutes

- **类型**: Int
- **生效条件**: 当 `self-hosted=true` 时生效
- **缺省值**: `10` 分钟
- **说明**: 查找可用构建资源的排队超时时间。

### 7. lock-resource-with

- **类型**: String
- **生效条件**: 当 `self-hosted=true` 时生效
- **说明**: 指定需要和前置哪个 Job 使用同一台构建机。指定后，构建机将在所有相同配置的 Job 运行完成后才会释放。
- **值**: 前置 Job 的 id。

### 8. needs

- **类型**: Object
- **生效条件**: 当使用 Linux 公共构建机时有效（如 `pool-name=docker`）
- **说明**: 以 NFS 的方式挂载第三方依赖，需部署环境下支持。

### 9. agent-labels

- **类型**: Array
- **说明**: agent 标签，通过标签筛选符合条件的 agent。
- **备注**: 尚未实施。

### 10. xcode

- **类型**: String
- **生效条件**: 当使用 macOS 构建机时生效
- **说明**: 必填，用于指定 xcode 版本。


## 场景示例
### 使用公共 Linux 构建资源，缺省配置

```yml
jobs:
  # 缺省，默认配置
  job_linux_1:
    steps:
      - run: echo hi, job_linux_1
```

### 使用公共 Linux 构建资源，显式指定资源池

```yml
jobs:
  job_linux_1:
    runs-on: docker
    steps:
      - run: echo hi, job_linux_1
```

### 使用公共 Linux 构建资源，指定镜像

```yml
jobs:
  # 公共资源池，指定镜像
  job_linux_3:
    runs-on:
      pool-name: docker
      container:
        image: mirrors.tencent.com/ci/tlinux3_ci:2.6.0
    steps:
      - run: echo hi, job_linux_3
```

### 使用自定义构建资源池

通过 self-hosted 属性指定使用自定义构建资源池。
将直接在指定的资源池中的构建机上执行流水线。

```yml
runs-on:
  self-hosted: true
  pool-name: my_pool_name
  agent-selector: [ windows ]
```

### 使用自定义构建资源池，自定义工作空间

self-hosted=true 时，通过 workspace 属性指定工作空间

```yml
runs-on:
  self-hosted: true
  pool-name: my_pool_name
  agent-selector: [ windows ]
  workspace: E:\landun
```

### 使用自定构建资源池，指定构建排队超时时间

self-hosted=true 时，通过 queue-timeout-minutes 指定获取可用构建机的排队超时时间，默认为 10 分钟

```yml
runs-on:
  self-hosted: true
  pool-name: aaa
  agent-selector: [ windows ]
  queue-timeout-minutes: 10
```

### 使用自定义构建资源池，并使用 docker 执行流水线 --- `目前仅支持 Linux 构建机`

```yml
runs-on:
  self-hosted: true
  pool-name: aaa
  agent-selector: [ windows ]
  queue-timeout-minutes: 10
```


指定 docker run 的参数（目前仅支持部分参数）：

```yml
runs-on:
  self-hosted : true
  pool-name: my_pool_name
  container:
    image: xxx
    credentials: xxx
    options:
      volumes: 
        - /var/run/docker.sock:/var/run/docker.sock
      gpus: all
      mounts: type=bind,source=xxxx,target=xxxx

```

### 使用自定义构建资源，复用前置 Job 取到的构建机

```yml
runs-on:
  self-hosted: true
  lock-resource-with: job_1
  agent-selector: [ windows ]
```

### 跨项目引用第三方构建资源池

需在定义构建机池的项目下设置共享范围，处于共享范围内的项目可以通过如下方式引用构建机池

```yml
resources:
  pools:
    - from: my_proj_1@poolA
      name: poolA-local
    - from: my_proj_1@poolB
      name: poolB-local

jobs:
  job1:
    runs-on:
      self-hosted: true
      pool-name: poolA-local
      agent-selector: [ windows ]
    steps:
      - run: echo "job1 in poolA-local"
  job2:
    runs-on:
      self-hosted: true
      pool-name: poolB-local
    steps:
      - run: echo "job2 in poolB-local"

```
