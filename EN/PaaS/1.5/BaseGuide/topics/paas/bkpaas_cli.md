# bkpaas-cli

> bkpaas-cli is a command-line tool provided by the BlueKing Developer Center, supporting functions such as viewing basic application information, deployment, and querying deployment results.

## Usage Guide

### Configuration Information

bkpaas-cli stores API access paths, user authentication, and other information through a configuration file, which you can obtain a sample configuration for on the Developer Center.

By default, bkpaas-cli reads from `${HOME}/.blueking-paas/config.yaml` and loads it as the configuration. You can execute the following command to initialize:

```shell
>>> mkdir ${HOME}/.blueking-paas && cat > ${HOME}/.blueking-paas/config.yaml << EOF
paasApigwUrl: http://bkapi.example.com/api/bkpaas3/
paasUrl: http://bkpaas.example.com
checkTokenUrl: ''
username: ''
accessToken: ''
EOF
```

If you have special requirements, you can execute the following command, and bkpaas-cli will prioritize the file you specify as the configuration:

```shell
export BKPAAS_CLI_CONFIG='/root/.blueking-paas/config.yaml'
```

You can view the current loaded & used configuration content by executing the command `bkpaas-cli config view`:

```shell
>>> bkpaas-cli config view
configFilePath: /root/.blueking-paas/config.yaml

paasApigwUrl: http://bkapi.example.com/api/bkpaas3/
paasUrl: http://bkpaas.example.com
checkTokenUrl: ''
username: admin
accessToken: [REDACTED]
```

### User Login

Authentication of the user's developer identity is required to use this tool. If you are not authenticated or your authentication information has expired, you need to log in again to update your authentication information.

#### Interactive Login (Recommended)

bkpaas-cli provides interactive user login capabilities, and you need to execute the `bkpaas-cli login` command to log in.

```shell
>>> bkpaas-cli login
Now we will open your browser...
Please copy and paste the access_token from your browser.
>>> AccessToken: ********  # Copy and paste your AccessToken from the browser window that opens
User login... success!
```

Note: If you are using interactive login in an environment without a browser (such as a Linux development machine), the browser opening step will fail, but you can still manually open the browser to obtain the access_token.

```shell
>>> Now we will open your browser...
Please copy and paste the access_token from your browser.
Failed to open browser, error: exec: "xdg-open,x-www-browser,www-browser": executable file not found in $PATH
Dont worry, you can still manually open the browser to get the access_token: http://bkpaas.example.com/backend/api/accounts/oauth/token/
>>> AccessToken: ********  # Copy and paste your AccessToken from the manually opened browser window
User login... success!
```

