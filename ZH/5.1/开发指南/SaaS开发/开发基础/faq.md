# 开发框架 2.0 常见问题

1. Q: 如何调整 Python 版本使用 Python2.x 版本？

   - A：由于 Python2 即将停止维护，我们强烈的建议使用 Python3.x 的版本。如果必须使用，只需要将项目根路径下的 `runtime.txt` 文件删掉，即可将运行环境降级到 Python 2.7.9。

2. Q: SaaS 的配置信息在哪个文件填写？

   - A：`config/__init__.py` 文件中填写 APP 信息及 PaaS 平台信息。

3. Q: 如何使用 mako 引擎对文件进行渲染？

   - A：出于安全及社区生态考虑，开发框架推荐使用 Django 模板替换 mako 模板。如果必须使用，请参考 [开发框架 2.0 使用说明-使用模板](./framework2.md#使用模板) 章节。

     > **开发框架 1.0 切换提示**：
     >
     > 开发框架 2.0 不再提供内置的渲染方法，需要更改为 django 内置的渲染方式，例如
     > ```python
     > # 框架 1.0 代码
     > from common.mymako import render_json, render_mako
     >
     > # 框架 2.0 代码
     > from django.shortcut import render   # 对应 render_mako 使用
     > from django.http import JsonResponse # 对应 render_json 使用
     > ```

4. Q: 如何打印日志？

   - A：对于日志打印，开发框架使用 Django 推荐的日志打印方式，具体请参考 [开发框架 2.0 使用说明-日志使用](./framework2.md#日志使用) 章节。

     > **开发框架 1.0 切换提示**：
     >
     > 开发框架 2.0 不再提供内置的日志句柄，需要通过 logging 模块获取，例如：
     >
     > ```python
     > # 框架 1.0 代码
     > from common.log import logger
     > logger.info ('log something')
     >
     > # 框架 2.0 代码
     > import logging
     > logger = logging.getLogger ('app')
     > logger.info ('log something')
     > ```

5. Q: 为何异常都没有被打印出来？

   - A：为了避免异常未捕获，导致堆栈信息的泄露，开发框架提供了统一异常处理的中间件。各类异常都会被统一转换为标准的 JSON 格式返回给客户端，并将异常信息打印日志。如需扩展使用，具体请参阅 [开发框架 2.0 使用说明-异常类型介绍)](./framework2.md#异常类型介绍) 。
