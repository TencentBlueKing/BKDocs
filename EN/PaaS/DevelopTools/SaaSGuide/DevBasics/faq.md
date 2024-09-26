# Development Framework 2.0 FAQ

1. Q: In which file should the SaaS configuration information be filled?

- A: Fill in the APP information and PaaS platform information in the `config/__init__.py` file.

2. Q: How to print logs?

- A: For log printing, the development framework uses the log printing method recommended by Django. For details, please refer to the [Development Framework 2.0 Instructions-Log Usage](./framework2.md#Log Usage) section.

> **Development Framework 1.0 Switch Tip**:
>
> Development Framework 2.0 no longer provides built-in log handles, which need to be obtained through the logging module, for example:
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

3. Q: Why are the exceptions not printed out?

- A: In order to avoid the leakage of stack information caused by uncaught exceptions, the development framework provides a unified exception handling middleware. All kinds of exceptions will be uniformly converted to standard JSON format and returned to the client, and the exception information will be printed in the log. If you need to expand the use, please refer to [Development Framework 2.0 Instructions-Exception Type Introduction)](./framework2.md#Exception Type Introduction) for details.