## Use template variables

The "Path" in the "Backend Configuration" of the gateway resource supports the use of template variables.
When the gateway requests the backend interface, it will replace the variables in the backend configuration Path and then make the request.

### Template variable source

- **Path variable:** The `{var_name}` contained in the `Request Path` of the gateway resource `Front-end configuration` is the path variable. The `{var_name}` can be used in the `Path` of the `Back-end configuration` to obtain the variable

- **Environment variable:** The environment variable defined in the gateway environment. When using it, add the unified prefix env and obtain the variable content through `{env.var_name}`

### Usage example

#### Path variable example

In the gateway resource back-end configuration Path, use part of the data in the front-end configuration request path. You can use path variables to implement it, for example:

- The front-end configuration request path is: `/get/tasks/{task_id}/`
- The back-end configuration Path is defined as: `/get/tasks/{task_id}/`, using the path variable `{task_id}`

When requesting `/get/tasks/12345/`, the back-end interface address actually requested by the gateway is `/get/tasks/12345/`, `{task_id}` in the backend configuration Path is replaced with the corresponding value in the request path

#### Gateway environment variable example

In the gateway resource backend configuration Path, different gateway environment subpaths are different, which can be implemented using gateway environment variables, for example:

- Define variables in the gateway environment: `subpath = bkapp-prod`
- Backend configuration Path is defined as: `/{env.subpath}/get/tasks/12345/`

The backend interface address actually requested by the gateway is `/bkapp-prod/get/tasks/12345/`, and `{env.subpath}` in the target address is replaced with the corresponding value in the gateway environment variable