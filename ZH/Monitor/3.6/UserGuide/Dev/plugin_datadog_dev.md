# DataDog Integrations 开发指南

官方 Integrations： [https://github.com/DataDog/integrations-core.git](https://github.com/DataDog/integrations-core.git)

社区 Integrations： [https://github.com/DataDog/integrations-extras.git](https://github.com/DataDog/integrations-extras.git)

如果在以上两个渠道没有找到相应的 Integrations，或者不满足个人的需求，可以自己修改或者重新开发一个 DataDog Integrations。

监控平台支持符合 [DataDog Integrations 开发规范](https://docs.datadoghq.com/developers/integrations/new_check_howto/) 的插件，因此开发完成后，既可以在监控平台使用，也能回馈 DataDog 社区。

### 环境要求

Python 2.7 或以上的版本

### 第一步：安装开发者工具

2.x 版本将不再支持 Python 2，因此这里将版本固定为 1.4。

```bash
pip install "datadog-checks-dev[cli]"==1.4
```

### 第二步：生成项目脚手架

要将当前目录设置为工作目录，先拉取 integrations-extras 的代码。

```bash
git clone https://github.com/DataDog/integrations-extras.git
```

然后将默认路径设置为 integrations-extras 所在的文件夹。

```bash
ddev config set extras "/path/to/integrations-extras"
ddev config set repo extras
```

假如要开发一个采集 **操作系统 CPU** 指标的 Integrations，我们把它命名为 `system_cpu`

`ddev`命令提供了一个脚手架，用于快速创建一个完整的 Integrations 所需的所有文件及目录结构。创建命令如下：

```bash
ddev create system_cpu
```

执行命令并填写简单的信息后，将会在 `integrations-extras` 目录创建一个名称为 `system_cpu` 的文件夹，目录结构如下：

```bash
system_cpu
├── assets
│   └── service_checks.json
├── datadog_checks
│   └── system_cpu
│       └── data
│           └── conf.yaml.example
│       ├── __about__.py
│       ├── __init__.py
│       └── system_cpu.py
│   └── __init__.py
├── tests
│   ├── __init__.py
│   ├── conftest.py
│   └── test_system_cpu.py
├── CHANGELOG.md
├── MANIFEST.in
├── README.md
├── manifest.json
├── metadata.csv
├── requirements-dev.txt
├── requirements.in
├── setup.py
└── tox.ini
```

### 第三步：完善采集逻辑

采集逻辑需要定义在 `system_cpu/datadog_checks/system_cpu/system_cpu.py`，要求：

- 实现一个 `Check` 类
- 这个类必须继承自 `AgentCheck` 类
- 这个类必须实现一个方法，签名为 `check(self, instance)`
- 代码必须同时兼容 Python 2 和 Python 3

以下为脚手架生成的代码，我们需要完善 check 方法即可。

```python
from datadog_checks.base import AgentCheck


class SystemCpuCheck(AgentCheck):
    def check(self, instance):
        # 这里需要补充采集逻辑
        pass
```

#### 指标命名规范

[https://docs.datadoghq.com/developers/metrics/#naming-custom-metrics](https://docs.datadoghq.com/developers/metrics/#naming-custom-metrics)

#### 如何上报一个指标

[https://docs.datadoghq.com/developers/metrics/agent_metrics_submission/?tab=count](https://docs.datadoghq.com/developers/metrics/agent_metrics_submission/?tab=count)

以下是示例的采集逻辑

```python
# coding=utf-8

import psutil
from datadog_checks.base import AgentCheck


class SystemCpuCheck(AgentCheck):
    def check(self, instance):
        # 如果实例配置中包含其他tags，上报数据的时候也需要带进去
        instance_tags = instance.get('tags', [])

        cpu_times = psutil.cpu_times(percpu=True)

        # 数据收集
        # gauge 为类型
        # 'system.cpu.count' 为指标名
        # len(cpu_times) 为指标值
        # instance_tags 为维度列表
        self.gauge('system.cpu.count', len(cpu_times), tags=instance_tags)

        for i, cpu in enumerate(cpu_times):
            tags = instance_tags + ['core:{0}'.format(i)]
            for key, value in cpu._asdict().items():
                self.rate('system.cpu.{0}'.format(key), 100.0 * value, tags=tags)
```

由于使用到第三方库 `psutil`，因此需要在 `system_cpu/requirements.in` 添加以下依赖声明。

```bash
psutil==5.6.2
```

### 第四步：编写测试

为验证插件逻辑，需要编写单元测试。脚手架已生成测试脚本 `system_cpu/tests/test_system_cpu.py`，可以直接在上面开始编写单元测试。

以下为 `system_cpu` 的单元测试示例代码：

```python
# coding=utf-8

import mock
import psutil

from datadog_checks.system_cpu import SystemCpuCheck

# mock data
MOCK_PSUTIL_CPU_TIMES = [
    psutil._psosx.scputimes(user=7877.29, nice=0.0, system=7469.72, idle=38164.81),
    psutil._psosx.scputimes(user=3826.74, nice=0.0, system=2701.6, idle=46981.39),
    psutil._psosx.scputimes(user=7486.51, nice=0.0, system=5991.36, idle=40031.88),
    psutil._psosx.scputimes(user=3964.85, nice=0.0, system=2862.37, idle=46682.5),
]


def test_check(aggregator, instance):
    check = SystemCpuCheck('system_cpu', {}, {})

    # mock
    psutil_mock = mock.MagicMock(return_value=MOCK_PSUTIL_CPU_TIMES)
    with mock.patch('datadog_checks.system_cpu.system_cpu.psutil.cpu_times', psutil_mock):
        check.check(instance)

    # 断言数据上报数量及取值
    aggregator.assert_metric('system.cpu.count', value=4, count=1)

    for i in range(4):
        aggregator.assert_metric('system.cpu.user', count=1, tags=['core:{0}'.format(i)])
```

单元测试编写完成后，执行以下命令启动测试程序。

```bash
ddev test system_cpu
```

当控制台显示 `Passed!` 字样，说明单元测试通过。

> 参考资料：[https://docs.datadoghq.com/developers/integrations/new_check_howto/#writing-tests](https://docs.datadoghq.com/developers/integrations/new_check_howto/#writing-tests)

### 第五步：其他信息的完善

至此，一个能用的插件就诞生了。但是如果要进一步符合社区规范，需要继续完善以下文件。

- 采集逻辑用到的第三方库依赖： `requirements.in`

- 插件说明文档 [README.md](https://docs.datadoghq.com/developers/integrations/new_check_howto/#populate-the-readme)
- 插件配置文件样例 [conf.yaml.example](https://docs.datadoghq.com/developers/integrations/new_check_howto/#configuration-file)
- 插件元信息 [manifest.json](https://docs.datadoghq.com/developers/integrations/new_check_howto/#manifest-file)
- 声明采集指标 [metadata.csv](https://docs.datadoghq.com/developers/integrations/new_check_howto/#metrics-metadata-file)

> 参考资料：[https://docs.datadoghq.com/developers/integrations/new_check_howto/#configuration](https://docs.datadoghq.com/developers/integrations/new_check_howto/#configuration)

### 第六步：在监控平台中使用

参考文档：

* [制作DataDog插件](../ProductFeatures/integrations-metric-plugins/import_datadog_online.md)
* [制作DataDog插件](../ProductFeatures/integrations-metric-plugins/import_datadog_online.md)
* [如何线下制作 DataDog 插件](./import_datadog_offline.md)

