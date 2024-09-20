# Fix for Celery Worker OOM

Generally, there are two scenarios that lead to Celery OOM (Out of Memory), and this article will guide users to perform appropriate parameter tuning.

## Too Many Processes

By default, Celery uses a process pool model, and the number of processes is the same as the number of CPU cores on the machine. However, in containers, the number of CPU cores refers to those of the host machine. Without limitation, this can lead to the container's overall memory exceeding its limit and causing OOM. Therefore, it is necessary to specify the number of processes in the corresponding worker startup command:

```bash
celery worker -c 2 ...
```

[Detailed Description](https://docs.celeryproject.org/en/v4.1.0/reference/celery.bin.worker.html#cmdoption-celery-worker-c)

On PaaS, you can freely set the number of container instances, so it is not recommended to use the process model. Instead, you can choose the gevent or eventlet model (you need to specify the corresponding dependencies in requirements.txt):

```bash
celery worker -P gevent ...
```

[Detailed Description](https://docs.celeryproject.org/en/v4.1.0/reference/celery.bin.worker.html#cmdoption-celery-worker-p)

For applications using the BlueKing development framework, you can specify this by setting the environment variable `CELERYD_CONCURRENCY`.

## Memory Leak

In some cases, there may be issues with the program logic that cause the memory of a single process to continuously increase, eventually leading to OOM. In addition to fixing the program logic, you can pre-set some defensive configurations to release memory by restarting the worker. The following configurations are version-dependent, so choose the appropriate version's configuration.

- Set the maximum number of tasks a single worker can execute:
  - Version 3.1: [CELERYD_MAX_TASKS_PER_CHILD](https://docs.celeryproject.org/en/3.1/configuration.html#celeryd-max-tasks-per-child)
  - Version 4.0+: [worker_max_tasks_per_child](https://docs.celeryproject.org/en/v4.1.0/userguide/configuration.html#worker-max-tasks-per-child)
- Set the maximum memory for a single worker:
  - Version 3.1 does not support;
  - Version 4.0+: [worker_max_memory_per_child](http://docs.celeryproject.org/en/latest/userguide/configuration.html#worker-max-memory-per-child)