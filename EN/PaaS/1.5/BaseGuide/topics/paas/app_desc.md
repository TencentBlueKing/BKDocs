## Application Description File

The `app_desc.yaml` is a configuration file used to describe BlueKing applications.

To use this feature, developers need to create a configuration file named `app_desc.yaml` in the root directory of the application and fill in the configuration information that meets the format requirements. Based on these configurations, developers can implement custom market configurations, add environment variables, and other functions.

> S-mart applications also use the `app_desc.yaml` file for description.

## Example Configuration

A standard example of the `app_desc.yaml` configuration file is as follows:

```yml
spec_version: 2
app_version: "1.0"
app:
  region: default
  bk_app_code: "foo-app"
  bk_app_name: Default App Name
  market:
    category: Operations Tools
    introduction: App Introduction
    description: App Description
    display_options:
      width: 800
      height: 600
modules:
  frontend:
    is_default: True
    source_dir: src/frontend
    language: Node.js
    services: # Enhanced service configuration is only effective for Smart apps
      - name: mysql
      - name: rabbitmq
    env_variables:
      - key: FOO
        value: value_of_foo
        description: Environment Variable Description File
    processes:
      web:
        command: npm run server
        plan: 4C1G5R
        replicas: 2 # The number of replicas cannot exceed the value defined in the plan
        probes:
          liveness:
            exec:
              command:
                - cat
          readiness:
            http_get:
              path: /healthz
              port: 80
    scripts:
      pre_release_hook: bin/pre-release.sh
    svc_discovery:
      bk_saas:
        - "bk-iam"
        - "bk-user"
```

Note:

- Information under `app` is only effective for Smart apps; for non-Smart apps, the information on the product page prevails.
- The default value for `app.region` is: default.
- Module name: Consists of lowercase letters, numbers, and hyphens (-), and must not exceed 16 characters.
- For ordinary applications that contain only one module, information related to modules can be placed directly at the top level, such as

```yml
spec_version: 2
app_version: "1.0"
app:
  region: default
  bk_app_code: "foo-app"
  bk_app_name: Default App Name
  market:
    category: Operations Tools
    introduction: App Introduction
    description: App Description
    display_options:
      width: 800
      height: 600
modules:
  frontend:
    is_default: True
    source_dir: src/frontend # If this item is not present, it defaults to the root directory
    language: Node.js
    services:
      - name: mysql
      - name: rabbitmq
    env_variables: # Environment variables defined in the yml file will not be displayed on the product page
      - key: FOO
        value: value_of_foo
        description: Environment Variable Description File
    processes:
      web:
        command: npm run server
        plan: 4C1G5R
        replicas: 2 # The number of replicas cannot exceed the value defined in the plan
    scripts:
      pre_release_hook: bin/pre-release.sh
    svc_discovery:
      bk_saas:
        - "bk-iam"
        - "bk-user"
```

## Field Description (Basic Configuration)

### spec_version

(Obligatory, integer) Configuration file version, optional values:

- `2`: Current version
- `1`: Old version S-mart app format, **deprecated, do not use**

### app_version

(Optional, string) Application version number, e.g., `1.0`. When the application source code is provided as a compressed package, this field must be provided. The value of `app_version` will be displayed as the application version on the "Source Code Package Management" page.

## Detailed Field Description (Application Section)

This part of the configuration is mainly used to describe the application, with the field name `app`.

The fields `region`, `bk_app_code`, and `bk_app_name` are only effective for S-mart applications. Other types of applications will ignore these fields during the configuration parsing phase.

The remaining fields are applicable to all types of applications.

> **Question: What does it mean that it is only effective for S-mart applications?**
>
> S-mart applications are a special type of application supported by the platform, which can only be created and updated by uploading an "S-mart compressed package."
>
> If a field is only effective for S-mart applications, it means that the platform will parse and use this field only when the user performs the following actions:
>
> - Upload an S-mart application package and create a new application
> - Enter an existing S-mart application and upload a new version of the compressed package

### S-mart Specific Fields

#### region

(Optional, string) The version code of the application. If not provided, the default available application version of the user creating the application through the compressed package will be used.

- Only effective for S-mart applications
- Cannot be modified after application creation

#### bk_app_code

(Optional, string) Application ID, consisting of lowercase letters, numbers, and hyphens (-), with the first letter being a letter, and the length less than **16**, and cannot be duplicated with other applications.

- Only effective for S-mart applications, must be provided at creation
- Cannot be modified after creation

#### bk_app_name

(Optional, string) Application name, consisting of Chinese characters, English letters, and numbers, with a length not exceeding **20**, and cannot be duplicated with other applications.

- Only effective for S-mart applications, must be provided at creation
- Cannot be modified after creation

### Market Configuration (market)

(Optional, mandatory for S-Mart applications, object) Describes the attributes of the application in the BlueKing application market.

- `category`: (Optional, string) Type of application, click to see all optional types (TODO)
- `introduction`: (Mandatory, string) Brief introduction of the application
- `description`: (Optional, string) Text description of the application
- `display_options`: (Optional, object) Display options, see description

