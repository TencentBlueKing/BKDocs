# How to Set the Cluster Front Proxy IP (frontend_ingress_ip)

## Why Do I Need to Set It?

The platform assigns an API URL to the application according to the application code, such as `apps.blueking.com/some-app-code`. Normally, developers can use this domain name to refer to the Application access entry. However, some developers want to use a simpler and easier to remember domain, so the platform needs to provide a front proxy IP for DNS binding of the independent domain name.

## How to Set?

First, we need to understand the current application access model:

![A typical ingress controller access](./_images/nginx-ingress-controller.png)

All application requests will be proxied to each application in the cluster through `Ingress-Controller`. Therefore, the user domain setting must be resolved and point to `Ingress-Controller`.

It should be noted that the setting content **is used here only as a display page** to facilitate offline operation of platform users.

### Out-of-Cluster Proxy Plan

Take [Tencent Cloud CLB](https://cloud.tencent.com/product/clb) as an example.

![Request to approve CLB proxy](./_images/clb-as-proxy.png)

As shown in the figure, the cluster front proxy IP should be set to `10.1.1.1`. OTHER proxy plan to be filled in according to specific conditions.

### Deploy Quick Verification

During the Deploy Verification phase, our infrastructure preparation is often insufficient and we lack a proxy plan outside the cluster. You can temporarily fill in the node `NodeIP`.

First, we need to confirm which node is running `Ingress-Controller`.

```bash
# Assume bk-ingress-nginx Deploy exists the bk-ingress-nginx namespace
kubectl get pod -n bk-ingress-nginx -o wide
```

This will get the container and node information, and then select the `NodeIP` of one of them as the front proxy IP fill.

Please note that once the node is removed from the cluster or the `Ingress-Controller` container is moved to another node, the user's DNS binding will become inaccessible. Therefore, it is recommended to use an out-of-cluster proxy solution in the production environment.
