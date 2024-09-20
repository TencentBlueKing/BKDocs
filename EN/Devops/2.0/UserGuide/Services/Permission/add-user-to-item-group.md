 # Append user to resources userGroup 

 - Only the resources such as Pipeline and Blueking Code Check Center Task can be appended to the corresponding userGroup by the administrator. 
 - Other resources generally apply the corresponding userGroup approve the user's initiative. 

 ## Append User to Pipeline 

 After Pipeline A is created successfully, the system automatically generates four corresponding selectedGroupSuffixes: owner, edit, execute and view. 

 The owner of the pipeline can give the user auth to activate the pipeline as needed 

 ![](../..assets/permission/pipeline_permission.png) 

 1. The entry is on the Edit Pipeline page, tab "auth". 
 2. system default 4 selectedGroupSuffix 
 3. Group detail: contains basic information and group members 
 4. You can add members or organizational architecture to a group, and remove members individually or in batch. 
 5. Group auth: the operation that users in the current user group can perform 
 6. You can close the pipeline permissions and let the pipelineGroup manage the permissions in a unified way. 