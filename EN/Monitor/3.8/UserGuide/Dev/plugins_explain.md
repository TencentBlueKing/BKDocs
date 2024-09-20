# Plug-in configuration file description

There are online production methods for plug-in production. If you want to quickly make offline production, it is also very convenient. You need to understand all the plug-in configuration instructions.

## Exporter

```bash
./ # Compressed package root directory
|-- external_plugin_aix_powerpc # aix system power CPU architecture plug-in collection
|-- extarnal_plugin_windows_x86_64 # A collection of plug-ins for windows system x86 64-bit CPU architecture
     `-- mysql_exporter # Plug-in name
         |-- info # Plug-in information
             |-- description.md # Plug-in description
             |-- logo.png # Plug-in logo
             |-- config.json # Plug-in parameter configuration schema
             |-- meta.yaml # Plug-in meta information
             `-- metrics.json # Plug-in result table configuration
         |-- mysql_exporter.exe # exporter binary file, with the same name as the plug-in folder, and the suffix name is retained
         `-- VERSION # Version information file
`-- external_plugin_linux_x86_64 # Linux system x86 64-bit CPU architecture plug-in collection
     `-- mysql_exporter # Plug-in name
         |-- info # Plug-in information
             |-- description.md # Plug-in description
             |-- logo.png # Plug-in logo
             |-- config.json # Plug-in parameter configuration schema
             |-- meta.yaml # Plug-in meta information
             `-- metrics.json # Plug-in result table configuration
         |-- mysql_exporter # exporter binary file, with the same name as the plug-in folder, and the suffix name is retained
         \-- VERSION # Version information file
```

### meta.yaml

```yaml
plugin_id: mysql_exporter #Plugin ID
plugin_display_name: Mysql Exporter #Plugin display name
type: Exporter # Plug-in type
tag: xxxx # Plug-in tag
```

## script

```bash
./ # Compressed package root directory
|-- external_plugin_windows_x86_64 # A collection of plug-ins for windows system x86 64-bit CPU architecture
`-- external_plugin_linux_x86_64 # Linux system x86 64-bit CPU architecture plug-in collection
     `-- ios_online # Plug-in name
         |-- info # Plug-in information
             |-- description.md # Plug-in description
             |-- logo.png # Plug-in logo
             |-- config.json # Plug-in parameter configuration schema
             |-- meta.yaml # Plug-in meta information
             `-- metrics.json # Plug-in result table configuration
         |-- ios_online.sh # Script file, the file name and script type are determined by the configuration of meta.yaml
         `-- VERSION # Version information file
```

### meta.yaml

```yaml
plugin_id: mysql_exporter #Plugin ID
plugin_display_name: Mysql Exporter #Plugin display name
type: Exporter # Plug-in type
tag: xxxx # Plug-in tag
scripts:
     type: sh # script type
     filename: ios_online.sh # Script name
```

## JMX

```bash
./ # Compressed package root directory
|-- external_plugin_windows_x86_64 # A collection of plug-ins for windows system x86 64-bit CPU architecture
`-- external_plugin_linux_x86_64 # Linux system x86 64-bit CPU architecture plug-in collection
     `-- tomcat_exporter # Plug-in name
         |-- etc
               `-- config.yaml.tpl # JMX configuration file
         |-- info # Plug-in information
             |-- description.md # Plug-in description
             |-- logo.png # Plug-in logo
             |-- config.json # Plug-in parameter configuration schema
             |-- meta.yaml # Plug-in meta information
             `-- metrics.json # Plug-in result table configuration
         |-- VERSION # Version information file
```

### meta.yaml

```yaml
plugin_id: mysql_exporter #Plugin ID
plugin_display_name: Mysql Exporter #Plugin display name
type: Exporter # Plug-in type
tag: xxxx # Plug-in tag
```

## PushGateway & DataDog & Built-In

```bash
./ # Compressed package root directory
|-- external_plugin_windows_x86_64 # A collection of plug-ins for windows system x86 64-bit CPU architecture
`-- external_plugin_linux_x86_64 # Linux system x86 64-bit CPU architecture plug-in collection
     `-- tomcat_exporter # Plug-in name
         |-- info # Plug-in information
             |-- description.md # Plug-in description
             |-- logo.png # Plug-in logo
             |-- config.json # Plug-in parameter configuration schema
             |-- meta.yaml # Plug-in meta information
             `-- metrics.json # Plug-in result table configuration
         `-- VERSION # Version information file
```

### meta.yaml

```yaml
plugin_id: mysql_exporter #Plugin ID
plugin_display_name: Mysql Exporter #Plugin display name
type: Exporter # Plug-in type
tag: xxxx # Plug-in tag
```