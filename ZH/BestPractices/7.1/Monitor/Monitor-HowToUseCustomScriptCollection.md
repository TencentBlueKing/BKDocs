>脚本采集是自定义采集比较简单的一种方式，是依托bkmonitorbeat插件来实现的。

## 脚本插件简单的工作原理
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164247/20044/20230615164247/--f95e716d747c2a8feb10176d7a83c83f.png)

## 实操演示
例：用脚本实现一个统计大区游戏在线，然后制作成插件进行采集上报

### 1、制作脚本采集插件
- #### 新建脚本采集插件

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164313/20044/20230615164313/--033e37405552474b250d0e330cf4b316.png)

（新建脚本插件)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164331/20044/20230615164331/--54c29f2463ab70982b3e17f58e97fec9.png)

（编写脚本内容)

示例代码&解释：
```
online=`echo $RANDOM` #这里简单使用随机函数来作为数值online（在线人数）
echo "game_online{set=\"${set_name}\"} ${online}" #这里定义指标名称叫game_online，纬度是set,然后使用了一个变量set_name传给set
```

注意：格式一定要符合Prometheus Metrics 标准格式：

```
metric_name{label_name="lable_value"} metric_value timestamp
# 说明
metric_name	指标名称
label_name	维度名称
label_value	维度值,字符串 ；可选
metric_value	指标值,数值 ；
timestamp	时间戳(ms)；可选
一个指标一行
```

- #### 调试插件

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164359/20044/20230615164359/--0557bc56a50c7382e4d026b811e30c51.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164404/20044/20230615164404/--278abe867b19ec9e445358ea105aaa71.png)

（调试插件)

>设置数据采集周期10秒，也就是每10秒执行一次脚本

- #### 设置指标和纬度

可以给指标和纬度起一个别名，也可以预览数据

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164439/20044/20230615164439/--592654740d8cdd8641306fd5e35b89b8.png)

### 2、配置数据采集
插件调试成功并设置完指标和纬度之后便完成了插件的制作，接下来就是配置数据采集了
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164504/20044/20230615164504/--592654740d8cdd8641306fd5e35b89b8.png)
![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164509/20044/20230615164509/--ff9d575d1c5dfdf5e32d93672712d4f8.png)

（配置采集，选择制作好的脚本插件)
选择目标进行采集下发，成功之后便开始数据采集了，可以预览视图和配置告警策略

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164521/20044/20230615164521/--4dbf7795af30f08412f95c9af3ac0874.png)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164531/20044/20230615164531/--5ed6ba4b8d6a1faf5602b033d62a2cf1.png)

（采集数据视图预览)

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164539/20044/20230615164539/--878231388d43d4bc490f0b5305d92456.png)

（添加告警策略)
还可以在数据预览视图快速的保存到仪表盘，然后仪表盘可以设置喜欢的样式。

![image.png](https://smartpublic-10032816.file.myqcloud.com/custom/20230615164552/20044/20230615164552/--d0af7640e50bebda07c8a2793bd75e79.png)

（快速保存到仪表盘）
仪表盘的使用可以查看：[【监控平台】快速入门仪表盘](https://bk.tencent.com/s-mart/community/question/11547)   、 [【监控平台】仪表盘进阶用法](https://bk.tencent.com/s-mart/community/question/11549)

如此，我们便完成了一个很简单的脚本方式的自定义采集上报数据。