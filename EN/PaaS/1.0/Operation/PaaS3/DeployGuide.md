 # bkpaas3 Installation Guide 

 `bkpaas3` is the diagram package of the core function module of the PaaS3.0 Developer Center. This documentation is the deployment guide for the module. 

 ## summary 

 This diagram consists of the following module, each of which is responsible for of functions: 

 1. **apiServer** The master module of PaaS3.0 Developer Center, which provides API service and is responsible for interacting with Apply K8S cluster. 
    - web: service master process 
    - worker: background task process 
 2. **webfe**: The front-end of PaaS3.0 Developer Center, which hosts static page approve nginx 
 3. **extraInitial**: Platform function initialization module 
    - npm: Initialize NPM repository 
    - pypi: Initialize the pypi repository 
    - devops: Initialize the build tool 
 4. **svc-mysql**: MySQL database add-ons, responsible for creating and managing MySQL accounts and databases. 
 5. **svc-rabbitmq**: RabbitMQ add-ons, responsible for creating and managing rabbitmq account and vhosts. 
 6. **svc-bkrepo**：Bkrepo add-ons, responsible for creating and managing account and buckets of bkrepo binary repositories. 

 ## Preparing Service Dependency 

 Prior to deployment, prepare a Kubernetes cluster (version 1.12 or higher) and install the Helm command line tool (version 3.0 or higher). 

 Note: As you are using BCS Kubernetes Engine Deploy, you can use BCS graphical Helm feature instead of Helm command row. 

 We use `Ingress` to provide service access, please at least one available [Ingress Controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) cluster exist. 


 ### OTHER service 

 In order to run the Developer Center normally, in addition to preparing the core storage, you also need to use some OTHER service in the BlueKing system. They are yes: 

 * BlueKing Two Repository Service (bkrepo):Access Apply build source packages and application build tools. 
  + The required version Must for **1.0.11** and above 
  + Required: generic registry, npm registry, pypi registry 
 * BlueKing PaaS2.0: Read and manage application information 
  + Required version Must for **2.12.18** and above 
 * BlueKing SSM：Rely on its API interface to verify user information
 * BlueKing API Gateway: You need to register gateway resources to API Gateway for use by OTHER service. 

 In addition to the above service, there are several OTHER dependent services, such as not provided will not affect the main functions of the program: 

 * BlueKing Documentation Center: Used to display Developer Guides and User Guides 
  + Documentation Center SaaS (bk_docs_center): version 1.0.6 and higher 
  + Document Center Offline Documentation Package (docs-data):Version 1.0.7 and above 
  + Currently, PaaS3.0 documentation has not been placed on the BlueKing Official. If the document center is not deployed separately, SaaS cannot view documents.
 * BlueKing userManage (bk_user_manage): Rely on it to manage user information. 
 * BlueKing accessCenter (bk_iam):Depends on it to manage user authentication to the Developer Center 
 * BlueKing Process Service Management (bk_itsm):Rely on it for user authorization requests and approvals 

 Once you have the dependency service ready, the next yes is to write the `values.yaml` custom_file setting. 

 ## Prepare `values.yaml` 

 Developer Center cannot directly approve the default `values.yaml` provided by Chart. before executing `helm install` to install the service, you must press the step below to prepare `values.yaml` to match the current deployment environment. 

 ### 1. Setting Data Encryption secretKey 

 Bkpaas3 uses a symmetric encryption algorithm to secure data.  To enable encryption, you must first create a unique secretKey.  The secretKey content is for **Length 32 of string (base64 encoding)**. In Linux, you can run the following command to generate a random key: 

 ```bash 
 $ tr -dc A-Za-z0-9 </dev/urandom | head -c 32 | base64 
 ``` 

 Or use the Python command 

 ```bash 
 $ python -c 'import random, string, base64; s = "".join(random.choice(string.ascii_letters + string.digits) for _ in range(32)); print(base64.b64encode(s.encode()).decode())' 
 ``` 

 After obtaining the secretKey, the next step is to put it in the `global.bkKrillEncryptSecretKey` configItem. 

 Precautions: 

 * Once the secretKey is generated and set, it cannot be Modified, otherwise it will cause data abnormal; 
 * For the security of your data, please do not will secretKey to other people. 

 ##### `values.yaml` setting example 

 ```yaml 
 global: 
  bkKrillEncryptSecretKey: "b3BmRmpwYWNoZJ...  " 
 ``` 

 ### 2. Setting service dependencies in the BlueKing system 

 The following information must be set: 
 - bk_app_secret corresponding to `bk_paas3`, and add bk_paas3 to the whitelist of ESB free user authentication 
 - BlueKing root domain bkDomain 
 - Database `open_paas` information from BK-Panel 
 - The code list of the initialized third-party application (external link application)
 - Access address of other products in the BlueKing system

 ##### `values.yaml` setting example 

 ```yaml 
 global: 
  imageRegistry: "mirrors.example.com" 
  bkDomain: "example.com" 
  bkrepoConfig: 
    #Gateway address of the bkrepo service 
    endpoint: "http://bkrepo.example.com" 
  
  appCode: "bk_paas3" 
  appSecret: "" 
  bkComponentApiUrl: "http://bkapi.example.com" 
  bkApiUrlTmpl: "http://bkapi.example.com/api/{api_name}" 

 apiserver: 
  enabled: true 
  bkPaas3Url: "http://bkpaas.example.com" 
  bkPaasUrl: "http://paas.example.com" 
  bkCmdbUrl: "http://cmdb.example.com" 
  bkJobUrl: "http://job.example.com" 
  bkIamUrl: "http://bkiam.example.com" 
  bkIamApiUrl: "http://bkiam-api.example.com" 
  bkUserUrl: "http://bkuser.example.com" 
  bkBcsUrl: "http://bcs.example.com" 
  bkMonitorV3Url: "http://bkmonitor.example.com" 
  bkNodemanUrl: "http://bknodeman.example.com" 
  bkLogUrl: "http://bklog.example.com" 
  bkRepoUrl: "http://bkrepo.example.com" 
  bkCiUrl: "http://devops.example.com" 
  bkCodeccUrl: "http://devops.example.com/console/codelib" 
  bkTurboUrl: "http://devops.example.com/console/turbo" 
  bkPipelineUrl: "http://devops.example.com/console/pipeline" 
  #BlueKing documentation Center address, default for official website address, can be Modify to document center SaaS address (http://apps.example.com/bk--docs--center) 
  bkDocsCenterUrl: "https://bk.tencent.com/docs" 
  #The code of the initialized nth Apply (Ext-Link App), separated English commas 
  initThirdAppCodes: "bk_repo,bk_usermgr,bk_iam,bk_bcs,bk_log_search,bk_monitorv3,bk_ci,bk_nodeman" 

  externalDatabase: 
    openPaaS: 
      host: "bk-panel-mariadb" 
      password: "root" 
      port: 3306 
      user: "bk_panel" 
      name: "open_paas" 

 webfe: 
  enabled: true 
  bkApigwUrl: "http://apigw.example.com" 
  bkLessCodeUrl: "http://lesscode.example.com" 
  bkPaas3Url: "http://bkpaas.example.com" 
  bkPaasUrl: "http://paas.example.com" 
  bkLoginUrl: "http://example.com/login" 
  bkDocsCenterUrl: "https://bk.tencent.com/docs" 
 ``` 
 ### 3. Configure ElasticSearch Cluster information for Apply log 

 The ElasticSearch Cluster information needs to be consistent with the ElasticSearch information Fill In in the charts Deploy on the Apply cluster 

 ##### `values.yaml` setting example 

