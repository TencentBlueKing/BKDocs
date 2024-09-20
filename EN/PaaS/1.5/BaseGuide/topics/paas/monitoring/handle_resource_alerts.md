# Handling Resource Usage Alerts

## When Memory Alerts Occur

If the memory of your BlueKing application is insufficient, you can start with the following steps.

### Attempt to Solve the Problem Through Horizontal Scaling

The so-called "horizontal scaling" refers to increasing the load capacity of processes by adding more instances. The platform has already granted developers this capability. The operation entry points are:

- For cloud-native applications: 'Deploy' - 'Show Instance Details' - Scaling
- For regular applications: 'APP Engine' - 'Processes' - Scaling

Horizontal scaling is suitable for situations where OOM (Out of Memory) occurs due to an increase in the number of tasks.

For example, when `celery worker` accumulates messages due to too many tasks and you want to solve the problem by increasing the number of workers, the platform **strongly recommends** considering horizontal scaling first—i.e., increasing the number of celery process instances. This is because directly modifying the startup command to increase `--concurrency` can easily lead to OOM.

However, if the cause of OOM is that a single task or request consumes too much memory, such as reading some oversized files, then vertical scaling is necessary. In this case, please contact BlueKing Assistant for assistance.

### For Processes Started with Gunicorn

When the application process is started with gunicorn, you can observe the application's memory resource curve. If the usage grows slowly and eventually exceeds the limit, there is a high probability that there is a **memory leak in the code**.

You can avoid this problem by increasing the gunicorn startup parameters, similar to the following:

```bash
--max-requests 1024 --max-requests-jitter 50
```

For more details, refer to: [Gunicorn max-requests Parameter](https://docs.gunicorn.org/en/18.0/settings.html#max-requests)

## When CPU Alerts Occur

If your application's CPU is under high load, and the application itself does not perform "CPU-intensive" computations (most web applications are `IO-intensive`), then it is very likely that there is a problem like a "dead loop" occupying the CPU.

Blind scaling at this time will not solve the problem; you need to carefully investigate the "minefields" in the code to find the cause of CPU usage.

Conversely, if the application indeed requires more CPU computing resources, please contact BlueKing Assistant. The platform will form a dedicated group to assess resource usage to meet the application's needs.