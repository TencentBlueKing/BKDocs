# 增强服务：RabbitMQ

## 实例使用指南

### 作为 celery 后端队列服务使用

RabbitMQ 服务最常见的用法是作为 celery 服务的后端消息队列使用。

如果你使用了蓝鲸开发框架中的 blueapps 模块，你只需启用 RabbitMQ 即可自动配置。如果你没有使用 blueapps，那么需要自己配置 broker_url。

```python
RABBITMQ_VHOST = os.getenv('RABBITMQ_VHOST')
RABBITMQ_PORT = os.getenv('RABBITMQ_PORT')
RABBITMQ_HOST = os.getenv('RABBITMQ_HOST')
RABBITMQ_USER = os.getenv('RABBITMQ_USER')
RABBITMQ_PASSWORD = os.getenv('RABBITMQ_PASSWORD')

# 设置为 celery 后端消息队列
BROKER_URL = 'amqp://{user}:{password}@{host}:{port}/{vhost}'.format(
        user=RABBITMQ_USER,
        password=RABBITMQ_PASSWORD,
        host=RABBITMQ_HOST,
        port=RABBITMQ_PORT,
        vhost=RABBITMQ_VHOST)
```