```yaml
apiserver:
  elasticSearch:
    host: "elasticsearch.example.com"
    port: "9200"
    auth: "username:password"
    appIndex: "bk_paas3_app"
    ingressIndex: "bk_paas3_ingress"
```

 ### 3. Configure ElasticSearch cluster information for application logs

 The ElasticSearch cluster information needs to be consistent with the ElasticSearch information filled in the charts deployed on the application cluster. 

 ##### `values.yaml` setting example 

 ```yaml 
 apiserver: 
  elasticSearch: 
    host: "elasticsearch.example.com" 
    Port: "9200" 
    auth: "username:password" 
    appIndex: "bk_paas3_app" 
    ingressIndex: "bk_paas3_ingress" 
 ``` 

 ### 4. Configure the initial application cluster

 In order for the application to be deployed normally, you must register at least one Kubernetes cluster in the platform.You need to configure an initial cluster in `apiserver.initialCluster`. 

 The platform manage the K8S cluster, including but not limited to: create or delete namespace, and create or delete BlueKing APP ( `Deployment` / `Service` / `Ingress`). 

 Therefore, relevant information of the corresponding cluster must be set, including 

 * apiserver access URL, access identity and `cluster-admin` auth 
 * Apply cluster access method and portal domain name 

 The following describes how to set the access identity of the apiserver and the `cluster-admin` auth. 

 > Note: If you are using a BCS cluster, it is recommended to refer to section 4.1, and normal clusters can refer to section 4.2. 

 #### 4.1 Accessing the Cluster Approve BCS API 

 You can access the cluster through bcs api and token

 ##### 4.1.1 Fill in the access URL of the reference cluster 

 Replace `apiServers.host` with the access URL of the bcs cluster apiserver, e.g. `https://bcs.example.com/clusters/${cluster_ID}`. 

 ##### 4.1.2 Getting the bcs API secretKey with cluster-admin auth 

 The PaaS can be configured to access the BCS cluster using a `platform-level token (recommended)` or `personal secretKey`. 

 **1. Apply a platform-level token**. 

 Contact your BCS administrator to assign a BCS token `client_ID for PaaSv3:bk_paas3`. 

 Note: The secretKey requires auth to bcs-cluster and bcs-project manager. 

 **2. apply personal secretKey**. 

 To apply and approve a personal key go to the BCS product home-> username (drop down menu)-> API secretKey. note:You must have all auth for the cluster you want to set. 
 ##### 4.1.3 Example `values.yaml` setting 

 ```yaml 
 apiserver: 
  initialCluster: 
    #If you want to install this setting directly, please change enabled:true 
    enabled: true 
    #Configure Cluster Network & Domains 
    ingressConfig: 
      sub_path_domain: "apps.example.com" 
      enable_https_by_default: false 
      #The IP of the cluster pre-proxy will be used to display the user's domain resolution setting. 
      #If not, you can temporarily fill in NodeIP exist Production Env 
      frontend_ingress_ip: "127.0.0.1" 
    #The value of the bcs API secretKey that will be used as the credential to access the bcs api. 
    tokenValue: "eyJhbGciOiJSUzI1NiIsImtp...  " 
    Notes: 
      #To use BCS Cluster, you must set the following annotation information      
      bcsClusterID: "BCS-K8S-00000 
      bcsProjectID: "037f75ec8771f011eb3f07a057784486" 
    apiServer: 
      - host: "https://bcs.example.com/clusters/BCS-K8S-00000" 
 ``` 

 #### 4.2 Directly Connecting Cluster ApiServers 

 ##### 4.2.1 Obtaining an ApiServer Access Certificate 

 1. BCS Cluster 

 If your application cluster is generated and managed by the BCS service, you can find the signed certificate in `/etc/kubernetes/ssl/` of the Master node. 

 `ca.pem`,`apiserver.pem` and `apiserver-key.pem` correspond to `caData`,`certData` and `keyData` in the initialization setting. The contents are `base64` encoded and filled into `values.yaml`. 

 2. Custom cluster 

 If your Apply cluster is hosted ** Approve BCS service instead of Generate **, you need to view the access certificate via `cat $HOME/.kube/config`, and will fill in and certificate content according to a previous section. 

 > Note: If you do not use the "client certificate" method for verification, you can leave the `certData` and `keyData` fields empty. 

 ##### 4.2.2 Selecting a Cluster Identity Verification Method 

 Currently, you can use two different check methods: `Client Certificate` or `BearerToken`. 

 ###### Client Certificate 

 As a complete identity check by using "client certificate", please set the field `certData` and `keyData`(both must be base64 encoded), and make sure that the identity issued by The certificate has the identity of `cluster-admin` exist the K8S RBAC auth system. Otherwise, you can use the following command to bind the manual. 

 ```bash 
 #Using the username kube-apiserver as an example 
 kubectl create clusterrolebinding apiserver --clusterrole=cluster-admin --user kube-apiserver 
 ``` 
