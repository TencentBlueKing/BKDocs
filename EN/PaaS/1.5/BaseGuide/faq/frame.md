# SaaS Development Framework Related

### How to determine which configuration file the development framework is currently loading? Can it be specified manually?

1. The three types of configuration files correspond to: `dev` for local development, `stag` for the staging environment, and `prod` for the production environment.
2. It cannot be specified manually, as the framework is hardcoded to load based on the runtime environment.

### How to confirm the current runtime environment of the framework

You can use the `RUN_MODE` variable, which is defined at the beginning of the `dev.py / stag.py / prod.py` files.

```python
from django.conf import settings
settings.RUN_MODE
```

### Where to add global configurations in the BlueKing framework?

Custom global configurations can be added in the `default.py` file under the `conf` directory.

### What to do if an error "Environment variable x not found" occurs during local development?

Such errors typically occur because the necessary environment variables are not configured in the development environment. For details, see [How to Configure Python Local Development Environment](../quickstart/python/python_setup_dev.md).

### What to do if the platform cannot find celery logs?

Add `CELERYD_HIJACK_ROOT_LOGGER = False` to the code settings.py configuration to fix this issue.