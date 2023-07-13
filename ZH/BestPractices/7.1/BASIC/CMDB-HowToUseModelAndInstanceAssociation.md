>我们知道主机是配置平台最常见的管控资源对象，在业务拓扑里可以通过划分模块来清晰的可视化管理；那其他资源如何通过配置平台来纳管呢，比如网络设备交换机。

#### 场景需求：如何把交换机和主机的关联关系在配置平台进行可视化的纳管

## 一.不友好的方式
通过主机的自定义字段来纳管
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118101829/20044/20221118101829/--5ca4c1bae03a3dee24c06cc271550acf.png)

`（添加一个自定义字段）`



![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118101902/20044/20221118101902/--84c34a360b7f7b22153ec783226b524d.png)

`（给自定义字段赋值）`

通过这种方式倒也实现了主机和交换机的关系配置，但是没有可视化的视角，也不能从交换机视角来看他下联的有哪些主机，比如点开主机详情才知道关联了哪台交换机。

## 二.通过模型关联的方式
在配置平台里，主机、业务、集群、模块实际都是“模型”，我们叫内置模型；当管控对象不局限于这些模型时，我们可以通过自定义来实现。

### 1、添加一个交换机的模型
模型-模型管理-新建模型
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118102003/20044/20221118102003/--61611fbe4de2a6b6812179bd23266e62.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118102009/20044/20221118102009/--5e1aaa836f263a394e2b6b850ea74e61.png)

`（添加模型）`

### 2、配置交换机模型的字段
模型管理-选中模型-新建字段
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118102056/20044/20221118102056/--6f83b6d939af11a4ca686902065a784c.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118150534/20044/20221118150534/--163c8d45fe177ac99a6f34f48a879b4b.png)

`（配置模型字段）`

### 3、建立跟主机之间的关联关系，比如上联主机
模型管理-选中模型-模型关联-新建关联
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118102145/20044/20221118102145/--9fb7ce2dc00b7ad22c1052e1b24c60d0.png)

`（配置模型关联关系）`

### 4、模型实例化（添加交换机实例）
> 模型是壳，只有填充实例才能在配置平台里进行纳管。
> 可以在模型详情页点击实例数量跳转过去添加页面，也可以通过资源-资源目录-找到交换机来添加

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118103610/20044/20221118103610/--8acb0c659e1ff56fb93253743e8e7b4b.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118103617/20044/20221118103617/--4a2f1c169329bda413b4a1fb2b01f99d.png)

`（模型实例化）`

### 5、建立模型实例之间的关联
选中模型实例-关联-新增关联
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118103649/20044/20221118103649/--ec4496c1649532b15b313c664276b7e5.png)

实例关联完之后便可以通过拓扑或图表的方式进行可视化查看了

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118103658/20044/20221118103658/--0374e7cd66a4799ae262095effff1822.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20221118103709/20044/20221118103709/--7eb5b0c4c5d3e3275a45b0f0182a3e26.png)

这样，我们就通过模型及模型关联来实现了对非内置模型的可视化纳管，也可以通过模型相关接口来获取这些数据。