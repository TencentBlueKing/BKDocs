# 定时触发方式

定时触发方式可以让用户在指定时间触发流水线，适用于希望在构建资源空闲的时间（比如深夜）触发流水线的场景。用户可以选择基础规则和 crontab 表达式，两者可以同时选择。
**注意：** 触发时间以服务器时间为准，建议将BKCI服务器时区调整到用户所在时区

![png](../../../assets/image-trigger-timer-plugin.png)

![png](../../../assets/image-trigger-timer-rule.png)

