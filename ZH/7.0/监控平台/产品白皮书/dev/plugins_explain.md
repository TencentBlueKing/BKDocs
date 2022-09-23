# 插件配置文件说明

插件制作有线上制作方法，如果要快速线下制作也是非常的方便，需要了解下所有的插件配置说明。

## Exporter

```bash
./                       # 压缩包根目录
|-- external_plugin_aix_powerpc            # aix 系统 power CPU 架构的插件集合
|-- extarnal_plugin_windows_x86_64         # windows 系统 x86 64位 CPU 架构的插件集合
    `-- mysql_exporter            # 插件名称
        |-- info                  # 插件信息
            |-- description.md    # 插件描述
            |-- logo.png          # 插件 logo
            |-- config.json       # 插件参数配置 schema
            |-- meta.yaml         # 插件元信息
            `-- metrics.json      # 插件结果表配置
        |-- mysql_exporter.exe    # exporter 二进制文件，与插件文件夹同名，后缀名保留
        `-- VERSION               # 版本信息文件
`-- external_plugin_linux_x86_64           # linux 系统 x86 64位 CPU 架构的插件集合
    `-- mysql_exporter            # 插件名称
        |-- info                  # 插件信息
            |-- description.md    # 插件描述
            |-- logo.png          # 插件 logo
            |-- config.json       # 插件参数配置 schema
            |-- meta.yaml         # 插件元信息
            `-- metrics.json      # 插件结果表配置
        |-- mysql_exporter        # exporter 二进制文件，与插件文件夹同名，后缀名保留
        \-- VERSION               # 版本信息文件
```

### meta.yaml

```yaml
plugin_id: mysql_exporter  # 插件 ID
plugin_display_name: Mysql Exporter  # 插件显示名称
type: Exporter  # 插件类型
tag: xxxx       # 插件标签
```

## script

```bash
./                       # 压缩包根目录
|-- external_plugin_windows_x86_64         # windows 系统 x86 64位 CPU 架构的插件集合
`-- external_plugin_linux_x86_64           # linux 系统 x86 64位 CPU 架构的插件集合
    `-- ios_online                # 插件名称
        |-- info                  # 插件信息
            |-- description.md    # 插件描述
            |-- logo.png          # 插件 logo
            |-- config.json       # 插件参数配置 schema
            |-- meta.yaml         # 插件元信息
            `-- metrics.json      # 插件结果表配置
        |-- ios_online.sh         # 脚本文件，文件名与脚本类型由 meta.yaml 的配置确定
        `-- VERSION               # 版本信息文件
```

### meta.yaml

```yaml
plugin_id: mysql_exporter  # 插件 ID
plugin_display_name: Mysql Exporter  # 插件显示名称
type: Exporter  # 插件类型
tag: xxxx       # 插件标签
scripts:
    type: sh    # 脚本类型
    filename: ios_online.sh  # 脚本名称
```

## JMX

```bash
./                       # 压缩包根目录
|-- external_plugin_windows_x86_64         # windows 系统 x86 64位 CPU 架构的插件集合
`-- external_plugin_linux_x86_64           # linux 系统 x86 64位 CPU 架构的插件集合
    `-- tomcat_exporter           # 插件名称
        |-- etc
              `-- config.yaml.tpl   # JMX 配置文件
        |-- info                  # 插件信息
            |-- description.md    # 插件描述
            |-- logo.png          # 插件 logo
            |-- config.json       # 插件参数配置 schema
            |-- meta.yaml         # 插件元信息
            `-- metrics.json      # 插件结果表配置
        |-- VERSION               # 版本信息文件
```

### meta.yaml

```yaml
plugin_id: mysql_exporter  # 插件 ID
plugin_display_name: Mysql Exporter  # 插件显示名称
type: Exporter  # 插件类型
tag: xxxx       # 插件标签
```

## PushGateway & DataDog & Built-In

```bash
./                       # 压缩包根目录
|-- external_plugin_windows_x86_64         # windows 系统 x86 64位 CPU 架构的插件集合
`-- external_plugin_linux_x86_64           # linux 系统 x86 64位 CPU 架构的插件集合
    `-- tomcat_exporter           # 插件名称
        |-- info                  # 插件信息
            |-- description.md    # 插件描述
            |-- logo.png          # 插件 logo
            |-- config.json       # 插件参数配置 schema
            |-- meta.yaml         # 插件元信息
            `-- metrics.json      # 插件结果表配置
        `-- VERSION               # 版本信息文件
```

### meta.yaml

```yaml
plugin_id: mysql_exporter  # 插件 ID
plugin_display_name: Mysql Exporter  # 插件显示名称
type: Exporter  # 插件类型
tag: xxxx       # 插件标签
```
