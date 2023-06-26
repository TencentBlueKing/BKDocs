# 如何在线制作插件

在监控平台的插件管理里面可以非常方便的制作一个的插件。

## 第一步：准备工作

1. 获取 BK-Plugin  Framework

   ```bash
   wget https://bktencent-1252002024.file.myqcloud.com/datadog_plugin_framework-master.tar.gz
   tar xf datadog_plugin_framework-master.tar.gz  # 解压刚才下载的文件
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

3. 准备两种操作系统，并确定已安装 `python 2.7` 和 `pip`

   - Windows 64 位
   - Mac OS/Linux 64 位

## 第三步：生成基础包

以 `consul` 组件为例

1. 在本地 `integrations-core` 仓库中找到名为 `consul` 文件夹，记录路径

   ```bash
   ~/Projects/integrations-core/consul
   ```

2. 进入 `datadog_plugin_framework` 目录，执行构建命令

   ```bash
   python build.py consul ~/Projects/integrations-core/consul -o ~/Desktop/datadog_plugins
   ```

   稍等片刻后，`~/Desktop/datadog_plugins` 路径下会创建一个名为 `bkplugin_consul` 的文件夹，根据你使用的操作系统，会生成对应 os 的目录

3. 将生成的 `bkplugin_consul` 的目录压缩为 `tgz` 格式，即可在插件编辑页面进行上传

## 第三步：在插件管理中创建插件



