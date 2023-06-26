 # The BlueKing PaaS consists of several projects, as follows: 

 * `bkpaas3` platform core module, deployed only in **platform cluster**. 
 * `bkpaas-app-operator` Cloud-native application base, deployed in **each application cluster**. 
 * `bkapp-log-collection` Application log collection, deployed in **each application cluster**. 
 * `bk-ingress-nginx` Application access entry Ingress-Nginx, deployed in **each application cluster**. 

 ![-w2020](media/arch.png) 