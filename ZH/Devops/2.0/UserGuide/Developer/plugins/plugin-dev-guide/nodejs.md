# NodeJS 插件开发指引

## 插件开发框架说明

**一、插件代码工程的整体结构如下：**

**二、如何开发插件：**

> 参考

* 创建插件代码工程

  插件代码建议企业下统一管理。
  通用的开源插件可以联系蓝鲸官方放到 [TencentBlueKing](https://github.com/TencentBlueKing) 下，供更多用户使用

* 实现插件功能
* 规范：
  * [插件开发规范](../plugin-dev-standard/plugin-specification.md)
  * [插件配置规范](../plugin-dev-standard/plugin-config.md)
    * 插件前端不仅可以通过 task.json 进行标准化配置，也可以自定义开发：[自定义插件 UI 交互指引](../plugin-dev-standard/plugin-custom-ui.md)
  * [插件输出规范](../plugin-dev-standard/plugin-output.md)
  * [插件错误码规范](../plugin-dev-standard/plugin-error-code.md)
  * [插件发布包规范](../plugin-dev-standard/release.md)

**三、如何打包发布：**

1. 进入插件代码工程根目录下
2. 执行打包命令打包
3. 在任意位置新建文件夹，命名示例：release\_pkg = <你的插件标识>\_release
4. 将步骤 2 生产的执行包拷贝到 <release\_pkg> 下
5. 添加 task.json 文件到 <release\_pkg> 下 task.json 见示例，按照插件功能配置。

   * [插件配置规范](../plugin-dev-standard/plugin-config.md)
   * task.json 示例：

   ```text
   {
       "atomCode": "demo",
       "execution": {
           "language": "nodejs",
           "packagePath": "",             # 发布包中插件安装包的相对路径
           "demands": [
               ""   # 插件启动前需要执行的安装命令，顺序执行
           ],
           "target": "demo"
       },
       "input": {
           "inputDemo":{
               "label": "输入示例",  
               "type": "vuex-input",
               "placeholder": "输入示例",
               "desc": "输入示例"
           }
       },
       "output": {
           "outputDemo": {
               "description": "输出示例",
               "type": "string",
               "isSensitive": false
           }
       }
   }
   ```

6. 在 <release\_pkg> 目录下，把所有文件打成 `zip` 包即可

`zip` 包结构示例：

```text
|- demo_release.zip         # 发布包
   |-     # 插件执行包
   |- task.json            # 插件配置文件
```

打包完成后，在插件工作台提单发布，即可测试或发布插件

