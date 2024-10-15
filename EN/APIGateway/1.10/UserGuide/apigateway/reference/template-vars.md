# Resource template variables

## Use template variables

The "Path" in the gateway resource "Backend Configuration" supports the use of template variables.

When the gateway requests the backend interface, it will replace the variables in the backend configuration Path and then make the request.

### Template variable source

- **Path variable:** The `{var_name}` contained in the gateway resource "Front-end Configuration" and "Request Path" is the path variable. You can use `{var_name}` in the "Back-end Configuration" "Path" to obtain this variable
- **Environment variable:** It is an environment variable defined in the gateway environment. When using it, add the unified prefix env and obtain the variable content through `{env.var_name}`

### Usage examples

#### Path variable example

In the gateway resource backend configuration Path, use the front-end configuration to request part of the data in the path. You can use path variables to achieve this, such as:

The front-end configuration request path is:/get/tasks/{task_id}/

The backend configuration Path is defined as: /get/tasks/{task_id}/, using the path variable {task_id}

Then when requesting /get/tasks/12345/, the backend interface address actually requested by the gateway is /get/tasks/12345/, and {task_id} in the backend configuration Path is replaced with the corresponding value in the request path.

#### Gateway environment variable example

In the gateway resource backend configuration Path, different gateway environments have different subpaths, which can be implemented using gateway environment variables, such as:

Define variables in the gateway environment: subpath = bkapp-prod

The backend configuration Path is defined as: /{env.subpath}/get/tasks/12345/

Then the backend interface address actually requested by the gateway is /bkapp-prod/get/tasks/12345/, and {env.subpath} in the target address is replaced with the corresponding value in the gateway environment variable.