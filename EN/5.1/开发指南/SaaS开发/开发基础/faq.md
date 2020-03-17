# Development framework2.0 faq.

1. Q: How to adjust python version to use python2.x version？

   - A：Since python2 is about to stop maintenance, we strongly recommend using the version of python3.x. If you have to use it, just delete the `runtime.txt` file in the root path of the project, and then downgrade the running environment to python2.7.9.

2. Q: In which file is the configuration information of saas filled in？

   - A：Fill in app information and paas platform information in `config/__init__.py` file

3. Q: How to use the mako engine to render files？

   - A：For the sake of security and community ecology, it is recommended to replace the Mako template with django template. If necessary, refer to [the development framework 2.0 use notes-using templates](./framework2.md#使用模板).

     > **Development framework 1.0 switch tips**：
     >
     > Development framework 2.0 no longer provides built-in rendering methods, but needs to change to django's built-in rendering methods，for example
     > ```python
     > # Framework 1.0 code.
     > from common.mymako import render_json, render_mako
     >
     > # Framework 2.0 code.
     > from django.shortcut import render   # Corresponding render_mako using
     > from django.http import JsonResponse # Corresponding render_json using
     > ```

4. Q: How to print logs？

   - A：For log printing, the development framework uses the log printing method recommended by django. For details, please refer to [the development framework 2.0 instructions - log usage](./framework2.md#日志使用).

     > **Development framework 1.0 switch tips**：
     >
     > The development framework 2.0 no longer provides the built-in log handle, which needs to be obtained through the logging module，for example：
     >
     > ```python
     > # Framework 1.0 code
     > from common.log import logger
     > logger.info ('log something')
     >
     > # Framework 2.0 code
     > import logging
     > logger = logging.getLogger ('app')
     > logger.info ('log something')
     > ```

5. Q: Why are exceptions not printed out？

   - A：In order to avoid the stack information leakage caused by the exception not captured, the development framework provides a middleware for unified exception handling. All kinds of exceptions will be converted into standard JSON format and returned to the client, and the exception information will be printed in the log. For extended use, please refer to [development framework 2.0 instructions - exception types](./framework2.md#异常类型介绍).
