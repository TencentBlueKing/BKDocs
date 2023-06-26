 # How to Deploy the BlueKing Lesscode 
 The BlueKing lesscode is deployed on the PaaS3.0 Developer Center through the S-mart App. The App ID is:bk_lesscode‖. 

 ### Create an application 

 Create an application by Uploading an S-Mart Package 

 ![upload source package](../../assets/paas3/bk_lesscoe_upload.png) 


 After uploading the source package, the application information is parsed as follows 

 ![Parse source package result](../../assets/paas3/bk_lesscode_info.png) 

 click on "Confirm and create application" to create the application 

 ### Setting the Env Variables 

 Before deploying the application, you need to set the env variables that are required for the bk_lesscode application to run 

 |Env Name |Description 
 |---|---| 
 | `PRIVATE_NPM_REGISTRY` |npm imageSource address, the value is filled according to the following template:`${bkrepoConfig.endpoint}/npm/bkpaas/npm/` where bkrepoConfig.endpoint is the bkrepo service gateway address| 
 | `PRIVATE_NPM_USERNAME` |npm account user name. Fill in the `bkrepoConfig.lesscodeUsername` setting when deploying PaaS3.0. 
 | `PRIVATE_NPM_PASSWORD` |npm account password. Fill in the `bkrepoConfig.lesscodePassword` setting when Deploy PaaS3.0. 
 | BKAPIGW_DOC_URL` |Cloud API Doc URL. Fill in the value of the Env variable APISUPORT_FE_URL Generate when Deploy API Gateway|. 

 On the bk_lesscode application page, click "App Engine"-"Env Configs" to configure npm-related env variables. select "all Environments" for the Take Effect environment. The effect after configuration is shown in the figure below: 

 ![Setting Env Variables](../../assets/paas3/bk_lesscode_vars.png) 


 ### Setting the domain 

 Deploy the application to the Deployment Management Deploy page. 

 After deploying the bk_lesscode application Staging Env and the official environment, you need to set a domain for the application.  Currently, bk_lesscode only supports approving a domain for access. 

 In the bk_lesscode application page, click "App Engine"-"Network & Domains" to set a domain. 

 Note: It is necessary to ensure that the setting domain name is correctly resolved to the "Domain Name Resolution Target IP" in the "IP Information" within company intranet. 