###### Bearer Token

 To complete the identity check with `BearerToken`, you first need to get a valid token. The most common way to get a cluster token is to create a ServiceAccount with the role `cluster-admin` and use the account's token. 

 For example, the following YAML resources will create a ServiceAccount object named `admin-user` with the `cluster-admin` auth in the `kube-system` namespace of the cluster: 

 ```yaml 
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
 ``` 

 Then run the following command to get the token: 

 ```console 
 #Read the Secret where the token is located 
 TOKENNAME=`kubectl -n kube-system get serviceaccount/admin-user -o jsonpath='{.secrets[0].name}'`. 

 #Read and print token (base64 decoded) 
 $ kubectl -n kube-system get secret $TOKENNAME -o jsonpath='{.data.token}'| base64 --decode 
 eyJhbGciOiJSUzI1NiIsImtp... 
 ``` 

 Finally, the token is added to the `apiserver.initialCluster.tokenValue' configItem of the bkpaas3 module to complete the identity check configuration. 

 ##### 4.2.3 Filling in the Reference Cluster Access URL 

 `apiServers.host` is the access address of Kubernetes ApiServer, such as https://some-api-server-host:port. 

 You can refer to [Accessing a Cluster REST API](https://Kubernetes.io/docs/tasks/access-application-cluster/access-cluster/#directly-accessing-the-rest-api) to obtain the access address of the cluster.

 ##### 4.2.4 `values.yaml` Setting Example 

 ```yaml 
 apiserver: 
  initialCluster: 
    #If you want to set it directly in the install, please change enabled:true 
    enabled: true 
    #Cluster access entry configuration 
    ingressConfig: 
      sub_path_domain: "apps.example.com" 
      enable_https_by_default: false 
      #The IP of the cluster pre-proxy will be used to display the user's domain resolution setting. 
      #If not, you can temporarily fill in NodeIP exist Production Env 
      frontend_ingress_ip: "127.0.0.1" 
    caData: "LS0tLS1CRU...  " 
    tokenValue: "eyJhbGciOiJSUzI1NiIsImtp...  " 
    apiServers: 
      - host: "https://127.0.0.1:6553" 
 ``` 


 **Note**:  This configuration will only take effect when deploying for the first time (`helm install`). To continuously update the cluster configuration after the installation is complete,please manage via `${PAAS_DOMAIN}/backend/admin42/platform/clusters/manage/`. After changing the data, restart the `web` & `worker` process of the apiserver module. 

 After completing the above step and preparing `values.yaml`, you can continue with the `bkpaas3` installation. 

 ## Install Chart 

 After filling in Values.yaml, you must first append a valid Helm repo repository. 

 ```shell 
 #will be `<HELM_REPO_URL>' with the Helm repository address where this chart is located. 
 $ helm repo add bkee <HELM_REPO_URL>. 
 ``` 

 After the repository is added successfully, run the following command to install the Helm release for the `bkpaas3` existing cluster 

 ```shell 
 helm install bkpaas3 bkee/bkpaas3 --values value.yaml 
 ``` 

 The above command will deploy the BlueKing PaaS service to the existing Kubernetes cluster and output the access instructions. 

 ## Next step 


 To complete the installation, you need to execute the `kubectl run ...` command output in the helm notes command to deploy the application normally.

 This command will download the build tools provided by BlueKing and Runtime tools provided by heroku from Tencent Cloud Object Storage https://bkpaas-runtimes-1252002024.file.myqcloud.com, And upload it to the unified directory in the specified repository of bkreop


 ### Configuration System Add-ons 


 "Add-ons" is an extended function wait as MySQL database provided by PaaS for SaaS. You need to refer to the following step to complete the setting. 


 Step 1: Obtain the address of the "SaaS Accessible" service instance 


 Depending on the deployment conditions, the step operation have two ways. 


 If SaaS and platform clusters share the same Kubernetes cluster, you can directly get the service address of each service by running the `kubectl get svc` command (Note: Only support the same cluster). 


 If the SaaS and platform deployment exist different Kubernetes cluster, the above services will not work.  You can use the default install nodePort type service address: 
 * Run the command `kubectl get svc xxxx -o jsonpath='{.spec.ports[0].nodePort}'` on the platform cluster to get the NodePort of the service exposed by the add-ons. 
 * Assuming the port number is 32199 and the IP is 10.0.0.1, the service access URL is 10.0.0.1:32199. 
 * If rabbitmq, there are two ports to note, one is the AMQP port corresponding to 5672, and the other is the API port corresponding to 15672. 

 Step 2: Change the MySQL Add-ons setting 

 Modify the scheme configuration information of `default-mysql` on the PaaS3.0 Developer Center->Platform Management->Enhanced Service Management->Scheme Management (${bkPaas3Url}/backend/admin42/platform/clusters/manage/) page.
  
 Step 3: Modify RabbitMQ add-ons settings 

 First, you need to modify the relevant values setting of rabbitmq 

 ```yaml 
 svc-rabbitmq: 
  env: 
  #Default cluster address 
  - name: "RABBITMQ_DEFAULT_CLUSTER_HOST" 
    value: "10.0.0.1" 
  #Default cluster amqp port 
  - name: "RABBITMQ_DEFAULT_CLUSTER_AMQP_PORT 
    value: "32199" 
  #Default cluster API port 
  - name: "RABBITMQ_DEFAULT_CLUSTER_API_PORT 
    value: "32666" 
  #Default Cluster Administrator Username 
  - name: "RABBITMQ_DEFAULT_CLUSTER_ADMIN 
    value: "Please fill in the appropriate value from.values.rabbitmq.Auth.username" 
  #Default Cluster Administrator Username 
  - name: "RABBITMQ_DEFAULT_CLUSTER_PASSWORD" 
    value: "Please fill in the appropriate value of.Values.rabbitmq.Auth.username" 
 ``` 

 Then update `bkpaas3` Update `helm upgrade` again. 

 > Note: Add-ons such as MySQL and RabbitMQ are provided by this helm only for quick verification. There is no high availability setup. Please do not use them in production environments. 
 
 ## Uninstall Chart 

 Uninstall `bkpaas3` with the following command 

 ```bash 
 #uninstall resources 
 helm uninstall bkpaas3 

 #Installed built-in resources wait as mariadb & redis & rabbitmq will not be deleted to prevent data generated during enable persistence from being destroyed. 
 #After confirming that the content is no longer needed, you can run the following command to delete it manually 
 kubectl delete deploy,job,sts,cronjob,pod,svc,ingress,secret,cm,sa,role,rolebinding -l app.kubernetes.io/instance=bkpaas3 
 ``` 

 The above command will remove all Kubernetes resources associated with bkpaas3 and delete the share. 

 ## Configure the instance 

 ### 1. Customize image address 

 Every time a new version is released, we will update the mirror version in the Chart, so if you just want to use the latest version of the official image, you can skip this section

 If you want to use OTHER official version or image build by yourself, you can also modify them existing values.yaml. setting example: 

 ```yaml 
 global: 
  imageRegistry: "" 
  imagePullSecrets: [] 
 ``` 

 ### 2. Set BlueKing Dependency 

 When deploying the application, the PaaS will download some necessary tools from the BlueKing product repository, including application image, build packages, two source packages for different language, and so on.  Therefore, you need to access the bkrepo service as **Administrator** to upload these toolkits during the initial installation. 

 In addition, the PaaS relies on bkrepo for two other functions: 

 1. "BlueKing artifactory" add-ons for Platform Apply to upload and download custom_file by itself. 
 2. For "LessCode" storage apply source code package 

 To sum up, the complete bkrepo setting requires a total of four different account information. of which: 
 * Administrator account password: You can get the "initial username/password" from bkrepo's Helm NOTES. 
 * The OTHER three account Yes create on bkrepo exist Deploy apiServer. **NOTE: Currently, only the account password will be created, and the password will not be changed**. 

 ##### `values.yaml` setting example: 

 ```yaml 
 global: 
  bkrepoConfig: 
    #Gateway address of the bkrepo service 
    endpoint: http://bkrepo.example.com 
    # bkrepo Docker Registry Addr 
    dockerRegistryAddr: "docker.example.com:80" 
    #Administrator auth, Account password can be Get from bkrepo's Helm NOTES "initial username/password" 
    adminUsername: admin 
    adminPassword: blueking 

    # svc-bkrepo username/password used of bkrepo Add-ons project 
    #Must be the same and of value of `svc-bkrepo.plan.username` configItem Middle the Add-ons 
    addonsUsername: bksaas-addons 
    #Must be the same and of value of `svc-bkrepo.plan.password` Middle the Add-ons 
    addonsPassword: blueking 

    #The name of bkrepo project used by the platform (starting with a letter or an underscore length no longer than 32 digits) 
    bkpaas3Project: bkpaas 
    of bkrepo username/password used by the platform (any characters) 
    bkpaas3Username: bkpaas3 
    bkpaas3Password: blueking 
    of bkrepo username/password used by lesscode Add-ons project (any character is Fill In) 
    lesscodeUsername: bklesscode 
    lesscodePassword: blueking 
 ``` 

 ### 3. Initialize and setting the built-in Storages 

 By default, we provided One set of Storages for **Quick Feature Verification**, including `mariadb` and `redis`. You can see the specific setting exist `values.yaml` of `bkpaas3`: 

 ```yaml 
 mariadb: 
  enabled: true 
  commonAnnotations: 
    "helm.sh/hook": "pre-install" 
    "helm.sh/hook-weight": "-1" 
    "helm.sh/hook-delete-policy": hook-failed,before-hook-creation 
  architecture: standalone 
  auth: 
    rootPassword: "root" 
    username: "bkpaas" 
    password: "root" 
  primary: 
    #By default, we do not enable persistence. For Have information, please refer to: 
    # - https://kubernetes.io/docs/user-guide/persistent-volumes/ 
    # - https://github.com/bitnami/charts/blob/master/bitnami/mariadb/values.yaml#L360 
    persistence: 
      enabled: false 
  initdbScriptsConfigMap: "paas-mariadb-init" 

