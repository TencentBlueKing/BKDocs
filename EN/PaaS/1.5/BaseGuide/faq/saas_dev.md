# SaaS Development Related

### Practice of Frontend and Backend Separation Development Based on BlueKing SaaS Development Framework

[How to Conduct Frontend and Backend Separation Development](../topics/paas/multi_modules/separate_front_end_dev.md)

### How to Obtain the Client's IP Address within the Application

Before a request reaches the application, it passes through multiple layers of load balancing services. If the application directly takes the request IP as the client IP, there is usually a problem because this IP is the load balancer's IP, not the real client's IP. To obtain the real IP, you need to parse the `X-Forwarded-For` field in the request header information.

The `X-Forwarded-For` header contains a list of IP addresses connected by commas, such as `8.8.8.8,4,4,4,4`. The first `8.8.8.8` is the client's IP.

Below is a code example in the Django framework for obtaining the client's IP:

```python
def get_client_ip(request):
    """Get real client IP address from request
    """
    # Try "x-forwarded-for" header
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        return x_forwarded_for.split(',')[0].strip()
    return request.META.get('REMOTE_ADDR')
```

### How `django` Compresses Data Requested Through an Interface with `gzip`

1. Add the `django.middleware.gzip.GZipMiddleware` middleware.
2. Add `from django.views.decorators.gzip import gzip_page` in the view file.
3. Apply the `@gzip_page` decorator to the view function, and the returned data will be compressed.

### Local Access to Frontend, Django Template Syntax `{{ SITE_URL }}` Not Working

Check if there is a definition of `SITE_URL='xxx'` in the local environment's dev.py file. If not, please add the `SITE_URL='xxx'` variable to the local environment's dev.py file.