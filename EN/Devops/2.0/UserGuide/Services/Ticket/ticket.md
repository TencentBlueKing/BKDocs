 # CredentialManage 

 During Pipeline Run, you may need many types of ticket to Pull Code Repository, call code base API, and access third-party service approve Account password. 

 ## Create Voucher 

 ![1](../../assets/image%20%288%29.png) 

 The following ticket types are currently supported: 

 | type| description| 
 | :--- | :--- | 
 | password| After definition, it will be referenced as pipelineVar in various Plugin| 
 | usernamePassword| Typically used when link SVN Code Repository| 
 | sshKey| Used when link GitLab Code Repository (no GitLab event triggering required)| 
 | sshKeyToken| Used when link GitLab Code Repository (requires GitLab event triggering)| 
 | passwordToken| Used when link GitLab Code Repository (requires GitLab event triggering)| 
 | AccessToken |Used when link GitLab Code Repository (requires GitLab event triggering)| 

 ## View ticket 

 You can View all the link ticket that have auth here. 

 ![2](../../assets/image%20%2840%29.png) 

 ## Next you may need 

 * [create Your One Pipeline](../../Quickstarts/Create-your-first-pipeline.md) 