redis:
  enabled: true
  commonAnnotations:
    "helm.sh/hook": "pre-install"
    "helm.sh/hook-weight": "-1"
    "helm.sh/hook-delete-policy": hook-failed,before-hook-creation
  sentinel:
    enabled: true
  auth:
    password: ""
  master:
    persistence:
      enabled: false

rabbitmq:
  enabled: true
  auth:
    username: admin
    password: blueking
    erlangCookie: blueking
  service:
    type: NodePort
    port: 5672
    managerPort: 15672
  persistence:
    enabled: false
```
 We do not guarantee high availability of the storage, so it is **NOT RECOMMENDED** for use exist Production Env, please use a more reliable external Storages. 

 ### 5. BlueKing Log Collections 

 Used to add stdout log to the BlueKing log search.  It is not enabled by default. To enable it please set `bkLogConfig.enabled` to true. 

 ##### `values.yaml` setting example: 
 ```yaml 
 apiserver: 
  ##Configuring the BlueKing log collection 
  bkLogConfig: 
    enabled: false 
    dataId: 1 
 svc-bkrepo: 
  ##Configuring the BlueKing log collection 
  bkLogConfig: 
    enabled: false 
    dataId: 1 
 svc-rabbitmq: 
  ##Configuring the BlueKing log collection 
  bkLogConfig: 
    enabled: false 
    dataId: 1 
 svc-mysql: 
  ##Configuring the BlueKing log collection 
  bkLogConfig: 
    enabled: false 
    dataId: 1 
 ``` 

 ### 6. BlueKing Oauth Service

 After the Blueking 0auth service is enabled, the bk app secret information of the Blueking application will be managed by the bk-oauth service. and the bk app secret information and not be synchronized with the bk app_secret information in the open-paas database.
 ##### `values.yaml` setting example: 
 ```yaml 
 global: 
  ##BlueKing oauthCert service 
  bkAuth: 
    enabled: false 
 ``` 

 ### 7. Container Monitoring Service Monitor 

 It is not enabled by default. To enable it, please set `serviceMonitor.enabled` to true.  Currently only the apiserver module exposes metrics. 

 ##### `values.yaml` setting example: 
 ```yaml 
 apiserver: 
  serviceMonitor: 
    enabled: true 
 ``` 

 For more setting of the case, please refer to BlueKing Documentation Center> PaaS> Application Operation and Maintenance> PaaS3.0 Application Operation and Maintenance> Installation Guide. 

 # Release Specification 

 1. The versionNum of the page footer is represented by `Chart.AppVersion`. 
 - You must ensure that the AppVersion of the WebFe subchart is consistent and the outermost AppVersion. 

 2. [Requirements] The appVersion should be consistent with the project delivery git tag version. 
 - If have code changes, update the image tag and appVersion at the same time. 
 - If you only change the charts but not the image, you do not need to update appVersion. 