# Upgrading django-celery to Avoid Reconnection Risks

## Background

First, please check if your application meets the following conditions:

- Uses django-celery. Note that it must be django-celery, not just celery.
- Uses the beat process to execute scheduled or periodic tasks.
- The version of django-celery is less than `3.2.1`.

If your application does not meet any of the above conditions, congratulations, your application does not have a reconnection risk, and you can skip the rest of the article.
On the contrary, if all conditions are met, please pay attention to the following content.

Older versions of the django-celery module do not support a reconnection mechanism. Therefore, once there is a normal service switch in the backend DB, it will cause the application layer to become unavailable. This is specifically manifested in the celery logs with content similar to the following:

```bash
OperationalError(2006, 'MySQL server has gone away')
```

## Solution

Most applications created using the development framework do not have a reconnection risk by default. However, if you have manually switched to an older version of django-celery, or if you have migrated from PaaS2.0, then you need to take some actions to avoid the reconnection risk.

First, you need to modify `requirements.txt`:

```bash
django-celery>=3.2.1
celery>=3.1.15,<4.0
```

Then, due to the version change, there will be a useless DB change. You need to modify the migrate script in `bin/post_compile` to ignore this DB change:

```bash
python manage.py migrate --fake djcelery 0001_initial
```

Afterwards, commit and deploy, ensuring from the deployment logs that the new version of django-celery has been successfully installed. Finally, before the next deployment, remember to promptly delete the content after `migrate` in `bin/post_compile`.