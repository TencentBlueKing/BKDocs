# 集群弹性伸缩

节点自动扩缩容功能利用Cluster Autoscaler组件，动态调整集群节点数量。在以下情况下会触发自动扩缩容：
- 当集群中有Pod因资源不足无法调度。
- 当集群中的某些节点资源利用率过低，并且其上的Pod可以调度到其他节点。

## 节点自动扩缩容前置条件

- 集群需通过云服务商导入，详情参考[导入外部集群](./ImportCluster.md)。
- 云凭证必须具备以下权限：

  ```json
  {
    "version": "2.0",
    "statement": [
      {
        "effect": "allow",
        "action": [
          "tke:*"
        ],
        "resource": [
          "*"
        ]
      },
      {
        "effect": "allow",
        "action": [
          "cvm:DescribeSecurityGroups",
          "cvm:DescribeImages",
          "cvm:DescribeInstances"
        ],
        "resource": [
          "*"
        ]
      },
      {
        "effect": "allow",
        "action": [
          "vpc:Describe*"
        ],
        "resource": [
          "*"
        ]
      },
      {
        "effect": "allow",
        "action": [
          "as:*"
        ],
        "resource": [
          "*"
        ]
      }
    ]
  }
  ```

## 节点池与Autoscaler组件配置

### 新建节点池

在新建节点池时，确保节点池配置符合业务需求，以支持后续扩缩容功能。

### 开启Cluster Autoscaler组件

必须至少有一个状态为“正常”的节点池，才能开启Cluster Autoscaler组件。否则，无法启动扩缩容功能。

### 快速验证节点自动扩缩容功能

通常，节点自动扩缩容与K8S集群的水平Pod自动扩展（HPA）功能结合使用。具体可参考[Pod 水平自动扩缩](https://kubernetes.io/zh-cn/docs/tasks/run-application/horizontal-pod-autoscale/)。  
为了快速验证扩缩容功能，可手动触发扩容与缩容操作。

#### 资源计算方式

集群资源的使用率是基于workload实例的Request值来计算的，而非节点的真实资源使用率。详情请参考[Pod 和容器管理资源](https://kubernetes.io/zh-cn/docs/concepts/configuration/manage-resources-containers/)。

#### 触发扩容

- **触发扩容条件**：
  - 默认扩容阈值为100%，如果集群中有Pod因资源不足无法调度，且原生调度算法判断无法调度到现有节点，触发扩容。
  - 如果设置了非100%的阈值，当集群资源使用率达到或超过设定值时，触发扩容。

- **模拟触发扩容**：
  - 根据集群现有节点资源情况，创建一个workload实例来测试扩容。  
    例如：如果当前集群中有1个4核8G的节点，可以创建5个实例，每个实例的CPU Request为1核，来触发扩容。

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deployment-test
  namespace: default
  labels:
    app: nginx
spec:
  replicas: 5
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: 'nginx:latest'
          ports:
            - containerPort: 80
          resources:
            requests:
              cpu: "1"
```

#### 触发缩容

- **触发缩容条件**：
  - 节点处于空闲状态。
  - 节点装箱率低于设定阈值（如CPU、内存低于50%），且该节点上的Pod可以调度到其他节点。
  - 符合上述条件并持续一段时间后，节点将被缩容。
  - 扩容后20分钟内为缩容冷却期，期间不会执行缩容操作。

- **模拟触发缩容**：
  - 删除之前用于触发扩容的workload，等待20分钟，检查是否触发缩容。

### 编辑节点池

目前仅支持编辑“节点池信息”，由于腾讯云接口限制，暂不支持直接编辑“节点配置”。若需更换节点配置，建议新建节点池并关闭旧节点池（若节点池中有节点，只需关闭，不要删除）。

### 关闭与删除节点池

在Cluster Autoscaler组件开启的情况下，且只有1个节点时，为确保组件正常运行，无法关闭或删除节点池。必须先停用Cluster Autoscaler组件。

如果节点池中已有节点，也无法直接删除，需先删除节点。



