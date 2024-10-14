 # Known issues 


 #### Q: userGroup and customize auth overlap, resulting in user permission on Pipeline not Meets The expectations. ci <1.7 

 #### **Version: ci<1.7**&#x20; 

 Occasional/obligatory: obligatory&#x20; 

 description: The userGroup of the user has All auth of "test" project, and the customize permissions have partial Pipeline permissions of "test" project. When you Enter the pipeline page, the pipeline cannot be view **probabilistically**&#x20; 

 ![You can view Pipeline](../../assets/image-20220301101202-Tnoda.png) 

 ![Cannot view Pipeline](../../assets/image-20220301101202-SOWdg.png) 

 **Q: Gitlab occasionally failed to obtain credentials** 

 ![](../../assets/wecom-temp-941115d684647ac6fe940676a7854656.png) 

 Known issue, **affected version <=1.5.23** 

 delete the package ticket/lib/bcprov-jdk15on-1.64.jar and restart the ticket service `systemctl restart bkci-ticket.service` 

 **Q: I want to use the unit Test report as the outputReport. The fileUploadSuccess.  But when you open the report, it cannot be Display normal, and the error "This request has haha is beenblocked; the content must be served over https」** 

 ![](../../assets/wecom-temp-76f4802ef5f78b0abfda917c2575106a.png) 

 Known issue, **affected version: 1.5.x** 

 **Q: Three pipelineInstance are create using a template. If One is delete, the template cannot be deleted even if all the instances are deleted.** 

 ![](../../assets/WeComscreenshot_16389525588929.png) 

 ![](../../assets/WeComscreenshot_16389527024197.png) 

 Known issue, affected scope: version <**1.5.x** 

 Fixed in v1.7 

 **Q: For a CodeCC Task create approve Pipeline, if the pipeline is delete and then the code analysis task is stopped, an error will be reported** 

 ![](../../assets/image-20220301101202-nkPoi.png) 

 ![](../../assets/WeCom screenshot_16395354744740.png) 

 Known issue, impact scope: **version 1.5.x** 

 **Q: BK-CI Output log are out of order** 

 ![](../../assets/WeCom screenshot_16316936739387.png) 

 Known issue, impact scope: **version 1.5.x** 

 **Q: When the BK-CI Pipeline applyPermission, I goApply, page did not location to the accessCenter. F12 view showed an error of bkiam v3 failed** 

 ![](../../assets/WeComscreenshot_16384143961812.png) 

 ![](../../assets/WeComscreenshot_16384146286005.png) 

 Known issue, impact scope: **version 1.5.x** 

 **Q: TGit Plugin is not Allow for the project. Please check whether the plug-in is install correctly** 

 ![](../../assets/image-20220125154003687.png) 

 Known problem. TGit connects with Tencent's worker bees. The use of community version is limited **, affecting version <1.5.35** 

 **** 