For more login methods, please refer to the [bkpaas-cli Readme documentation](https://github.com/TencentBlueKing/blueking-paas/blob/main/bkpaas-cli/Readme.md#%E7%94%A8%E6%88%B7%E7%99%BB%E5%BD%95).

### BlueKing Application Management

bkpaas-cli can be used for scenarios such as information querying, deployment, and deployment status querying of BlueKing applications.

#### Listing Applications

You can execute the command `bkpaas-cli app list` to view the BlueKing applications you have operational permissions for:

```shell
>>> bkpaas-cli app list
Application List
+----+------------------+------------------+
| #  |      NAME        |       CODE       |
+----+------------------+------------------+
|  1 | demo-app-1       | app-code-1       |
|  2 | demo-app-2       | app-code-2       |
|  3 | demo-app-3       | app-code-3       |
+----+------------------+------------------+
```

#### Application Information Query

```shell
>>> bkpaas-cli app get-info --code=app-code-1
+---------------------------------------------------------------------------------------------+
|                              Application Basic Information                                  |
+------+--------------------------------------------------------------------------------------+
| Name | demo-app-1    | Code | app-code-1     | Region | default       | Type | default      |
+------+--------------------------------------------------------------------------------------+
|                                           Modules                                           |
+---------------------------------------------------------------------------------------------+
|   0   | Name     | frontend                                                                 |
+       +-------------------------------------------------------------------------------------+
|       | RepoType | GitHub       | RepoUrl | https://github.com/octocat/Hello-World.git      |
+       +-------------------------------------------------------------------------------------+
|       | Env      | prod         | Cluster | default -> BCS-K8S-12345                        |
+       +-------------------------------------------------------------------------------------+
|       | Env      | stag         | Cluster | default -> BCS-K8S-12345                        |
+---------------------------------------------------------------------------------------------+
|   1   | Name     | backend                                                                  |
+       +-------------------------------------------------------------------------------------+
|       | RepoType | GitHub       | RepoUrl | https://github.com/octocat/Hello-World.git      |
+       +-------------------------------------------------------------------------------------+
|       | Env      | prod         | Cluster | default -> BCS-K8S-12345                        |
+       +-------------------------------------------------------------------------------------+
|       | Env      | stag         | Cluster | default -> BCS-K8S-12345                        |
+---------------------------------------------------------------------------------------------+
```

#### Application Deployment

You can deploy regular or cloud-native applications by executing the command `bkpaas-cli app deploy`. Below are specific examples:

##### Cloud-Native Application

```shell
# First, you need to prepare a BkApp manifest, which can be obtained from the Cloud Native Application -> Application Orchestration -> YAML page
>>> cat > ./bkapp.yaml << EOF
apiVersion: paas.bk.tencent.com/v1alpha1
kind: BkApp
metadata:
  name: cnative-demo
spec:
  processes:
    - image: strm/helloworld-http
      imagePullPolicy: IfNotPresent
      cpu: 250m
      memory: 256Mi
      name: web
      replicas: 2
      targetPort: 80
EOF

# Execute the following command to deploy the cloud-native application
>>> bkpaas-cli app deploy --code=cnative-demo --env=stag -f ./bkapp.yaml
Application cnative-demo deploying...

# Poll to get the deployment result until deployment is successful/fails
# If you are not concerned about the deployment result, you can add the --no-watch parameter during deployment, and you can view the deployment result later through other commands
Waiting for deploy finished...
Waiting for deploy finished...
Waiting for deploy finished...

# If the deployment is successful, it will output the application status table, as well as the application access address and other information
# If the deployment fails, it will additionally output resource scheduling related events to help troubleshoot issues
Deploy Conditions: (Code: cnative-demo, Module: default, Env: stag)
+-------------------+--------+--------------+---------+
|       TYPE        | STATUS |    REASON    | MESSAGE |
+-------------------+--------+--------------+---------+
| AppAvailable      | True   | AppAvailable |         |
+-------------------+--------+--------------+---------+
| AppProgressing    | True   | NewRevision  |         |
+-------------------+--------+--------------+---------+
| AddOnsProvisioned | True   | Provisioned  |         |
+-------------------+--------+--------------+---------+
| HooksFinished     | True   | Finished     |         |
+-------------------+--------+--------------+---------+
Deploy successful.

↗ SaaS Home Page: https://stag-dot-cnative-demo.bkapps.example.com/

↗ Open developer center for more details: https://bkpaas.example.com/developer-center/apps/cnative-demo/default/status
```

##### Regular Application

```shell
# Note: If you need to deploy a non-default module, you can add the parameter --module=${module_name} during deployment
>>> bkpaas-cli app deploy --code=demo-app --env=stag --branch master
Application demo-app deploying...
Waiting for deploy finished...
Waiting for deploy finished...
Waiting for deploy finished...
Logs:
Preparing to build bkapp-demo-app-stag
Starting build app: bkapp-demo-app-stag
...

Generated build id: ec09dff9-a8a6-a990-6648-4489dff8866
building process finished.

Deploy successful.

↗ Open developer center for more details: https://bkpaas.example.com/developer-center/apps/demo-app/default/deploy/stag
```

#### Querying Deployment Results

You can query the **most recent** deployment result by executing the command `bkpaas-cli app deploy-result`. Below are specific examples:

##### Cloud-Native Application

```shell
>>> bkpaas-cli app deploy-result --code=cnative-demo --env=stag
Deploy Conditions: (Code: cnative-demo, Module: default, Env: stag)
+-------------------+--------+--------------+---------+
|       TYPE        | STATUS |    REASON    | MESSAGE |
+-------------------+--------+--------------+---------+
| AppAvailable      | True   | AppAvailable |         |
+-------------------+--------+--------------+---------+
| AppProgressing    | True   | NewRevision  |         |
+-------------------+--------+--------------+---------+
| AddOnsProvisioned | True   | Provisioned  |         |
+-------------------+--------+--------------+---------+
| HooksFinished     | True   | Finished     |         |
+-------------------+--------+--------------+---------+
Deploy successful.

↗ SaaS Home Page: https://stag-dot-cnative-demo.bkapps.example.com/

↗ Open developer center for more details: https://bkpaas.example.com/developer-center/apps/cnative-demo/default/status
```

##### Regular Application

```shell
# Successful case
>>> bkpaas-cli app deploy-result --code=demo-app --env=stag
Logs:
Preparing to build bkapp-demo-app-stag ...
Starting build app: bkpy-