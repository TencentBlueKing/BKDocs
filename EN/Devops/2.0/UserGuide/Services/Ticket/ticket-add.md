 # Create Voucher Page 

 During Pipeline Run, you may need many types of ticket to Pull Code Repository, call code base API, and access third-party service approve Account password. 

 ![png](../../assets/service_ticket_add.png) 

 The following ticket types are currently supported: 
 type| description 
 --- | --- 
 password| After definition, it will be referenced as pipelineVar in various Plugin 
 usernamePassword| Typically used when link SVN Code Repository 
 sshKey| Used when link GitLab Code Repository (no GitLab event triggering required) 
 sshKeyToken| Used when link GitLab Code Repository (requires GitLab event triggering) 
 passwordToken| Used when link GitLab Code Repository (requires GitLab event triggering) 

 ## Next you may need 

 * [view ticket](ticket-list.md) 