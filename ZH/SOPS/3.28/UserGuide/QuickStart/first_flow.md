# 第一个流程

>流程编排是标准运维最核心的功能，通过将不同功能的原子插件在画布上可视化的拖拽编排，可以实现各种不同场景的跨系统工作流。

# 标准运维流程

根据实际运维操作场景梳理出来的操作步骤，通过不同的流转逻辑（并行、分支、条件并行）进行灵活的组合。

# 标准运维插件

标准运维中的最小执行单元，根据每个 ESB 组件的业务逻辑进行二次封装，增加丰富的表单界面和验证逻辑。比如一个作业平台的脚本执行、一个配置平台的新增集群、一个PaaS的邮件通知。

当然，除了蓝鲸体系自带封装的标准插件，可以自行开发第三方的插件，比如公司内部系统的某操作原子、云服务的某操作等。

# 实操演示

这里以一个最简单的流程编排为例：执行一个脚本然后再发一个消息通知。

## 1、新建流程

在demo体验业务下，流程-新建

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103330/20044/20230506103330/--17c6a17ec2d0be50fafbfa82d5c7fa95.png)


## 2、编排流程
在这个流程中我们使用一个调用作业平台执行一段脚本，然后再加一个通知的节点

双击节点打开配置面板，选择“作业平台(JOB)-快速执行脚本”插件：
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103354/20044/20230506103354/--60200f8039a3dfd8912b1f3408f49feb.png)

配置第一个节点

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103407/20044/20230506103407/--9ac055edfe93580f27fe80de385569be.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103417/20044/20230506103417/--3e8d0947b273e0ca9d5ccd986f990e6e.png)

再添加一个消息通知的插件，画布的快捷操作可以看 [标准运维画布的快捷操作(上）](https://bk.tencent.com/s-mart/community/question/10032)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103505/20044/20230506103505/--cf7438536cb4e7be9e0a8ccfcd6b016e.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103515/20044/20230506103515/--5333dc94a382d28a4c8c01496d4bc7d9.png)

配置消息通知节点

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103528/20044/20230506103528/--4637a5e1e0a4190a828173444fc94775.png)

## 3、新建任务

流程是任务的模板，配置好流程之后，就可以新建任务执行了

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103630/20044/20230506103630/--6110a74c01bdbe44c4ffd75b90c994f4.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103637/20044/20230506103637/--cc725b56f1933ec9d107bf0335c135c2.png)

## 4、执行任务
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103848/20044/20230506103848/--7f04a41c19e03db2ebc26e4c5a18dc01.png)

可以单击节点查看执行详情，比如脚本执行，可以跳转到作业平台去看详细执行历史

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103907/20044/20230506103907/--2543ad3d20dfd2f82e53e96971f641ea.png)

查看失败节点

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103921/20044/20230506103921/--0cb887f892082ca31ed54ab5b49de7e6.png)

解决完错误之后，可以hover失败节点，点击重试或者选择跳过。

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103938/20044/20230506103938/--aa56e383120ebeb268233c717a23e48b.png)

编辑任务参数

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506103954/20044/20230506103954/--9f844dc6791d2d55964f191087e4d750.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506104000/20044/20230506104000/--da8ebf02678cbe7406d2a2e080430ca4.png)

查看更多信息

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230506104014/20044/20230506104014/--3f2ca9f88858f7dea3ec72ec28963928.png)

以上就演示了一个最简单的流程编排，没有复杂的分支流转逻辑，更高级的流程编排用法可以查看[【汇总】【每天掌握一个功能点】7.0产品功能使用系列](https://bk.tencent.com/s-mart/community/question/9761?type=answer)标准运维部分。

 