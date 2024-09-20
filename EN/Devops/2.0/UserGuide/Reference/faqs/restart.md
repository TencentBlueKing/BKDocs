 ## Q1: How to close the service when the machine needs to be restart 

 Generally speaking, there is no special Operation before restart, and it can be restarted directly. 





 ## Q2: How to Confirm that the service has been restore after restart 

 For the restore check Operation after restart, please Reference document 

 [restart the machine](https://bk.tencent.com/docs/document/6.0/127/7582) 



 ## Q3：bkiam v3 failed 

 ![](../../assets/bkiam_failed.png) 

 The most common error when the machine restart.  Each service of BK-CI will be auto started when it is restart, but SaaS service will not be Start Up automatically and needs to be started manual. 

 The central console execute ``` /data/install/bkcli start saas-o``` 

 It is recommended that The restart command be written into the boot execute Script. 



 ### Q4: After the machine was powered off, it was restart, but some service of BlueKing did not start up. Are these services not Set boot Start Up? 

 There are dependencies between service. For example, some services of BlueKing dependOn MySQL. If these services are Start Up before MySQL, the startup will failed. 

 Check and restore the server by referring to [restart the server](https://bk.tencent.com/docs/document/6.0/127/7582) 