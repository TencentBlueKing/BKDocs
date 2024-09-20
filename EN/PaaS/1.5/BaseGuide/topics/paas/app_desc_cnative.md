## Application Description File (Cloud Native)

Just like regular applications, developers can use `app_desc.yaml` to describe cloud-native applications. The `specVersion: 3` version is the latest specification designed by the platform, and its configuration fields are closer to the cloud-native application model (BkApp), with camelCase naming conventions.

> Although cloud-native applications are backward compatible with the `spec_version: 2` version, they cannot fully utilize cloud-native features, so it is recommended that developers use `specVersion: 3`. S-mart applications must configure the `app_desc.yaml` file.

## Configuration Example

The `app_desc.yaml` configuration example is as follows:

```yml
specVersion: 3
appVersion: "1.0.0"
app:
  region: default
  bkAppCode: "op-tool"
  bkAppName: 运维小工具
  market:
    category: 运维工具
    introduction: Application Introduction
    description: Application Description
    displayOptions:
      width: 800
      height: 600
modules:
  - name: api
    isDefault: true
    sourceDir: src/backend
    language: Python
    spec:
      processes:
        - name: web
          procCommand: python manage.py runserver
          replicas: 2
          resQuotaPlan: 4C1G
      configuration:
        env:
          - name: FOO
            value: value_of_foo
            description: Environment Variable Description File
      hooks:
        preRelease:
          procCommand: python manage.py migrate --no-input
      addons:
        - name: mysql
        - name: rabbitmq
      svcDiscovery:
        bkSaaS:
          - bkAppCode: bk-iam
          - bkAppCode: bk-user
            moduleName: api
      envOverlay: ...
```

## Basic Configuration

### specVersion

(Optional, integer) Configuration file version, optional values:

- `3`: Current version

### appVersion

