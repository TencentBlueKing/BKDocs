 # userGroup Introduction 

 BK-CI Manage auth approve userGroup: 
 - Each userGroup consists of group auth and group members. 
 - Group auth includes the operation that members can perform and the scope of objects for the actions. 

 ## project userGroup 

 When a project is created, the system automatically initializes seven project-level userGroup and sets creator to the ProjectManager: 

 | groupName | function description| 
 | ---- | ---- | 
 | Administrator| The Project Manager has operational and administrative authority over all resources under the project.  They can add users to a project, remove users from a project, approve requests to join a project, and approve requests to renew auth for users in a project-level UserGroup. | 
 | Development| Developers can create pipelines, code repositories, tickets, certificates, environments, nodes, codecc tasks, codecc checksets, download and share artifacts in the customRepo|. 
 | Operations and Maintenance Personnel| Operations and Maintenance Personnel can create pipelines, code repositories, tickets, certificates, environments, and nodes, and download and share products in the customRepo. 
 | PM| PM can view pipeline list, download or share artifacts. 
 | Test| Test can create pipeline, code repository, ticket, certificates, environment, node, codecc task, codecc checkersets, download and share artifact in customRepo. 
 | Quality Assurance Staff| Quality Assurance Staff, Manage Red Line Rule| 
 | Visitor| Visitors can view the pipeline list| 

 The above 7 default userGroup cannot revise group auth. 

 If the group auth of the default userGroup does not meet the Manage requirements, the Project Manager can customize the user group at the project level: 
 - customize userGroup can customize group auth 
 - [How to customize project userGroup](custom-group.md) 


 ## UserGroup at Resource Level 

 When a resource (pipeline, code repository, ticket, certificate, environment, node, etc.) is successfully created under the project, the system will automatically initialize the userGroup corresponding to the resource. 

 No userGroup at the resource level can override group auth. 

 ### Pipeline userGroup 

 | groupName | Function Description| 
 | ---- | ---- | 
 | owner| Have all the auth of the current pipeline, including the auth to delete, modify, query, execute, download/share artifacts in the pipeline artifactory, and Permissions| 
 | edit| Have the auth to query, execute, download/share artifacts in the pipeline artifactory of the current pipeline. 
 | execute| Have the auth to view, execute, download/share artifacts in the pipeline artifactory of the current pipeline. 
 | view By| Have the auth to view and download/share artifacts in the pipeline artifactory of the current Pipeline|

 - In addition to having auth to manage a single pipeline, you can also manage a batch of pipelines in batches. See [pipelineGroup userManage](pipeline-group.md) for more information. 

### Code Repository userGroup 

| groupName | Function Description| 
| ---- | ---- | 
| owner| You have full auth for the current code repository, including delete, modify, and permissions. 
| user| You have auth to use the current code repository and can select the code base in the pipeline. 

### ticket userGroup 

| groupName | function description| 
| ---- | ---- | 
| owner| You have all the auth of the current ticket, including delete, modify, review, and permissions. 
| user| You have the auth to use the current ticket and can select the credential in the pipeline. 


### Credential userGroup 

| groupName | job description| 
| ---- | ---- | 
| owner| You have all the auth of the current certificate, including delete, revise, check, and permissions. 
| user| You have permission to use the current certificate. You can use the certificate in the pipeline. 


### environment userGroup 

| groupName | job description| 
| ---- | ---- | 
| owner| You have all the auth of the current environment, including delete, modify, review, and permissions. 
| user| You have auth to use the current environment and can select the environment in the pipeline. 


### node userGroup 

| groupName | function description| 
| ---- | ---- | 
| owner| You have all the auth of the current node, including delete, modify, query, and Permissions permissions. 
| user| You have the auth to use the current node and can select the node in the pipeline.