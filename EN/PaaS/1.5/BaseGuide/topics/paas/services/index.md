# Introduction to Enhanced Services

## What are Enhanced Services?

If you are developing applications on the BlueKing Developer Center, in addition to the most basic deployment hosting, your application usually requires services such as MySQL databases, Redis storage, etc.

The platform provides a wide range of such services, collectively referred to as "Enhanced Services."

## How to Use Enhanced Services

On the application page --> application configuration --> module configuration --> Enhanced Services feature page, you can view various different enhanced services. Click the "Enable Service" button to apply for a set of enhanced service instances for the current application module.

A complete set of enhanced service instances consists of two instances: "Staging Env" and "Production Env."

**Except for a very few enhanced services, the service instance is not directly created after clicking "Start Service." You need to deploy the application once in the corresponding deployment environment, and then the platform will create the real service instance for it.**

Applications can use the applied service instances in the following ways.

### 1. Access through Environment Variables in Application Code

A normal service instance usually provides some "configuration information," which is closely related to the use of the service, such as MySQL service instances providing host, username, password, etc.
You can hard-code these configuration items directly into your code to use them, but we recommend obtaining these configurations through environment variables.

Taking Python code as an example:

```python
import os

# Get the password for the MYSQL service instance
os.environ.get('MYSQL_PASSWORD')
```

> Note: Some particularly sensitive fields (such as MySQL instance passwords) cannot be viewed directly on the page. You must obtain their values by getting environment variables in the code.

### 2. Use the Management Entrance to Operate Instances

Some enhanced services provide a simple management entrance for instances. You can perform some simple operations by clicking the "Management Entrance" link, such as viewing object storage service usage, self-service scaling, etc.