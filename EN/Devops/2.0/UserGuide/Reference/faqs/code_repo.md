 # linkCodelib 

 ## Q1: Common Reasons for Errors in link GitLab Code Repository 

 ![](../../assets/repo_gitlab.png) 

 1. Personal Access Tokens should be used instead of project tokens. 

 2. Confirm whether the corresponding auth is given when Generate Access_Tokens.  The corresponding API auth Must be included. 

 3. If it is a self-built GitLab, please Confirm whether the "repository/branches" API is available. 

 https://docs.gitlab.com/ee/api/branches.html 

 4. If GitLab is accessed through https.  Please Confirm if the Code Repository does http-->https location.  By default, BK-CI uses http for Code Repository access. 

 If no location is made, please Revise the BK-CI file according to this temporary scheme: 

 ```bash vim /data/bkce/etc/ci/application-repository.yml 

 #Revise the application-repository.yml file and change the apiUrl to https #gitlab v4. 
 gitlab: 
 apiUrl: https://devops.bktencent.com/api/v4 
 ``` 

 restart bkci-repository.service 

 ```systemctl restart bkci-repository.service``` 



 5. SSH link error 

 ![](../../assets/QQscreenshot20221228181708.png) 

 The version of the SSH protocol BK-CI cannot be resolved.  If you encounter this Error, it is recommended to use HTTP to link. 


 ## Q2: Unable to link GitHub Code Repository 

 At present, there are still some problems in the docking between BK-CI and GItHub.  If you must use a GitHub Code Repository, According to this method to configure [How to link a GitHub Repository](bk.tencent.com/s-mart/community/question/3184?type=article) 