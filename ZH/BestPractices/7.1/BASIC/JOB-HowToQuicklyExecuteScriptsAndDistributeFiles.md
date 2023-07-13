>脚本执行和文件分发是作业平台最基本、最核心的两个原子功能，主要分页面快速执行和作业里步骤引用，使用逻辑一样，一起来看看具体如何使用

## 快速执行脚本

核心实现原理就是基于gse的命令管道，把脚本内容以WebPortal的方式透传到目标服务器进行执行，可以页面输入脚本也可以引用编写好的脚本。目前支持shell、bat、Perl、Python、Powershell、SQL几类

### 实操演示

 例1：执行一个简单的页面快速脚本（shell），打印"hello blueking"

#### 1、填写脚本执行相关信息
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230505150638/20044/20230505150638/--bf60436dbef1c4ab27f918d0feaf0570.png)



#### 2、执行
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230505150658/20044/20230505150658/--bf57446f48e4adfd50c5ac8aa0a9a60c.png)



#### 3、复杂执行日志结果的一些常用处理操作
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230505150711/20044/20230505150711/--d4418d278636d22d51423cd4be98138b.png)

#### 4、搜索执行历史，进行重做操作
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230505150737/20044/20230505150737/--35f84a8bebeb600bc467858a5b7c48ed.png)

 例2：执行一个简单的 "show tables" 的MYSQL脚本

#### 1、配置mysql账号（很重要）
数据库账号目前支持MySQL、oracle、DB2三类。这里以mysql为例
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230505150811/20044/20230505150811/--430e292840453ea16d469489c66ae753.png)

#### 2、执行SQL脚本

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230505150830/20044/20230505150830/--728541d67cf8a1387b5d89416bc5a368.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230505150838/20044/20230505150838/--849b096e2ad370b4fbc0b2ab9d561054.png)

其他几类语言的脚本就不一一演示了，可以根据实际场景实操体验。

## 文件分发

文件分发主要是基于gse的文件通道来实现的，支持本地文件分发、服务器文件分发和对象存储类的文件源。

### 实操演示

这里以本地文件作为文件源简单演示，对象存储类型的单独详细说明。

### 1、填写文件分发信息
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230505150923/20044/20230505150923/--259f24c4c2c14cfd0db5b433f850bcf2.png)

### 2、执行分发
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230505150939/20044/20230505150939/--a8e14fc3d333eea588288900545847fb.png) 