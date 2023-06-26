# How to configure cluster initialization

## What is True Cluster Initialization?

The Developer Center provided initialization cluster setting so that you can quickly complete the cluster configuration exist the Deploy `values.yaml` when you install the cluster for the first time and speed up the verification flow. 
Therefore, please keep in mind that the setting will take effect only exist the initial deployment (`helm install`). To continuously update the cluster configuration after the installation is complete, please manage it by authorizing `${PAAS_DOMAIN}/backend/admin42/platform/clusters/manage/`. After changing the data restart the `web` & `worker` process of the apiserver module.

## What is a cluster configuration?

The platform manages the Kubernetes cluster, including but not limited to: create or delete namespace, and create or delete BlueKing APP (`Deployment`/`Service`/`Ingress`, etc). Therefore, relevant information of the corresponding cluster must be set, including:

- Kube-apiserver access URL
- kube-apiserver access identity and `cluster-admin` auth
- Application clusteraccess method and portal domain name

For more information about the access method and cluster pre-IP setting, see [Cluster Pre-IP Configuration](./configure_ingress_front_ip.md). The following describes how to set the access identity of kube-apiserver and the `cluster-admin` auth.

## Get ApiServer Access Certificate

## BCS Cluster

If your Application cluster Generate and Hosted Approve BCS service is true, you can find the issued certificate in `/etc/Kubernetes/ssl/` of the master node.

`ca.pem`, `apiserver.pem`, and `apiserver-key.pem` correspond to `caData`, `certData`, and `keyData` in the initialization setting. The contents are `base64` encoded and filled into `values.yaml`.
### Custom Cluster

If your Application cluster is hosted **Approve BCS service instead of Generate**, you need to view the access certificate via `cat $HOME/.kube/config`, and will fill in and certificate content according to a previous section.

> Since you are not using the client certificate method for verification, you can leave the `certData` and `keyData` fields empty. See the "Selecting a Cluster Identity Verification Method" section of this documentation for details.

### Selecting a Cluster Identity Check Method

Currently, you can use two different verification methods: Client Certificate or Bearer Token.

 ####  Client Certificate 

 Such as complete identity check by using "client certificate" Please set the field `certData` and `keyData`(both need to be base64 encoded), and ensure that the identity that issued the certificate has the identity of `cluster-admin` in the Kubernetes RBAC authority system. Otherwise, according to the [Deploy FAQ](./deploy_faq.md). 

 #### Bearer Token 

 To use the "Bear Token" to complete the identity check, you first need to get a valid token. the most common way to get a cluster token is to create a service account with the role `cluster-admin` and use the account's token. 

 As an example, the following YAML resource creates a ServiceAccount object named `admin-user` with `cluster-admin` permissions in the cluster's `kube-system` namespace: 

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
 # Get the name of the secret the token is in 
 $ TOKENNAME=`kubectl -n kube-system get serviceaccount/admin-user -o jsonpath='{.secrets[0].name}'`. 

 #Read and print token (base64 decoded) 
 $ kubectl -n kube-system get secret $TOKENNAME -o jsonpath='{.data.token}'| base64 --decode 
 eyJhbGciOiJSUzI1NiIsImtp... 
 ``` 

 Finally, the token is added to the `apiserver.initialCluster.tokenValue` configItem of the paas-stack module to complete the identity check configuration. 

 check [paas-stack description](../cores/paas-stack/README.md). 