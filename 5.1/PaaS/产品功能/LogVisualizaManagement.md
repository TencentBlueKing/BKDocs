### 日志可视化管理 {#LogVisualizaManagement}

蓝鲸 PaaS 平台提供在线日志服务，开发者可以在服务—>日志查询菜单中查看应用全方位日志信息，包括：普通日志/组件调用/uWSGI/Celery/Nginx/Gunicorn，也可以通过环境，日志级别和时间过滤查看。

![](../assets/image032.png)

(1)uWSGI/Nginx/Gunicorn 为系统日志，部署时平台负责将日志输出到固定目录，开发者不能定义内容。

(2)普通/组件调用/Celery 为开发框架中定义的 logger 输出的日志，开发者可以自定义内容。

日志产生后，由采集 Agent 进程采集，解析，汇总入日志查询引擎，在“开发者中心”提供的应用“服务”中可以查询到。

![](../assets/image033.png)

(3)时间：默认最近1小时，可选最近 1 小时/12 小时/1 天/7 天/14 天，支持自定义时间段，最长可以查 30 天内日志。

(4)环境： 默认全部，可选测试环境/正式环境。

(5)类型：默认普通日志，可选普通/组件调用/uWSGI/Celery/Nginx/Gunicorn。

(6)日志级别: 普通/组件调用/Celery 均有五个级别的日志标示，分别是 DEBUG、INFO、WARNNING、ERROR、CRITICAL；uWSGI/Nginx/Guniorn为HTTP 状态码。

(7)信息：可输入关键字进行查找。

>注：从日志产生到可查的时间间隔：5s 左右。
