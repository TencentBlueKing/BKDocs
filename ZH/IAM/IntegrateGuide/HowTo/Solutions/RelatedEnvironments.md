# 依赖环境属性方案

## 背景

接入系统对于权限的生效条件的需求，除了权限本身的过期时间外，可能还需要关注权限生效的环境属性条件，比如可以控制权限只在 `星期一`的`00:00:00-06:00:00` 这个时间段生效，在这个时间段的鉴权请求都是`pass`, 时间段外的鉴权都是`not allowed`，这就需要接入系统在注册操作的时候同时提供是否能配置相关环境属性的信息

## 接入系统注册操作的依赖环境属性

详细见[注册操作 API](../Reference/API/02-Model/13-Action.md)的`related_environments`字段

## 可配置的环境属性

### 1. period_daily 时间周期

在产品上可对操作配置时间周期相关的属性：

![related_environments_1](../assets/HowTo/related_environments_1.png)

![related_environments_2](../assets/HowTo/related_environments_2.png)