Description of `display_options` fields, optional fields:

- `width`: (Optional, integer) Window width (pixels)
- `height`: (Optional, integer) Window height (pixels)
- `is_win_maximize`: (Optional, boolean) Whether to maximize display, default value False
- `visible`: (Optional, boolean) Whether to display on the desktop, default value True
- `open_mode`: (Optional, string) Open mode from the desktop, default value: "desktop", optional values "desktop" (open from desktop), "new_tab" (open in a new tab)

Example:

```yml
app:
    market:
        category: Operations Tools
        introduction: App Introduction
        description: App Description
        display_options:
            width: 800
            height: 600
            open_mode: desktop
            is_win_maximize: False
            visible: True
```

### Module Information

(Mandatory, dict) Describes the module information of the application, with the following format

- `is_default`: (Optional, bool) Whether it is the main module, default value is False, note that an application has **exactly one** main module
- `source_dir`: (Mandatory, string) Deployment directory, must contain all necessary code, for example, pre-compile and post-compile commands can only operate on files under the deployment directory, if not filled in, it defaults to the root directory
- `language`: (Mandatory, string, optional values: Python, Node.js, Go), the development language of the module, which will bind the default build tools to the module based on the development language
- `processes`: (Optional, dict) Process information

```yml
modules:
  frontend:
    is_default: True
    source_dir: src/frontend
    language: Node.js
  api_server:
    is_default: False
    source_dir: src/backend
    language: Python
    processes:
      web:
        command: npm run server
        plan: 4C1G5R
        replicas: 2 # The number of replicas cannot exceed the value defined in the plan
```

### Enhanced Services (services)

(Optional, array) Describes the **default module** required enhanced services for the application, which is an array containing multiple objects describing the enhanced services, with the following format:

- `name`: (Mandatory, string) Enhanced service name, optional values include: `mysql`, `redis`, `rabbitmq`, `bkrepo`
- `shared_from`: (Optional, string) The module name of the shared service instance

This field only supports appending. If the application deletes existing enhanced services when updating the configuration file, it will not have any impact.

**Note**: Enhanced service configuration is only effective for Smart applications
Example:

```yml
services:
  - name: mysql
    shared_from: default
  - name: redis
```

Currently, it is not possible to configure enhanced services for modules other than the default module through this field.

## Detailed Field Description (Deployment Section)

### Deployment Command (processes)

(Optional) Dictionary type, containing the process information of the application. Smart applications must fill this out, while ordinary applications do not need to fill it out and will use the Procfile instead. After defining the deployment command through the configuration file, the platform will start the process with the corresponding command during the deployment phase.
**Note**: If there is a Procfile in the application code, this configuration will not take effect.

- `command`: (string), the startup command for the deployment process, the process will start with this instruction.
- `plan`: (Optional, string), the resource quota for the process.
- `replicas`: (Optional, int) Number of process replicas, default value is 1, the number of replicas cannot exceed the value defined in the plan.
- `probes`: (Optional, dict) Process health probes.

Explanation: plan: (Optional) The type of resource allocation used by the application, which can be configured individually for each process name.
The specific meaning of the resource package is as follows:

```json
{
  "4C1G5R": {
    // Maximum number of replicas
    "max_replicas": 5,
    // Maximum resource limits
    "limits": { "cpu": "4096m", "memory": "1024Mi" },
    // Minimum resource requirements
    "requests": { "cpu": "100m", "memory": "64Mi" }
  },
  "4C2G5R": {
    // Maximum number of replicas
    "max_replicas": 5,
    // Maximum resource limits
    "limits": { "cpu": "4096m", "memory": "2048Mi" },
    // Minimum resource requirements
    "requests": { "cpu": "100m", "memory": "64Mi" }
  },
  "4C4G5R": {
    // Maximum number of replicas
    "max_replicas": 5,
    // Maximum resource limits
    "limits": { "cpu": "4096m", "memory": "4096Mi" },
    // Minimum resource requirements
    "requests": { "cpu": "100m", "memory": "64Mi" }
  }
}
```

Explanation: probes: (Optional) Application health probe configuration, configured individually for each process. Corresponding to k8s health probes, there are three types of probes: liveness, readiness, and startup. The specific probe parameters are as follows:

- `http_get`: HTTP GET request detection mechanism (Optional, dict)

  - `host`: The hostname used for the connection (Optional, string), defaults to the Pod's IP
  - `path`: Request path (Optional, string)
  - `port`: Request port number (Required, int)
  - `scheme`: Request method, defaults to "HTTP" (Optional, string)
  - `http_headers`: List of HTTP headers (Optional, list)
    - `name`: HTTP header domain name (Required, string)
    - `value`: HTTP header domain value (Required, string)

- `tcp_socket`: TCP request detection mechanism (Optional, dict)

  - `port`: Request port number (Required, int), can use placeholder ${PORT} to replace the container listening address configured by the platform
  - `host`: Request path (Optional, string)

