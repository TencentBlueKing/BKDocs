# 增强服务：RabbitMQ

## 实例使用指南

### 作为 celery 后端队列服务使用

RabbitMQ 服务最常见的用法是作为 celery 服务的后端消息队列使用，你可以使用下面的代码片段来获取已申请的实例信息：

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

> 帮助：蓝鲸开发框架已实现自动探测是否将当前 RabbitMQ 实例配置为 celery 队列，你无需手动配置。