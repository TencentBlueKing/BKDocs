# Deploy FAQ 

 ## Q: Why is it prompted that there is no permission to obtain the application cluster information? 

 When initializing the cluster, you need to enter the https certificate information of the cluster, which includes a Kubernetes user. You must ensure that this user has the `cluster-admin' role. If not, you can add it manually. 

 ``` bash 
 #Take the user kube-apiserver as an example 
 kubectl create clusterrole binding apiserver --clusterrole=cluster-admin --user kube-apiserver 
 ``` 

 ## Q: Is there any problem with mixed deployment of application cluster and platform cluster? 

 Namespace conflicts need to be avoided. By default, the platform will create different namespaces (namespaces) for different applications in the application cluster. Therefore, you must avoid using namespaces starting with `bkapp` when deploying the platform service. 

 ## Q: How do I add additional NodeJS SDK to bkrepo? 

 In general, NodeJS SDKs often have complex dependencies. As you need to append additional NodeJS SDKs to bkrepo, you need to will OTHER SDKs that the SDK depends on to bkrepo. 
 For this purpose, the platform provides the NodeJS dependency management tool bk-npm-mgr.  The tool is included in the paas3-npm-mgr image and can also be downloaded and installed directly from bkrepo (Run on node >= 12). 
 Here's how to use the bk-npm-mgr tool to upload additional NodeJS SDKs to bkrepo.

 ```bash 
 # Execute the following operations on a machine that can access the external network
 # 1. Start Up Container 
 docker run -it --rm --entrypoint=bash ${your-docker-registry}/paas3-npm-mgr:${image-tag} 
 # 2. install need to upload of additional NodeJS SDK to install. Take vue for an example. 
 yarn add vue@3.0.11 
 # 3. download dependencies to the dependencies directory (when executing step 2, a package.json file will be generated) 
 bk-npm-mgr download package.json -d dependencies 
 # 4. Upload the NodeJS SDK in the dependencies directory to bkrepo
 bk-npm-mgr upload --username ${bkrepoConfig.bkpaas3Username} --password ${bkrepoConfig.bkpaas3Password} --registry ${bkrepoConfig.endpoint}/npm/${bkrepoConfig.bkpaas3Project}/npm -s dependencies -v 

 #Such as you need to upload of SDK to bkrepo,  you need to mount the source code into the container, you can refer to the following process. 
 # 1. Start Up the container and will source code to the startup directory. 
 docker run -it --rm --entrypoint=bash -v ${absolute path of NodeSDK source}:/blueking ${your-docker-registry}/paas3-npm-mgr:${image-tag} 
 # 2. download dependencies to dependencies directory 
 bk-npm-mgr download package.json -d dependencies 
 # 3. Package SDK to dependencies 
 yarn pack -f dependencies/${your-sdk-name.tgz} 
 # 4. upload the NodeJS SDK in the dependencies directory to bkrepo 
 bk-npm-mgr upload --username ${bkrepoConfig.bkpaas3Username} --password ${bkrepoConfig.bkpaas3Password} --registry ${bkrepoConfig.endpoint}/npm/${bkrepoConfig.bkpaas3Project}/npm -s dependencies -v 
 ``` 

 **Description**: The value of the bkrepo related var can be retrieved from the `global.bkrepoConfig` configItem in the `values.yaml` custom_file. 

 ## Q: Why is there no data in application log collection?

 There are three main types of Application Log Collections: 

 - Application customize custom_file log 
 - Application Container Stdout 
 - Application Access Log via Ingress Controller 

 Index is automatically created by ElasticSearch for log collections. The last two items are shared by default for `bk_paas3_app`, and `bk_paas3_ingress` is used independently for Ingress. 
 Theoretically, there are several scenarios in which log collections may be abnormal: 

 ### The log collection components (filebeat & logstash) failed to start abnormally. 

 In this case, you can get the cause of the exception from their log output, and most problems can be found in the Internet community through search engines.

 ### The log Collections Components is normal. The existing BlueKing APP has been successfully deployed 

 Theoretically, if your App has been Success Deploy, there will be container stdout in most cases, and `bk_paas3_app` will be created automatically. 

 If there is no corresponding index in ES, there may be the following reasons: 

 - The ES is being set.  Please look at the container output of filebeat and logstash to see if have `ERROR` log to help determine if the ES information is filling in correctly. 
 - `containersLogPath` is not set correctly. signIn to the Filebeat container, authorize `kubectl`, and check if there is a container stdout log under the `containersLogPath` path. 
 - Application does not produce a log that meets the specifications.  In some special cases, the Application container does not produce stdout. You can try to restart the application container to generate a log that meets the specifications for further observation.