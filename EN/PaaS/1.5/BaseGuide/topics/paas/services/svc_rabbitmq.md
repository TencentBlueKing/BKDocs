# Add-ons: RabbitMQ

## Instance Usage Guide

### Using as a Celery Backend Queue Service

The most common use of the RabbitMQ service is as a backend message queue for celery services.

If you are using the blueapps module in the BlueKing development framework, you only need to enable RabbitMQ to configure it automatically. If you are not using blueapps, you will need to configure the broker_url yourself.

```python
RABBITMQ_VHOST = os.getenv('RABBITMQ_VHOST')
RABBITMQ_PORT = os.getenv('RABBITMQ_PORT')
RABBITMQ_HOST = os.getenv('RABBITMQ_HOST')
RABBITMQ_USER = os.getenv('RABBITMQ_USER')
RABBITMQ_PASSWORD = os.getenv('RABBITMQ_PASSWORD')

# Set as celery backend message queue
BROKER_URL = 'amqp://{user}:{password}@{host}:{port}/{vhost}'.format(
        user=RABBITMQ_USER,
        password=RABBITMQ_PASSWORD,
        host=RABBITMQ_HOST,
        port=RABBITMQ_PORT,
        vhost=RABBITMQ_VHOST)
```