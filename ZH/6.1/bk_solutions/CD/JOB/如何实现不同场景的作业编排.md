# 如何实现不同场景的作业编排

当一个操作场景需要多个步骤串联执行时，如果手工一个个去点击执行，那么效率实在太低了！并且，也没办法很好的沉淀下来，方便后续持续使用和维护。

作业平台的作业管理功能很好的解决了这个问题，用户可以在「作业模板」中配置好相应的执行步骤，然后再根据需求场景衍生对应的「执行方案」；

如此，即清晰的区分开作业模板和实例的关系，避免强耦合关系，也便于后续对使用场景的管理和维护。

具体步骤：

## 一、创建作业模板

1. 在 `作业` 页面中，点击 **新建** 进入

   ![image-20201104205455285](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20201104205455285.png)

2. 按照表单中的要求输入作业的基础信息，和步骤内容

   ![image-20200407170537403](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407170537403.png)

3. 设置 一个`name` 字符串，和 `target` 的主机列表变量，提供作业步骤中使用

   创建 `主机列表` 变量：

   ![image-20200407170400057](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407170400057.png)

   创建 `字符串` 变量：

   ![image-20200407170918316](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407170918316.png)

4. 添加执行步骤，有[执行脚本]、[分发文件]、人工确认]三个类型

   这里我们添加三个步骤：

   步骤一、分发本地文件

   ![image-20210421114851834](../assets/image-20210421114851834.png)

   步骤二、脚本执行，直接写临时脚本,也可以引用已有脚本，用上全局变量 `name`

   ![image-20200407171444377](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407171444377.png)

   步骤三、加个人工确认步骤，演示一下

   ![image-20200407171536319](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407171536319.png)

5. 最后点击 `提交` 按钮，保存作业模板；至此，作业模板就创建完毕

   ![image-20200407171643379](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407171643379.png)

## 二、创建执行方案

作业「执行方案」是由模板衍生出来的实体对象，不同的执行方案通常用于面向不同的使用场景

1. 进入刚才创建的作业模板，并点击 `选择方案` 前往创建或查看执行方案

   ![image-20200407172705035](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407172705035.png)

2. 点击「新建执行方案」来创建一个全新的作业执行方案

   ![image-20200407172907623](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407172907623.png)

3. 提交保存后，即可在列表中看到刚刚创建的执行方案

   ![image-20200407172941308](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407172941308.png)

## 三、执行作业

1. 从刚才创建的执行方案页面中，点击「**去执行**」来触发执行动作

   ![image-20200407195149316](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407195149316.png)

2. 执行前，还可以根据自己的需求场景来修改全局变量的值

   ![image-20200407195351347](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407195351347.png)

3. 全局变量的值确认后，点击「**执行**」即可进入执行总览页面：

   ![image-20200407200026973](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407200026973.png)

4. 点击单个步骤可查看该步骤的执行详情

   ![image-20200407200229158](https://bkdocs-1252002024.file.myqcloud.com/ZH/6.0/%E4%BD%9C%E4%B8%9A%E5%B9%B3%E5%8F%B0/%E4%BA%A7%E5%93%81%E7%99%BD%E7%9A%AE%E4%B9%A6/Quick-Starts/media/image-20200407200229158.png)