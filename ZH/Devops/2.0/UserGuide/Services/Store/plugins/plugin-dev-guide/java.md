# Java 插件开发指引

## 一、工程的整体结构如下

```text
|- pipeline-plugin
    |- bksdk   插件sdk
    |- demo    插件样例，你可以把工程项目名和内部逻辑修改成你自定义的
```

## 二、如何开发插件 

> 示例参考 [plugin-demo-java](https://github.com/ci-plugins/plugin-demo-java)

* 创建插件代码工程

  插件代码建议企业下统一管理。
  通用的开源插件可以联系蓝鲸官方放到 [TencentBlueKing](https://github.com/TencentBlueKing) 下，供更多用户使用

* 修改包名为有辨识度的名称，建议可以和插件标识一致
* 实现插件功能
* 规范：
  * [插件开发规范](../plugin-specification.md)
  * [插件配置规范](../plugin-config.md)
    * 插件前端不仅可以通过 task.json 进行标准化配置，也可以自定义开发：[自定义插件UI交互指引](../plugin-custom-ui.md)
  * [插件输出规范](../plugin-output.md)
  * [插件错误码规范](../plugin-error-code.md)
  * [插件发布包规范](../release.md)

## 三、如何打成研发商店要求的zip包：

1、进入pipeline-plugin目录下执行"mvn clean package"命令进行打包。

2、进入demo（插件逻辑所在的工程目录）目录下的target文件夹下就可以获取我们需要的zip包。

