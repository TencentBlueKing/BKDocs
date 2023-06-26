# 实现发布与回滚


## 关键词：发布、回滚

## 业务挑战

对于业务运维来说，业务的发布与回滚流程比较机械固定；某些环节，比如：将代码拉取下来进行源码依赖打包，这个过程非常复杂、费事耗时。

## BKCI优势

通过BKCI将发布、回滚各个流程环节组装成不同的插件，一条流水线把CI/CD全流程打通，实现业务发布与回滚操作。

## 解决方案

1、 配置如下流水线

仅供参考


![&#x56FE;1](../../../assets/scene-Implement-publishing-rollback-a.png)

2、   流水线配置

启动流水线时可以选择参数, 是发布或者回滚； 如果是回滚则需要指定回滚的版本号, 我们增加了流水线参数来控制版本号、回滚版本号以及控制回滚操作, 流水线执行时界面有如下选项（这里只是示例）


![&#x56FE;1](../../../assets/scene-Implement-publishing-rollback-b.png)

插件配置如下：

![&#x56FE;1](../../../assets/scene-Implement-publishing-rollback-c.png)

3、 编译打包归档

编译打包应该只在发布构建时执行, 而回滚时不需要执行；我们使用BKCI的执行条件选项来控制是否执行本步骤, 红框的部分,这里会判断流水线参数rollback是否为true, 如果false则跳过编译打包步骤


![&#x56FE;1](../../../assets/scene-Implement-publishing-rollback-d.png)

4、  发布与回滚

通过流水线自定义变量来实现控制哪个分支执行


![&#x56FE;1](../../../assets/scene-Implement-publishing-rollback-e.png)

这只是一个简单的场景demo，实际发布与回滚步骤要比这复杂很多，不同公司或不同项目在执行流程上也是不同的；案例，仅供参考。

