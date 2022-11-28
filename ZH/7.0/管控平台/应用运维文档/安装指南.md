# 安装指南

## 容器化安装部署

参见蓝鲸官方容器版本Helm Chart内置文档说明，文档详细介绍了从K8S集群准备到服务部署再到版本更新等详细操作流程。

## 二进制安装部署

**敬请期待**

## 服务验证

在部署完成之后，通常需要针对新版本服务进行测试验证，保证部署之后的服务有效可用。GSE系统提供了模块测试验证工具，通过该工具可以完整指定模块的healthz检查、P1级用例测试验证。

### 执行Helm Test命令

在完成容器部署后可以执行helm test命令对部署的Release进行功能性验证：

```sh
> helm test {release-name}
```

该命令会基于GSE提供的基础二进制测试工具进行系统关键用例的测试。

### 直接使用二进制工具本地验证

**基础平台服务（GSE Cluster）验证方法：**

- 查看使用说明：

```sh
> ./gse_cluster_e2e --help
usage:
  gse_cluster_e2e [<test name|pattern|tags> ... ] options

where options are:
  -?, -h, --help                            display usage information
  -l, --list-tests                          list all/matching test cases
  -t, --list-tags                           list all/matching tags
  -s, --success                             include successful tests in
                                            output
  --cluster-host <127.0.0.1>                target cluster host to connect
  --svi-tcp-port <27707>                    service api tcp port (default:
                                            27707)
  --svi-http-port <28808>                   service api http port (default:
                                            28808)
  --agent-tcp-port <28668>                  agent api tcp  port (default:
                                            28668)
  --healthz-port <59405>                    healthz port (default: 59405)
  --cert-path <cert path>                   SSL cert file path, include all
                                            crt/key files
For more detailed usage please see the project docs
```

- 执行测试验证：

```sh
> ./gse_cluster_e2e --cluster-host={gse-cluster-host}

===============================================================================
All tests passed (121 assertions in 5 test cases)
```

**任务服务（GSE Task）验证方法：**

- 查看使用说明：

```sh
> ./gse_task_e2e --help
usage:
  gse_task_e2e [<test name|pattern|tags> ... ] options

where options are:
  -?, -h, --help                            display usage information
  -l, --list-tests                          list all/matching test cases
  -t, --list-tags                           list all/matching tags
  -s, --success                             include successful tests in

  --http-endpoint <127.0.0.1:28863>         the target task server endpoint
                                            (eg:127.0.0.1:28863,127.0.0.2:
                                            28863) to connect
  --healthz-port <59403>                    healthz port
  --source-agent                            source agent. it will be used
                                            when execute a file task.
  --source-agent-user <root>                source agent id user. it will be
                                            used when execute a file task.
  --source-agent-user-password              source agent id user password. it
                                            will be used when used when
                                            execut a file task.
  --target-agent                            target agent. it can be used in
                                            all type task.
  --target-agent-user <root>                target agent user. it can be used
                                            in all type task.
  --target-agent-user-password              target agent user password
  --target-agent-file                       target agent file name. it can be
                                            used in all type task, if this
                                            parameter is set, the --target-
                                            agent-id will be ignored.
  --task-file-name                          will be used by source file and
                                            target file name in the file task
  --task-file-md5                           will be used by source file and
                                            target file name in the file task
  --task-file-dir                           will be used by source file and
                                            target file in the file task
  --task-file-content                       push file test case will use this
                                            parameter
  --task-timeout-seconds <60>               the task timeout seconds
  --cert-path <cert path>                   SSL cert file path, include all
                                            crt/key files
For more detailed usage please see the project docs
```

- 执行文件传输(copyfile)测试验证：

```sh
./gse_task_e2e task_file -c copyfile --http-endpoint {task-server-address} --target-agent {target-file-agent-id} --task-file-md5 {file-md5} --task-file-name {file-name} --task-file-dir {file-directory} --source-agent {source-file-agent-id}

===============================================================================
All tests passed (41 assertions in 1 test case)
```

- 执行文件内容推送(pushfile)测试验证:

```sh
./gse_task_e2e task_file -c pushfile --http-endpoint {task-server-address} --target-agent {target-file-agent-id} --task-file-name {file-name} --task-file-dir {file-directory} --task-file-content "hello world"

===============================================================================
All tests passed (21 assertions in 1 test case)
```

- 执行状态查询测试验证:

```sh
./gse_task_e2e task_state -c scriptstate --http-endpoint {task-server-address} --target-agent {target-file-agent-id} --target-agent-user root

===============================================================================
All tests passed (20 assertions in 1 test case)
```

- 执行脚本执行测试验证:

```sh
./gse_task_e2e task_script -c runbash --http-endpoint {task-server-address} --target-agent {target-file-agent-id} --target-agent-user root

===============================================================================
All tests passed (25 assertions in 1 test case)
```
