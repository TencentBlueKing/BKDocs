# Add-ons: MySQL

## Instance Usage Guide

### BlueKing Development Framework / Django

First, you need to obtain the MySQL-related information from the environment variables and add it to the Django configuration file:

```python
import os

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.environ.get('MYSQL_NAME'),
        'USER': os.environ.get('MYSQL_USER'),
        'PASSWORD': os.environ.get('MYSQL_PASSWORD'),
        'HOST': os.environ.get('MYSQL_HOST'),
        'PORT': os.environ.get('MYSQL_PORT'),
    }
}
```

**Note**: The `blueapps` module in the BlueKing development framework already integrates the above retrieval method by default. If you are already using it, there is no need to manually modify it.

### Node.js

First, you need to obtain the MySQL-related information from the environment variables and add it to the Node.js configuration file:

```
const config = {
    database: process.env.MYSQL_NAME,
    username: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    host: process.env.MYSQL_HOST,
    port: process.env.MYSQL_PORT
}
```

**Note**: The configuration in `server/conf/db.js` of the BlueKing frontend development framework already integrates the above retrieval method by default. If you are already using it, there is no need to manually modify it.