- `exec`: Command line detection mechanism (Optional, dict)

  - `command`: List of commands to be executed (Optional, list)

- `initial_delay_seconds`: Time to wait after container startup, default is 0 seconds (Optional, int)
- `timeout_seconds`: Probe execution timeout, default is 1 second (Optional, int)
- `period_seconds`: Probe execution interval, default is 10 seconds (Optional, int)
- `success_threshold`: Number of consecutive successful detections after which the container is considered healthy, default is 1 (Optional, int)
- `failure_threshold`: Number of consecutive failed detections after which the container is considered unhealthy, default is 3 (Optional, int)

### Additional Scripts (scripts)

(Optional) Dictionary type, containing additional scripts that need to be executed during module build and deployment phases.

- `pre_release_hook`: (Optional, string), a hook script executed before deployment, e.g., performing a migrate operation before the release phase.

**Note**: The instructions for `pre_release_hook` have certain limitations, such as not starting with start, only being a single command, etc. For detailed information, please see [Deployment Pre-release Commands](./release_hooks.md)

Example:

```yaml
modules:
  api_server:
    is_default: True
    source_dir: src/backend
    language: Python
    processes:
      web:
        command: python manage.py runserver
        plan: 4C1G5R
        replicas: 2 # The number of replicas cannot exceed the value defined in the plan
    scripts:
      pre_release_hook: python manage.py migrate
```

### Environment Variables (env_variables)

(Optional) List type, containing the application environment variables. After defining the application environment variables through the configuration file, the application can read these environment variables through the system interface during the build phase and after deployment.

**Note**: Environment variables can also be defined on the product page, and if defined there, they will override the content defined in the app_desc.yaml file, please be aware.

- `key`: (string) Length greater than 1, starts with an uppercase letter, consists of uppercase letters (A-Z), numbers (0-9), and underscores (_), cannot start with a system reserved prefix, cannot use system reserved names
- `value`: (string) Environment variable value
- `description`: (Optional, string) Description of the environment variable
- `environment_name`: (Optional, string, optional values: stag, prod) The environment in which the environment variable takes effect, if not filled in, it defaults to all environments

System reserved environment variable prefixes:

- `IEOD_`
- `BKPAAS_`
- `KUBERNETES_`

System reserved environment variable names (partial):

- `SLUG_URL`
- `HOME`
- `S3CMD_CONF`
- `HOSTNAME`

Example:

```yml
env_variables:
  - key: FOO
    environment_name: stag
    value: value_of_foo
    description: Environment Variable Description File
```

### Process Resource Allocation (package_plans)

(Optional) The type of resource allocation used by the application, which can be configured individually for each process name. This field is of type `object`, where `key` is the process name to be configured, and `value` is the name of the resource package.

Example:

```yml
package_plans:
  web: Starter
```

Indicates that the `web` process will use a resource package named `Starter`.

### Service Discovery Configuration (svc_discovery)

(Optional) The service discovery related configuration of the application, developers can configure dependent services and other information through this field.

- `bk_saas`: (array[object]) Information about other BlueKing SaaS applications that the application depends on. After this item is configured, the platform will inject the access addresses of all SaaS in the list into the environment variables after the application is deployed.

For example, if the application uses the following configuration:

```yml
svc_discovery:
  bk_saаs:
    - bk_app_code: "bk-iam"
    - bk_app_code: "bk-user"
      module_name: "api"
```

The internal SaaS information in `bk_saas` includes the following fields:

- `bk_app_code`: (string) Represents the BlueKing SaaS application Code
- `module_name`: (string) Module name, optional. If not provided, it means using the application's "main module"

> Common Question: **What is the difference between not providing module_name and setting module_name to "default"?**
>
> If you want to get the access address of the "main module" of an application, there are two different configuration forms: not specifying the module_name field, and explicitly specifying module_name as "default" (the application's default "main module" name).
>
> These two forms seem the same, but the access addresses obtained will be different:
>
> - **Not specified**: The access address is a flexible short address, which always points to the current "main module" of the target application (although it defaults to "default", it may also be other modules), example address format: `http://example.com/app-code/` (production environment), which does not include the specific module name
> - **Explicitly specify default**: The access address is a complete address, which clearly points to the module named default, an example address is: `http://example.com/prod--default--app-code/` (production environment)
>
> If you only want to get the main access address of the application and do not care about specific modules, it is recommended not to specify the module_name field.

After the application is deployed, it can read the access addresses of the "main module" of `bk-iam` and the api module of the `bk-user` application through the environment variable named `BKPAAS_SERVICE_ADDRESSES_BKSAAS`.

The value of this environment variable is a base64-encoded Json object, with the object format as follows:

```json
[
  {
    // key - used to match SaaS information
    "key": { "bk_app_code": "bk-iam", "module_name": null },
    // Access information, stag represents the pre-release environment, prod represents the production environment
    "value": {
      "stag": "http://stag-dot-bk-iam.example.com",
      "prod": "http://bk-iam.example.com"
    }
  },
  {
    "key": { "bk_app_code": "bk-user