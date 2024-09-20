# Online Application Related Issues

### Why is my application particularly slow?

There are many reasons why an application's response is slow, with the most common being insufficient resources for the application's web processes. If you are using a Python application, you can refer to the following materials:

[How to Improve Gunicorn Process Performance in Python Applications](../topics/tricks/py_how_to_improve_gunicorn_perf.md)

It is also recommended that developers enable the APM Add-ons service, which can clearly observe the request chain latency and more accurately pinpoint the problem.

### "WORKER TIMEOUT" appears in the Gunicorn worker logs

The main reason for this issue is that Gunicorn workers handle IO operations such as DB connections or accessing third-party APIs in a synchronous manner. If there is IO blocking without a response, the worker will also be blocked. The following steps need to be taken to resolve this issue:

1. Investigate the request for potential blocking logic, remove the blocking logic, or try to move the blocking logic to be completed in the background by Celery.
2. If the blocking logic cannot be optimized in a short time, consider using the gevent module to allow Gunicorn to handle requests asynchronously. For details, please read

[How to Improve Gunicorn Process Performance in Python Applications](../topics/tricks/py_how_to_improve_gunicorn_perf.md)

### Mixed Content error when introducing HTTP resources in an HTTPS webpage?

When dynamically introducing HTTP resources in an HTTPS page, such as including a JS file, it will be directly blocked. Making an AJAX request for HTTP resources in an HTTPS page will also be directly blocked.

Adding `<meta http-equiv="Content-Security-PPolicy" content="upgrade-insecure-requests">` to the page will automatically upgrade insecure HTTP requests to HTTPS.

### What should I do if the Celery worker process keeps getting killed by the kill -9 signal and background tasks are not executed?

Reference: [Fixing Celery Worker OOM](../topics/tricks/fix_celery_worker_oom.md)

### What should I do if the application request times out with an error status code 502?

The access chain of a BlueKing application can be briefly described by the following diagram: Browser -> Application Routing Layer (nginx) -> app web server (gunicorn, etc.). A response status code of 502 usually indicates that the application routing layer cannot get a normal response from the backend web server.

There are many reasons for this phenomenon, with the most common being **the request processing time is too long, exceeding the threshold set by the web server itself and being forcibly interrupted, ultimately resulting in nginx not getting a normal response**.

Therefore, the recommended approach to solving this problem is to optimize application performance, fundamentally improve processing efficiency, and avoid excessively long processing times for individual requests.

In addition, you can increase the timeout setting of the web server itself so that the request will not be actively disconnected. However, it should be understood that too many slow requests may also lead to excessive resource consumption, ultimately making the service unavailable.

Reference: [How to Adjust Gunicorn Request Timeout](../topics/tricks/py_how_to_improve_gunicorn_perf.md)

If increasing the timeout does not solve the problem, then other reasons need to be considered. For example, whether the request occupies too much memory, causing OOM and leading to the request being forcibly ended, etc.