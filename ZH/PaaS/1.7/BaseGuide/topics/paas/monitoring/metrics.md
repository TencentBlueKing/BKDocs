### Metric 上报指引

Metric 提供实时数据指标的监控功能。通过收集关键性能指标，如响应时间、请求数量和错误率，以帮助开发者掌握应用的健康状况。为了让指标数据更加的直观，开发者中心内置了开发框架仪表盘。

## 1. Metric 上报

蓝鲸开发框架已支持 Metric 采集上报功能，应用部署成功后会自动下发 Metric 采集的 ServiceMonitor。

### 1.1 Python 开发框架

#### 代码添加相关配置

1.在 `requirements.txt` 中添加依赖：

```python
# blueapps==4.15.1
blueapps[opentelemetry]==4.15.1
```

**说明**：blueapps 4.15.1 以上的包才能支持 Metrics 上报功能。

2.在 `config/default.py` 中添加如下内容：

```python
INSTALLED_APPS += (
    ...
    "blueapps.opentelemetry.instrument_app",
)

ENABLE_OTEL_METRICS = True
```

非开发框架也可以参考官方文档：

- [django-prometheus quick start](https://github.com/korfuri/django-prometheus#quickstart)
- [Prometheus Python Client](https://github.com/prometheus/client_python)

#### 应用描述文件添加配置

在应用描述文件中添加 Metric 相关配置，平台将在应用部署时自动下发 ServiceMonitor，并将指标上报至蓝鲸监控的应用命名空间。

1.**云原生应用**

云原生应用必须使用 `specVersion: 3` 的[应用描述文件](../app_desc_cnative)才能支持 Metric 采集配置。如描述文件为 `spec_version: 2`，需参考以下示例转换为最新版本：

- web 进程启动命令添加: `--env prometheus_multiproc_dir=/tmp/`

- web 进程中添加 metrics 端口映射

```yaml
services:
  - name: metrics
    targetPort: 5001
    port: 5001
```

- 添加可观测性配置

```yaml
observability:
  monitoring:
    metrics:
      - process: web
        serviceName: metrics
        path: /metrics/
```

完整示例文件如下：

```yaml
specVersion: 3
module:
  language: Python
  spec:
    processes:
      - name: web
        procCommand: gunicorn wsgi -w 4 -b [::]:5000 --access-logfile - --error-logfile - --access-logformat '[%(h)s] %({request_id}i)s %(u)s %(t)s "%(r)s" %(s)s %(D)s %(b)s "%(f)s" "%(a)s"' --env prometheus_multiproc_dir=/tmp/
        services:
          - name: web
            exposedType:
              name: bk/http
            targetPort: 5000
            port: 80
          # 给 metrics 采集使用的端口
          - name: metrics
            targetPort: 5001
            port: 5001
    hooks:
      preRelease:
        procCommand: "python manage.py migrate --no-input"
    observability:
      monitoring:
        # metrics 采集配置，注意 serviceName 要与 processes 中定义的保持一致
        metrics:
          - process: web
            serviceName: metrics
            path: /metrics/
```

**说明**：gunicorn 多个 worker（-w 4：代表起了 4 个 worker），需要配置 `--env prometheus_multiproc_dir=/tmp/` 参数。

2.**普通应用**

普通应用尚未支持 Metric 采集等可观测性功能，请先将应用迁移为云原生应用。

### 1.2 Go 开发框架

Go 开发框架已内置 Metric 采集功能，应用部署时，平台会自动下发 ServiceMonitor，并将指标上报至蓝鲸监控的应用命名空间。

非开发框架可参考：

- 官方 SDK: [Prometheus Go client library](https://github.com/prometheus/client_golang)
- 官方文档: [INSTRUMENTING A GO APPLICATION FOR PROMETHEUS](https://prometheus.io/docs/guides/go-application/)

### 1.3 蓝鲸应用插件（标准运维插件）

Python 版本的最新插件已内置 Metric 采集功能，部分老插件可以按照以下步骤开启：

1.在 `requirements.txt` 中添加依赖

```
bk-plugin-framework==2.2.8
# opentelemetry
celery-prometheus-exporter==1.7.0
```

**注意**: bk-plugin-framework 的版本必须为 `2.2.8` 以上才能支持 Metric 采集。

2.在 `app_desc.yaml`文件中

- 添加环境变量: `ENABLE_METRICS=1`

```yaml
configuration:
  env:
    - name: ENABLE_METRICS
      value: 1
      description: enable metrics
```

- web 进程启动命令添加: `--env prometheus_multiproc_dir=/tmp/`

- web、schedule、beat 进程中添加 `metrics` 端口映射

```yaml
services:
  - name: metrics
    targetPort: 5001
    port: 5001
```

- 添加 c-monitor 进程

```yaml
- name: c-monitor
  procCommand: celery-prometheus-exporter --broker amqp://$RABBITMQ_USER:$RABBITMQ_PASSWORD@$RABBITMQ_HOST:$RABBITMQ_PORT/$RABBITMQ_VHOST --addr 0.0.0.0:5001 --queue-list plugin_schedule plugin_callback schedule_delete
  services:
    - name: metrics
      targetPort: 5001
      port: 5001
```

- 添加可观测性配置

```yaml
observability:
  monitoring:
    metrics:
      - process: web
        serviceName: metrics
        path: /metrics/
      - process: c-monitor
        serviceName: metrics
        path: /metrics/
      - process: beat
        serviceName: metrics
        path: /metrics/
      - process: schedule
        serviceName: metrics
        path: /metrics/
```

**说明**：

- 应用描述文件的版本必须为 `specVersion: 3`，并且只对云原生应用生效。具体代码修改可[参考示例](https://git.woa.com/blueking-plugins/saas/plugin-metric/-/merge_requests/1)。
- Go 语言的标准运维插件尚未支持 Metric 采集功能。

## 镜像应用

通过镜像部署的应用，可直接在页面（模块配置 -> 进程配置）中完成 Metric 采集配置。

## 仪表盘

应用部署成功后，开发者中心会在蓝鲸监控下的蓝鲸应用命名空间中自动创建相应语言的内置仪表盘。云原生应用可以在 “可观测性 -> 仪表盘” 页面查看平台内置的仪表盘，并可以跳转到蓝鲸监控新增新的仪表盘。
