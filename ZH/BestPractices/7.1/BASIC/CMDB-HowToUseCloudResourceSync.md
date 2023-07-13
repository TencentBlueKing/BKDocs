>云资源同步是通过apikey去单向同步云上的主机资源和云区域信息，目前支持腾讯云和亚马逊云。

## 主要特性
1、蓝鲸配置平台周期性的单向只读同步云主机和vpc（对应蓝鲸云区域）信息，第一次全量，后面增量

2、默认同步到主机池，也可自定义主机池模块，需要手动分配到业务

3、主机随云控制台销毁而从配置平台里删除掉

## 实操演示

以腾讯云CVM自动同步为例

### 1、新增云账户
资源-云账户-新建

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230511151856/20044/20230511151856/--f0cd3ac6dee709b032e182bf7ac5f734.png)

如何获取ID和Key？

登录腾讯云控制台，账号信息-访问管理-访问密钥

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230511151907/20044/20230511151907/--64c9f8a7842ef18dcb2f2ffe186f9519.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230511151913/20044/20230511151913/--011abfe24fdb06abc4c23a91b57021ea.png)

连通性测试OK即表明能正常通过apikey拉取，云账号创建成功。

### 2、配置云资源同步任务
云账号创建成功之后，需要配置云资源发现的任务，开启云资源同步。
资源-云资源发现-新建
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230511151937/20044/20230511151937/--dd37d6fadef678d9f9f77770563eeb34.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230511151955/20044/20230511151955/--d086f20177d848dcf1b9213c165155a2.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230511152004/20044/20230511152004/--5388466f591b5d2eaaa48112f423a0d9.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230511152008/20044/20230511152008/--5388466f591b5d2eaaa48112f423a0d9.png)

### 3、分配主机到业务

云资源同步任务成功启动之后，5分钟内会把配置的vpc下主机同步到主机池，然后分配到对应的业务即可

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230511152019/20044/20230511152019/--066ea7123998d2e9d15a2296b3392340.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230511152025/20044/20230511152025/--1b965e24889eae1bd3ead843e96d0df1.png)

### 4、节点管理安装agent
分配到业务之后，1分钟左右会同步到节点管理，并且带云区域信息，可以直接进行agent/proxy的安装。（根据非直连区域agent安装指引，需要提前安装proxy）具体详细指引见：[【节点管理】直连区域和非直连区域的agent如何安装](https://bk.tencent.com/s-mart/community/question/10079)