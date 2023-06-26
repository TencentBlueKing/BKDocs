## Q1：流水线之间如何做排队/互斥操作

参考此文档进行配置

[流水线互斥](https://docs.bkci.net/tutorials/scene/pipeline-exclusion-queue)



## Q2：流水线等待其他流水线执行结果

问题背景：有pipeline A,可单独执行，我又有pipeline B,B里面会去调用A，等待A的一个结果，这种如何做互斥呢？

可以使用子流水线功能。

使用 call pipeline 调用子流水线。选择**同步执行**即可，触发后继续等待执行结果，有结果后再决定是否继续。



## Q3：如何在流水线构建历史页面显示自定义信息

可以在流水线里加个shell**插件**，通过设置`BK_CI_BUILD_REMARK`这全局变量的值，来实现想要的备注。流水线结束了，该字段才会显示。

并且在流水线历史页面添加备注字段。具体请参考：

[使用备注变量](https://docs.bkci.net/services/pipelines/pipeline-variables/pipeline-variables-remark)



## Q4: 流水线的变量能联动吗，例如变量B的值跟随变量A变化

暂时还不支持联动，如果值没什么变化，可以设置默认值。



## Q5：流水线执行时，参数下拉列表值能通过自定义接口获取么？

不支持接口自定义



## Q6: 多个job是共用一个workspace吗？

如果用的单构建机（私有构建机），多个job就会共用一个 workspace 目录。

如果是公共构建机，那么每个job在workspace下会有一个单独的目录 。

私有构建机和公共构建机，默认每个流水线都建立一个独立的 workspace 目录。



## Q7：如何获取构建产物的URL

http://devops.bktencent.com/ms/artifactory/api/user/artifactories/file/download/local?filePath=/bk-archive/${项目名称}/${BK\_CI\_PIPELINE\_ID}/${BK\_CI\_BUILD\_ID}/{你的artifacts文件名}



---

