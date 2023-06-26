# System Structure and Function 

1. Webfe 

PaaS3.0 Developer Center front-end module.A single-page application built based on Vue.js. 

![webfe](media/webfe.png)

2. ApiServer 

ApiServer provides REST APIs and is the main backend service for the PaaS3.0 Developer Center. The following modules are included: 

- SourceCtl: Application source code management 
- Service: Add-ons module to provide services such as MySQL and object storage to wait for application 
- Market: Market service that can deploy applications to the desktop 
- Logging: Application log module

![apiserver](media/apiserver.png)

3. Service Provider 

REST-based service provider, used to remotely register additional services, apply, bind to, and destroy add-on instances. 

![service](media/service.png)