`appVersion` represents the [Semantic Version](https://semver.org/) of the current application, which will be displayed synchronously on the application's "Source Package Management" page.

## Application Configuration (app)

This part of the configuration is mainly used to describe the application, with the field name `app`. It only applies to S-mart applications; for non-S-mart applications, the information on the product page prevails.

### S-mart Specific Fields

The `region`, `bkAppCode`, and `bkAppName` fields are only valid for S-mart applications. Other types of applications will ignore these fields during configuration parsing. The value of `region` is: `default`.

### Market Configuration (market)

Describes the attributes of the application in the BlueKing Application Market:

- `introduction`: (Required, string) Application Introduction
- `introductionEn`: (Optional, string) English Introduction. If not set, the default is the application introduction
- `description`: (Optional, string) Application Description
- `descriptionEn`: (Optional, string) English Description
- `category`: (Optional, string) Application Category
- `displayOptions`: (Optional, object) Display options, see description

`displayOptions` field description, optional fields:

- `width`: (Optional, integer) Window width (pixels)
- `height`: (Optional, integer) Window height (pixels)
- `isMaximized`: (Optional, boolean) Whether to maximize display, default value False
- `visible`: (Optional, boolean) Whether to display on the desktop, default value True
- `openMode`: (Optional, string) Open mode from the desktop, default value: "desktop", optional values "desktop" (open from desktop), "new_tab" (open from a new tab)

## Module Configuration (modules)

The `modules` field is a configuration field that describes the application modules, with an array structure:

- `name`: (Required, string) Module name. Composed of lowercase letters, numbers, and hyphens (-), not exceeding 16 characters
- `isDefault`: (Optional, boolean) Whether it is the default module, default value False. Note that an application has only one default module
- `language`: (Required, string) The main development language of the module, optional values `Python`, `NodeJS`, `Go`. The platform will bind the default build tool based on this field
- `sourceDir`: (Optional, string) Source code directory, containing all necessary code, such as pre-compile and post-compile commands can only operate on files under the deployment directory, if not filled, the default is the root directory
- `spec`: (Required, object) Module specification. Among them, `processes` define process information (required), `configuration` define environment variables (optional), `hooks` define hook commands (optional), `addons` define dependent enhanced services (optional), `svcDiscovery` define SaaS service discovery (optional), `envOverlay` redefine configuration by environment (optional)

### Process Information (spec.processes)

The process information definition field, with an array structure:

- `name`: (Required, string) Process name. A string composed of lowercase letters and numbers
- `procCommand`: (Required, string) Script command to start the process
- `replicas`: (Optional, integer) Number of process replicas. Default is 1, the maximum value supported by the current version is 5
- `resQuotaPlan`: (Optional, string) Resource quota plan. Optional values `default`, `4C1G`, `4C2G`, `4C4G`, default value is `default`
- `probes`: (Optional, object) Probes

Example configuration of the `probes` field:

```yml
probes:
  liveness:
    httpGet:
      port: 5000
      path: "/"
    initialDelaySeconds: 30
    timeoutSeconds: 10
    periodSeconds: 10
    successThreshold: 1
    failureThreshold: 3
  readiness:
    tcpSocket:
      port: 5000
  startup:
    exec:
      command:
        - "/bin/bash"
        - "-c"
        - "echo ready"
```

- `liveness/readiness/startup`: Respectively represent the liveness, readiness, and startup probes, which can coexist
- `httpGet/tcpSocketTCP/exec`: Respectively represent different probe configurations, mutually exclusive
- `httpGet`: HTTP probe configuration
  - `port`: Detection port
  - `path`: Request path
- `tcpSocketTCP`: TCP probe configuration
  - `port`: Detection port
- `exec`: Command probe configuration
  - `command`: Command line array
- `initialDelaySeconds`: (Optional, integer) Waiting time after container startup. Default 0 s
- `timeoutSeconds`: (Optional, integer) Probe execution timeout. Default 1 s
- `periodSeconds`: (Optional, integer) Probe execution interval. Default 10 s
- `successThreshold`: (Optional, integer) After several consecutive successful detections, the container is considered healthy. Default 1 time
- `failureThreshold`: (Optional, integer) After several consecutive failures, the container is considered unhealthy. Default 3 times

### Environment Variables (spec.configuration)

The environment variable definition field `spec.configuration.env`, with an array structure:

- `name`: (Required, string) Environment variable name, longer than 1 character, starting with an uppercase letter, composed of uppercase characters (A-Z), numbers (0-9), and underscores (_), cannot start with system reserved prefixes, cannot use system reserved names
- `value`: (Required, string) Environment variable value

**Special Note**:

- System reserved environment variable prefixes: `IEOD_`, `BKPAAS_`, `KUBERNETES_`
- System reserved environment variable names (partial): `SLUG_URL`, `HOME`, `S3CMD_CONF`, `HOSTNAME`

> The environment variables defined in the `spec.configuration.env` field will take effect in all deployment environments of SaaS. If you want to set environment variables for a specific environment, you can use the `envOverlay.envVaribles` field introduced later.

### Hook Commands (spec.hooks)

The hook command definition field allows developers to complete specified operations at certain specific stages of the application lifecycle. The BlueKing SaaS model currently only supports one type of hook command: `spec.hooks.preRelease`

- `procCommand`: (Required, string) Script command

### Enhanced Services (spec.addons)

The enhanced service definition field, with an array structure. BlueKing SaaS applications can selectively enable enhanced services according to their own needs.

- `name`: (Required, string) Enhanced service name
- `specs`: (Optional, array object) Enhanced service specification configuration. If not set, the recommended configuration will be used for resource allocation
  - `name`: (Required, string) Specification name. Such as version
  - `value`: (Required, string) Specification value. Such as 5.7
- `sharedFromModule`: (Optional, string) Application module name. After setting, the enhanced service corresponding to the module will be shared, mutually exclusive with `specs`

Currently, both `name` and `specs` must be valid values provided by the platform, otherwise binding or allocation will fail.

### Service Discovery (spec.svcDiscovery)

The SaaS service discovery definition field `spec.svcDiscovery.bkSaaS`, with an array structure:

- `bkAppCode`: (Required, string) BlueKing application code
- `moduleName`: (Optional, string) Application module name, if not set, it means "main module" (module with `isDefault` as True)

> If you only need to obtain the main access address of the application and do not care about specific modules, it is recommended not to specify the `moduleName` field.

After the application is deployed, the corresponding access address can be read through the environment variable named `BKPAAS_SERVICE_ADDRESSES_BKSAAS`, and the value is a base64-encoded Json object, so it needs to be decoded when reading. The decoded structure is as follows:

```json
[
  {
    // key - used to match SaaS information key
    "key": { "bk_app_code": "bk-iam", "module_name": null },
    // Access information, stag represents the staging environment, prod represents the production environment
    "value": {
      "stag": "http://stag-dot-bk-iam.example.com",
      "prod": "http://bk-iam.example.com"
    }
  },
  {
    "key": { "bk_app_code": "bk-user", "module_name": "api" },
    "value": {
      "stag": "http://stag-dot-api-dot-bk-user.example.com",
      "prod": "http://prod-dot-api-dot-bk-user.example.com"
    }
  }
]
```

### Environment-Specific Overrides (spec.envOverlay)

Each BlueKing SaaS has two different deployment environments: staging (stag) and production (prod). If you need to make some differentiated settings for a specific environment, you can use the `spec.envOverlay` field. Currently supports three fields: `replicas`, `envVaribles`, `resQuotas`

`spec.envOverlay.replicas` is mainly used to set the number of replicas of the process in a specific environment. Usually, the staging environment is configured with fewer replicas to reduce resource usage, as shown below:

```yml
spec:
  envOverlay:
    replicas:
      - envName: stag
        process: web
        count: 1
```

Field description:

- `envName`: (Required, string) Effective environment name. Optional values: `stag` / `prod`
- `process`: (Required, string) Process name
- `count`: (Required, integer) Number of replicas

`spec.envOverlay.envVaribles` mainly defines those environment variables that only take effect in a specific environment. Array type, with a higher priority than the `configuration.env` field. Example:

```yml
spec:
  envOverlay:
    envVariables:
      - envName: stag
        name: ENV_ONLY_FOR_STAG
        value: foo
```

Field description:

- `envName`: (Required, string) Effective environment name. Optional values: `stag` / `prod`
- `name`: (Required, string) Environment variable name
- `value`: (Required, string) Environment variable value

`spec.envOverlay.resQuotas` is mainly used to set the resource quota plan for the process in a specific environment. Array type, example:

```yml
spec:
  envOverlay:
    resQuotas:
      - envName: stag
        process: web
        plan: 4C2G
```

Field description:

- `envName`: (Required, string) Effective environment name. Optional values: `stag` / `prod`
- `process`: (Required, string) Process name
- `plan`: (Required, string) Resource package name. Optional values `default`, `4C1G`, `4C2G`, `4C4G`

**Appendix: How to Get and Parse the Value of `BKPAAS_SERVICE_ADDRESSES_BKSAAS` with Python**

```python
# Only applicable to Python3
>>> import json
>>> import base64
>>> import os
>>> value = os.environ['BKPAAS_SERVICE_ADDRESSES_BKSAAS']
>>> decoded_value = json.loads(base64.b64decode(value).decode('utf-8'))
>>> decoded_value
[...]
```

Shortcut usage: If you have not defined any `moduleName`, and you only need the address of the main module of the application. Then you can use the following code to build a dictionary based on the result list, and use it to quickly get the formal environment access address of the main module of the application.

```python
>>> prod_only_addr = {item['key']['bk_app_code']: item['value']['prod'] for item in decoded_value}
>>> prod_only_addr
{'bk-user': ..., 'bk-iam': ...}
```