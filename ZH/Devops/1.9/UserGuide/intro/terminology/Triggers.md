# Triggers

## 一般触发方式
BKCI 支持多种方式触发流水线：

- API 触发
- 代码库事件触发
- 子流水线调用插件触发
- 定时触发
- 手动触发
- 远程触发

不同的触发方式下，系统内置的 BK_CI_START_TYPE 取值也不同，你可以根据需要在流水线后续插件中使用该值：

触发方式 | BK_CI_START_TYPE 值
--- | ---
远程触发|REMOTE
手动触发|MANUAL
定时触发|TIME_TRIGGER
子流水线插件触发|PIPELINE
代码库 HOOK 触发|WEB_HOOK
API 触发|SERVICE

![Triggers](../../assets/triggers_1.png)

## github事件触发

如果您需要GitHub事件触发，您需要在部署BKCI时额外申请一个[GitHub APP](https://docs.github.com/en/developers/apps/getting-started-with-apps/about-apps)。

```text
需要将如下相应变量，填充到bkenv.properties 配置文件中， 再重新render_tpl生成配置文件
```

[![image](https://user-images.githubusercontent.com/16686129/99356538-47abdf00-28e5-11eb-9c25-bc000ff719da.png)](https://user-images.githubusercontent.com/16686129/99356538-47abdf00-28e5-11eb-9c25-bc000ff719da.png)  
[![image](https://user-images.githubusercontent.com/16686129/99356232-cce2c400-28e4-11eb-88bf-44e60505abbd.png)](https://user-images.githubusercontent.com/16686129/99356232-cce2c400-28e4-11eb-88bf-44e60505abbd.png)


