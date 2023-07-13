>仪表盘以及数据视图是除告警功能以外最高频的使用场景，监控平台仪表盘是基于Grafana的设计理念，基本在不改变Grafana原生使用方式的情况下融入了蓝鲸监控自己的功能。

## 1、基本概念
**仪表盘(Dashboard)**：即一个可视化大屏，由多个图和可配置的区域组成。
**面板(Panel)**: 一个基本的可视化单元，即一张图的显示区域。
**分组/行(Row)**: 多个图组成的一行，即分组的功能。
**数据源(Data Source)**: 数据的来源，指可以配置仪表盘的数据来源，grafana支持对接多种数据源。
**变量(Variables)**: 变量方便查看不同值的仪表盘数据。

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162423/20044/20230615162423/--bb9763b5091a2334e42c899b36b62ad4.png)

（配置了变量的仪表盘，区分有不同的区域)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162602/20044/20230615162602/--1a7b1580703646b606c090c41982bee4.png)

(内置仪表盘，部署完监控平台即可查看)

## 2、效果展示

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162627/20044/20230615162627/--257c633501eb5f9a47a431124b22539f.png)

仪表盘有很灵活的定制方案，可以按自己的喜好或业务的需求配置各式各样的。


## 3、实操演示

配置一个最简单的仪表盘为例。

仪表盘的配置主要有三步：
- 新建目录:将同一个用途的仪表盘放一个目录下面归类管理，方便查找
- 新建仪表盘：新建仪表盘。
- 配置仪表盘并保存：按需配置不同的图

### 3.1 新建目录
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162658/20044/20230615162658/--dbbf12c7e5b432e683be385b41a690c2.png)

### 3.2 新建仪表盘
选择创建好的目录，然后点击新建仪表盘
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162712/20044/20230615162712/--eec511a30889992a15929553022734e4.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162718/20044/20230615162718/--312be55ebbc77a49d66f9f5c2756ae51.png)

### 3.3 新建数据视图
这里我们直接简单添加一个单图，暂不添加图分组。
新增图，首先选择数据源，默认是`蓝鲸监控-指标数据`，如果想选择其他非指标的数据，则可以切换`数据源`。接着选择具体的指标。最后一步是选择展示`图的类型`。
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162750/20044/20230615162750/--77938d309f7d4f3fd3eac40915f58cad.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162756/20044/20230615162756/--266fedc1a20ec13b0349058d918314d8.png)

（选择一个CPU使用率的指标，图的类型默认是time series)

点击右上角apply，应用视图。然后保存仪表盘到之前建的目录下即可
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162811/20044/20230615162811/--9b6518701d3fff3230ece7dfd6b7837e.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162819/20044/20230615162819/--d34facb9a98879c89d8691ab8654c2d2.png)

（保存仪表盘)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162829/20044/20230615162829/--545c70c3d8c4ec47f3e67ad0b8556fa3.png)

(收藏仪表盘)

这样，就完成了一个最简单的单图仪表盘创建了，如果要配置丰富好看的仪表盘，则可以使用不同类型的图样式、配色、图分组等来自由组合实现。

## 附：仪表盘常见的操作
### a)快速分享仪表盘或图

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162905/20044/20230615162905/--4a694fe060d51575d4cbb56ab7251a61.png)

（分享仪表盘)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162917/20044/20230615162917/--2f7f2b389d72e95fe5d536318d27c933.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162922/20044/20230615162922/--ee6d1777045a0afe5db92650e4b2e777.png)

（分享单图)

### b)导出仪表盘
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615162945/20044/20230615162945/--696d2dee5533a19558aceeba46bb6521.png)

（导出为JSON文件)

### c)导入仪表盘
比如在A业务配置好一个通用仪表盘之后，在其B业务直接导入

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615163003/20044/20230615163003/--174f629b2110c2f7bef3379bc36abcaa.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615163009/20044/20230615163009/--761e5db5bdf4e66cbd61cf76fbfd2212.png)

导入成功之后可以编辑下图（因为数据源需要重新选）即可。

### d)给视图添加告警策略
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615163029/20044/20230615163029/--08fb5f5e0d542ac99838dbe72530e62c.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615163034/20044/20230615163034/--78d3fb100dfc57a95aa5cf675ff2ebc9.png)


然后根据实际策略往下配置即可。
配置完策略也可以在图上快速查看相关告警
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615163047/20044/20230615163047/--e2a3955f360a2ac48f4ae688118802a9.png)



