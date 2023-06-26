---
description: codecc
---

# 代码检查FAQ

## Q1: 流水线上加了codecc插件后，如何配置扫描的目录？

占位，待补充

## Q2: 代码分析报错：检测到这是私有构建机

![](../../assets/企业微信截图_16393674859420.png)

代码分析不支持私有构建机，可使用公共构建机执行该插件

## Q3: 有些代码分析任务不需要了，怎么删除

![](../../assets/企业微信截图_16394863726885.png)

不提供删除功能，如果不需要可以选择停用

![](../../assets/wecom-temp-86ae0a86fe2fc72292be8a99ea3aca3c.png)

## Q4: codecc路径屏蔽怎么使用

占位**，待补充**

## Q5: 一些类里面的std::string，我们希望他是不变的一个const static变量，但是目前代码检测说不可以，必须是const char\*。这个规则不太理解，怎么找到规则背后的原理？

![](../../assets/image-20220301101202-dqwHG.png)

codecc的cpplint规则是基于Google C++代码规范的，可以参考[https://google.github.io/styleguide/cppguide.html#Names\_and\_Order\_of\_Includes](https://google.github.io/styleguide/cppguide.html#Names\_and\_Order\_of\_Includes) ，这里的问题是fstream作为c++的系统头文件，include顺序应放在如boost/\*等第三方引入之前

## Q6: 请问codecc 有检测lua代码的吗默认语言里有吗？

暂时还不支持lua的代码检查

## Q7: 我看不到代码检查的源码，显示无法获取代码片段，请确保你对代码库拥有权限，且该文件未从代码库中删除

![](../../assets/企业微信截图_162764646337.png)

1. 确认下对该代码库是否有「查看」以及「使用」权限
2. 使用「Checkout gitlab」插件拉取代码

![](../../assets/wecom-temp-cf8119964a088f29ea8c6ab91207001b.png)

## Q8: codecc的规则可以自定义或者修改吗，比如想加自己这边的一些命名检查啥的

codecc的规则暂时不支持自定义，只有少数规则可以修改参数

![](../../assets/wecom-temp-08d0c28a28b7da8ca0aa399a96834f15.png)

![](../../assets/wecom-temp-54ddc1c54d449c261c04721f0cf403d2.png)



## Q9:代码检查配置增量扫描的情况下，换了台新的公共构建机后，代码检查失败

![](../../assets/企业微信截图_16388456801202.png)

切换构建机的时候，需要先进行一次全量扫描，且gitlab checkout 选择fresh checkout方式



## Q10：codecc 插件工程语言显示为空

![](../../assets/codecc_project_lang_error.png)

该问题为 1.8 版本以下 codecc 的BUG。建议使用 1.8+ 版本的 codecc。





## Q11：codecc 查看代码问题报错

![](../../assets/codecc_check_error.png)

codecc 检查的代码，必须使用 checkout 插件进行拉取。

此处报错部分的代码文件是使用 shell 脚本拉取的。codecc 无法识别。



## Q12：codecc 检查花费很长时间(15h+)，然后报错

![](../../assets/codecc_post_error.png)

排查日志后发现如上图的错误。原因是 codecc 机器 /etc/resolv.conf 文件中没有写入对应的 127.0.0.1 解析。

加入解析后即可恢复正常。



蓝鲸BKCI和 codecc 的服务对解析都有依赖，如果 resolv.conf 这个文件会因为重启等原因经常被还原的话，建议加锁
加锁命令：
sed -i "/\[main\]/a\dns=none" /etc/NetworkManager/NetworkManager.conf



## Q13：Cannot connect to the Docker

![](../../assets/codecc_docker_error.png)

codecc 默认运行于公共构建机 docker 环境之中。

出现此报错请检查公共构建机是否正常开启了 docker 服务。
