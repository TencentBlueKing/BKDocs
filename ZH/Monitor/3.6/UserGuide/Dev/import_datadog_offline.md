# 如何线下定义插件

线下定义  插件是不必经过 web 界面就可以在线下完成  的插件的制作，制作完成后通过导入功能上传到插件管理。

## 准备工作

1. 获取 BK-Plugin  Framework

   ```bash
   git clone https://xxx.com/datadog_plugin_framework.git
   ```

2. 获取   Integrations(6.15x 分支代码)

   官方

   ```bash
   git clone https://github.com/DataDog/integrations-core.git
   ```

   社区

   ```bash
   git clone https://github.com/DataDog/integrations-extras.git
   ```

   将上面的仓库 clone 下来，看是否有需要的组件，如果没有，需要根据 [官方规范](https://docs.datadoghq.com/developers/integrations/new_check_howto/) 自行开发。每个  Integrations 包都是一个完整的 Python 包，里面包含了一种组件的采集逻辑。

3. 准备两种操作系统，并确定已安装 `Python 2.7` 和 `pip`

   - Windows 64 位
   - Mac OS/Linux 64 位

## 生成基础包

以 `consul` 组件为例。

1. 在本地 `integrations-core` 仓库中找到名为 `consul` 文件夹，记录路径

   ```bash
   ~/Projects/integrations-core/consul
   ```

2. 进入 `datadog_plugin_framework` 目录，执行构建命令

   ```bash
   python build.py consul ~/Projects/integrations-core/consul -o ~/Desktop/datadog_plugins
   ```

   稍等片刻后，`~/Desktop/datadog_plugins` 路径下会创建一个名为 `bkplugin_consul` 的文件夹，根据你使用的操作系统，会生成对应 os 的目录。

## 包测试

1. 进入基础包目录(如果上个步骤打的是 Linux 包)

   ```bash
   ~/Desktop/datadog_plugins/bkplugin_consul/external_plugins_linux_x86_64/bkplugin_consul
   ```

2. 拷贝配置模板

   ```bash
   cp etc/conf.yaml.example etc/conf.yaml
   ```

3. 修改 `etc/conf.yaml` ，根据实际情况填写

4. 执行启动脚本

   ```bash
   ./start.sh
   ```

5. 若输出类似于以下格式，则说明能够正常运行。但是指标的正确性仍需人工检查

   ```bash
   consul_check{check="service:rabbitmq-1",consul_datacenter="dc",consul_service_id="rabbitmq-1",service="rabbitmq"} 1
   consul_check{check="service:redis-1",consul_datacenter="dc",consul_service_id="redis-1",service="redis"} 1
   ```

## 制作标准包

1. 清理测试步骤所产生的多余文件

   ```bash
   find . -name "*.pyc" -delete
   rm -rf logs
   rm -f conf.yaml
   ```

   此时，目录结构应该长这样子

   ```bash
   ├── VERSION
   ├── etc
   │   ├── conf.yaml
   │   ├── conf.yaml.example
   │   ├── env.yaml
   │   └── env.yaml.tpl
   ├── info
   │   ├── config.json
   │   ├── description.md
   │   ├── meta.yaml
   │   ├── metrics.json
   │   ├── release.md
   │   └── signature.yaml
   ├── lib
   │   ├── __init__.py
   │   ├── collector.py
   │   ├── data_formatter.py
   │   ├── log.py
   │   ├── main.py
   │   ├── patch
   │   │   ├── __init__.py
   │   │   └── aggregator_base.py
   │   └── site-packages
   ├── logs
   │   └── consul.log
   ├── main.py
   ├── parse_yaml.sh
   ├── project.yaml
   └── start.sh
   ```

2. 制作配置模板

   ```bash
   cp etc/conf.yaml.example etc/conf.yaml.tpl
   ```

   查看配置，并使用占位符 `{{ var }}` 将变量标记起来。注意，完整的配置可能有非常多的参数，但只需标记使用频率高的参数，如用户名、密码等变量。

   例如，在 consul 的 `conf.yaml.example` 中，有以下配置：

   ```yaml
   init_config:

   instances:
       ## @param url - string - required
       ## Where your Consul HTTP Server Lives
       ## Point the URL at the leader to get metrics about your Consul Cluster.
       ## Remind to use https instead of http if your Consul setup is configured to do so.
       #
     - url: http://localhost:8500
   ```

   可在 `conf.yaml.tpl` 中，将 `url` 的值使用占位符代替。

   ```yaml
   init_config:

   instances:
       ## @param url - string - required
       ## Where your Consul HTTP Server Lives
       ## Point the URL at the leader to get metrics about your Consul Cluster.
       ## Remind to use https instead of http if your Consul setup is configured to do so.
       #
     - url: {{ instance_url }}
   ```

   `instance_url` 这个名称先记住，后面完善 `config.json` 会用到。

3. 完善 meta.yaml

   `info/meta.yaml` 里面有些字段需要手动填写：

   ```yaml
   # 插件ID，通常为 bkplugin_{组件名称}
   plugin_id: bkplugin_consul
   # 插件显示名称
   plugin_display_name: Consul
   # 插件类型，不要改动
   plugin_type: DataDog
   # 标签，置空即可
   tag:
   # 插件类型，不要改动
   label: component
   # 是否支持远程采集
   is_support_remote: True
   # 固定字段，不要改动
   datadog_check_name: consul
   ```

4. 完善 metrics.json

   请根据实际上报指标和维度，定义 `info/metrics.json`，格式参考插件规范。样例如下：

   ```json
   {
   	"fields": [{
   		"description": "数据中心",
   		"type": "string",
   		"monitor_type": "dimension",
   		"unit": "",
   		"name": "consul_datacenter"
   	}, {
   		"description": "节点ID",
   		"type": "string",
   		"monitor_type": "dimension",
   		"unit": "",
   		"name": "consul_node_id"
   	}, {
   		"description": "关键服务总数",
   		"type": "double",
   		"monitor_type": "metric",
   		"unit": "",
   		"name": "consul_catalog_services_critical"
   	}],
   	"table_name": "node_metrics",
   	"table_desc": "节点相关指标"
   }]
   ```

5. 完善 config.json

    `info/config.json` 根据步骤 2 中模板预留的占位符定义参数，格式参考插件规范。样例如下，其中：

   - `python_path` 必须提供
   - 其他参数为 `conf.yaml.tpl`中提供的占位符，mode 请填写 `opt_cmd` ，其余按实际情况填写

   ```json
   [
       {
           "description": "Python 程序路径",
           "default": "python",
           "visible": false,
           "mode": "collector",
           "type": "text",
           "name": "python_path"
       },
       {
           "default": "http://localhost:8500",
           "mode": "opt_cmd",
           "type": "text",
           "description": "实例 URL",
           "name": "instance_url"
       }
   ]
   ```

6. 完善 description.md

   `info/description.md` 描述这个插件。包括插件的用途、插件的参数列表及填写示例、插件的依赖等。

   **配置说明**

   请确认目标机器已安装`python 2.7`或更高版本，并正确填写 Python 程序所在路径。

   配置信息：
   - `实例 URL`：Consul 的 HTTP 服务地址，例如 `http://localhost:8500`


7. 插入 logo.png

8. 完善 project.yaml

   以下三个字段需要自行完善：

   - name
   - description
   - description_en

   ```yaml
   name: bkplugin_consul
   version: 1.1
   description: Consul
   description_en: Consul
   category: external
   auto_launch: false
   launch_node: all
   upstream:
      bkmonitorbeat
   dependences:
      gse_agent: "1.2.0"
      bkmonitorbeat: "1.7.0"
   control:
      start: "./start.sh"
      version: "cat VERSION"
      debug: "./debug.sh"
   config_templates:
      - plugin_version: "*"
        name: env.yaml
        version: 1
        file_path: etc
        format: yaml
        source_path: etc/env.yaml.tpl
      - plugin_version: "*"
        name: conf.yaml
        version: 1
        file_path: etc
        format: yaml
        source_path: etc/conf.yaml.tpl
   ```

## 制作多操作系统的插件包

将 4 中的步骤在不同操作系统上再操作一次，然后将这些目录合并，最终得到一个这样的目录结构。

```bash
bkplugin_consul  --  根目录
└── external_plugins_linux_x86_64
    └── bkplugin_consul
└── external_plugins_windows_x86_64
    └── bkplugin_consul
```

进入到根目录下打包。

```bash
tar cvzf bkplugin_consul-1.1.tgz external_plugins_*
```

至此，一个完整的插件包诞生了，可以在监控平台的插件管理页面进行导入。
