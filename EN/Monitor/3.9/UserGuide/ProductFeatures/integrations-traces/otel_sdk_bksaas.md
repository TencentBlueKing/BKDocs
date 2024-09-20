# Opentelemetry SDK (BlueKing SaaS Framework) Instructions for Use


## background

In order to better implement application monitoring of BlueKing SaaS applications, it is currently supported to access the application monitoring service of BlueKing Monitoring through simple service application and configuration based on the BlueKing SaaS development framework. In this way, the call chain monitoring of SaaS applications can be realized to better ensure the normal operation of SaaS applications, and at the same time, more convenient troubleshooting methods can be provided when troubleshooting problems.

This article is based on a new development framework template and the practical process of accessing application monitoring services.

## Depend on SDK instructions

1. Warehouse

    [Development framework internal warehouse]()
    [Third-party SDK dependency list]()
   
2. Environment dependency description
   
    Python >= 3.6
    BlueKing PaaS Platform

## Use Cases

Case[code repository]()

### Data Burial Point

#### Development framework template preparation

1. Apply for app_code on PaaS, download the latest development framework template, and unzip it.

2. Run the development framework locally according to [BlueKing Development Framework Beginner’s Guide]().

#### Application monitoring service application

1. Go to the monitoring SaaS that already supports application monitoring services, select [Observation Scenario] - [Application Monitoring] - [New Application], fill in the corresponding app_code and SaaS basic information according to the prompts, and complete the application monitoring application.


2. After the application is completed, click the [Configure] button on the right to obtain the corresponding basic information. It is necessary to focus on recording the token and url information used in the report.
 
    The development framework integrates the exporter of grpc. Please select the push url of grpc.

#### Development framework configuration and data preparation

1. Modify the dependency version of blueapps in requirements.txt:
   
    ```
    blueapps[opentelemetry]==4.4.5
    ```
   
2. Add: INSTALLED_APPS in the config/default.py file:
   
    ```python
    INSTALLED_APPS += (
        ...,
        "blueapps.opentelemetry.instrument_app",
    )
   
    ENABLE_OTEL_TRACE = True
   
    BK_APP_OTEL_INSTRUMENT_DB_API = True # Whether to enable DB access trace (the number of spans will increase significantly after enabling it)
    ```
   
3. In order to verify the reporting effect, our operations in the project are as follows:
    - Write the corresponding log in the project entrance view:
   
    ```python
    # home_application/views.py
    import logging
   
    logger = logging.getLogger("root")
   
    def home(request):
        """
        front page
        """
        logger.info("A log in home view")
        return render(request, 'home_application/index_home.html')
    ```
   
    - Add periodic tasks and log regularly
      Turn on celery configuration switch
     
      ```python
      #config/default.py
     
      IS_USE_CELERY = True
      ```
     
      Add corresponding process
     
      ```yaml
      #app_desc.yaml
      spec_version: 2
      module:
        language: Python
        scripts:
          pre_release_hook: "python manage.py migrate --no-input"
        processes:
          web:
            command: gunicorn wsgi -w 4 -b :$PORT --access-logfile - --error-logfile - --access-logformat '[%(h)s] %({request_id}i)s %(u)s %(t)s "%(r)s" %(s)s %(D)s %(b)s "%(f)s" "%(a)s"'
          beat:
            command: python manage.py celery beat -l info
          worker:
            command: python manage.py celery worker -l info
      ```
     
      Added home_application/tasks.py file:
     
      ```python
      # home_application/tasks.py
      # -*- coding: utf-8 -*-
     
      import logging
     
      from celery.schedules import crontab
      from celery.task import periodic_task
     
      logger = logging.getLogger("root")
     
      @periodic_task(run_every=crontab())
      def periodic_log_task():
          logger.info("this is a log from periodic_task")
      ```

At this point, the access and modification of the development framework is completed, and the code can be submitted.

### Deployment environment variable configuration

In the PaaS platform that goes to the cloud, some pre-environment variables need to be configured before deployment, and the token and URL we used to monitor the application were used.

On the SaaS application page corresponding to the PaaS Developer Center, select [Application Engine] - [Environment Configuration] and configure the corresponding environment variables:

| Variable name | Variable value | Description |
| -------------------------- | -------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| PIP_VERSION | 21.1.3 | PaaS environment requirements |
| CXX | g++ | PaaS environment requirements |
| ENABLE_OTEL_TRACE | True | Turn on Trace, development framework requirements |
| BKAPP_OTEL_SAMPLER | parentbased_always_on | Configure the sampling strategy, the values are always_on, always_off, parentbased_always_on, parentbased_always_off, traceidratio, parentbased_traceidratio |
| BKAPP_OTEL_BK_DATA_TOKEN | {Token applied for in monitoring} | Monitoring reporting configuration items |
| BKAPP_OTEL_GRPC_HOST | {grpc push url obtained during monitoring} | Monitoring reporting configuration items |

After configuring the environment variables, click Deploy.

### Observation data

After successful deployment, visit the SaaS homepage, or after a period of time, you can see that the [Log Query] of PaaS also has corresponding log records, such as:
![](media/16613345448122.jpg)

The development framework has integrated the Trace-id field record in the log, so click on the corresponding log details and you can see the trace-id of the corresponding log:

![](media/16613345567735.jpg)


Because there will be some delay in data collection and display (about 10 minutes), in order to verify that our logs have been successfully reported, you can go to [Data Retrieval] - [Trace Retrieval] in the monitoring and enter the traceID obtained from the PaaS log. You can see that there are The corresponding trace information indicates that the log has been successfully reported.

![](media/16613345682526.jpg)


Finally, after the project has been running for a certain period of time, we can see the corresponding result display in the monitoring [Application Monitoring] panel:

![](media/16613345761089.jpg)


### Reporting Instructions

The development framework has already helped developers with integration and basic configuration for Trace scenarios, creating an out-of-the-box experience as much as possible. Therefore, the configuration and details related to reporting can be obtained through the source code of the development framework.

The specific reported configuration can be found in [link](../scene-apm/apm_monitor_overview.md).


### Frequently Asked Questions

1. Before deploying SaaS to the PaaS online environment, you need to configure PIP_VERSION and CXX, the two environment variables required by PaaS, otherwise the deployment may fail.

2. The default sampling configuration of the development framework is parentbased_always_off. If you only have a single system and want to verify quickly, you need to adjust the configuration to parentbased_always_on or always_on. In actual applications, please adjust the sampling configuration as needed.