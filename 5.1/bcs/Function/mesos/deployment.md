# BCS Deployment 说明

## 1. bcs-deployment 简介
bcs-deployment 是基于 bcs-application 抽象出的顶层概念、主要满足应用的滚动升级，回滚，暂停，扩、缩容等需求。

`注: 不支持deployment关联已经存在的application`

## 2. 配置模板说明

```json
{
    "apiVersion": "v4",
    "kind": "deployment",
    "metadata": {
        "labels": {
            "label_deployment": "label_deployment"
        },
        "name": "deployment-test-001",
        "namespace": "defaultGroup"
    },
    "restartPolicy": {
        "policy": "Always",
        "interval": 5,
        "backoff": 10
    },
     "killPolicy":{
        "gracePeriod": 10
    },
    "constraint": {
        "IntersectionItem": [
            {
                "UnionData": [
                    {
                        "name": "hostname",
                        "operate": "CLUSTER",
                        "type": 4,
                        "set": {
                            "item": [
                                "mesos-slave-1",
                                "mesos-slave-2"
                            ]
                        }
                    }
                ]
            }
        ]
    },
    "spec": {
        "instance": 2,
        "selector": {
            "podname": "app-test-001"
        },
        "strategy": {
            "type": "RollingUpdate",
            "rollingupdate": {
                "maxUnavilable": 1,
                "maxSurge": 1,
                "upgradeDuration": 60,
                "rollingOrder": "CreateFirst",
                "rollingManually": false
            }
        },
        "template": {
            "metadata": {
                "labels": {
                    "label_deployment": "label_deployment"
                },
                "name": "deployment-test-001",
                "namespace": "defaultGroup"
            },
            "spec": {
                "containers": [
                    {
                        "command": "python",
                        "args": [
                            "-m",
                            "SimpleHTTPServer",
                            "8888"
                        ],
                        "parameters": [],
                        "type": "MESOS",
                        "env": [
                            {
                                "name": "DNS_HOSTS",
                                "value": "test_env"
                            }
                        ],
                        "image": "hub_address.com/bcs/<IMAGE_NAME>",
                        "imagePullUser": "xxx",
                        "imagePullPasswd": "xxx",
                        "imagePullPolicy": "Always",
                        "privileged": false,
                        "ports": [
                            {
                                "containerPort": 8899,
                                "name": "test-port",
                                "protocol": "HTTP"
                            }
                        ],
                        "healthChecks": [
                            {
                                "protocol": "tcp",
                                "path": "/http/path/only",
                                "delaySeconds": 10,
                                "gracePeriodSeconds": 12,
                                "intervalSeconds": 10,
                                "timeoutSeconds": 10,
                                "consecutiveFailures": 10
                            }
                        ],
                        "resources": {
                            "limits": {
                                "cpu": "0.5",
                                "memory": "8"
                            }
                        },
                        "volumes": [],
                        "secrets": [],
                        "configmaps": []
                    }
                ],
                "networkMode": "BRIDGE",
                "networktype": "cnm"
            }
        }
    }
}

```

- 基础信息简介
由于 bcs-deployment 是基于 bcs-application 构建，其中的大部分信息与 bcs-application 一致，包含以下内容：
    - restartPolicy
    - killPolicy
    - constraint
    - spec.template 中所有字段信息

关于这部分字段与结构的详细信息请见。

`下面介绍一下关于bcs-deployment本身特性的相关策略。`
```json
    "spec": {
       "instance": 2,
       "selector": {
           "podname": "app-test-001"
       },
       "strategy": {
           "type": "RollingUpdate",
           "rollingupdate": {
                "maxUnavilable": 1,
                "maxSurge": 1,
                "upgradeDuration": 60,
                "rollingOrder": "CreateFirst",
                 "rollingManually":false
            }
        }
    }
```

- 实例数
相关参数为 spec.instance(第 2 行)，用于配置要创建的 taskgroup 的数量。该 taskgroup 是由 deployment 创建的一个 application 来管理。

- application 选择器
相关参数为 spec.selector（第 3 行），用于配置 deployment 所需要管理的 bcs-appliction,默认这些 bcs-application 是由 bcs-deployment 自动创建的。

## 3. deployment 升级策略
相关配置项为 spec.strategy（第 6-15 行），用于配置 deployment 执行 rolling 操作时所需要的策略：
- type: 定义 deployment 进行 rolling 时要选择的策略，目前只支持 RollingUpdate：
  - `RollingUpdate`:  
    RollingUpdate 即为滚动升级，该策略允许我们对滚动操作的过程中每次新创建的容器数量，删除的容器数量，创建间隔等策略进行控制。当原有的 taskgroup 全部删除，新的 taskgroup（个数通过 instances 参数定义）全部创建，则 update 结束。

- RollingUpdate
可以对 Rolling 的操作进行详细的配置，包含以下参数：
  - `maxUnavilable`:  
  决定了每个 rolling 周期内可以`删除`的 taskgroup 数量。如果原有的 taskgroup 已经全部删除，则后续每一次 rolling 中不会再删除 taskgroup。
  - `maxSurge`:  
  决定了每个 rolling 周期内可以`创建`的 taskgroup 数量。如果新的 taskgroup 已经全部创建，则后续每一次 rolling 中不会再创建 taskgroup。
  - `upgradeDuration`:  
  配置每次 rolling 操作之间的`最小`间隔时间。
  - `rollingOrder`:
  配置在进行每次 rolling 操作期间的每个周期内，创建和删除应用的先后顺序。该配置支持两种模式`CreateFirst`, `DeleteFirst`。 **CreateFirst**策略会先创建新的应用，然后删除老的应用。而**DeleteFirst**策略会先删除老的应用，再创建新的应用。
  - `rollingManually`:
  配置每次滚动是否需要手动触发，默认为 false，即一次滚动完成之后在时间间隔结束之后自动进行下一次滚动，如果配置为 true，则在每次滚动后自动 pause，需输入 resume 命令才会在时间间隔结束之后进行下一次滚动

## 4. rolling update 的策略示例
我们假设 rolling 前 deployment 的 instances 为 oldInstances, rolling 的 deployment instances 为 newInstances。可以预见在 rolling 过程中会有以下三种场景：
- oldInstances < newInstances
对 application 进行一次 rolling update，并且达到扩容的效果
- oldInstances = newInstances  
对 application 进行一次 rolling update，容器数量保持不变
- oldInstances > newInstances  
对 application 进行一次 rolling update，并且达到缩容的效果

## 5. 支持的 deployment 操作
- create
创建一个 deployment：如果已有绑定的 application，则 delete 当前 application 并创建新的 application；如果不存在绑定的 application，则创建 application。也可以创建一个空的 deployment 绑定到当前已有的 application。
- udpate
对 deployment 进行 rolling update： 通过 instances 的变化，可以同时到达扩容和缩容的效果。
- rollback
停止当前的 update 操作，将新创建的 application 和 taskgroup 删除，将原有的 application 的 taskgroup 恢复到原有的 instances 个数
- pause
暂停 rolling update： rolling update 过程中可以通过该命令暂停 update。
- resume
继续 rolling update： 可以将暂停的 update 继续。
- delete
删除 deployment，以及相应的 application
