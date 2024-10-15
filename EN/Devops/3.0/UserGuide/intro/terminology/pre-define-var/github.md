 # GITHUB constant collection 

 ## GITHUB Pull Code 

 | Variable   | Description | 
 | :--- | :--- | 
 | git.$  {group}.$  {project}.new.commit |  | 
 | git.$  {group}.$  {project}.last.commit |  | 


 ## Common constants for GITHUB trigger event 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_REPO_WEBHOOK_REPO_TYPE |type of Code Repository triggered, GIT| 
 | BK_CI_REPO_WEBHOOK_REPO_URL |Triggered Code Repository URL| 
 | BK_CI_REPO_WEBHOOK_NAME |Triggered Code Repository name| 
 | BK_CI_REPO_WEBHOOK_ALIAS_NAME |The aliasName of the triggered Code Repository in BK-CI| 
 | BK_CI_REPO_WEBHOOK_HASH_ID |HASH ID of the triggered Code Repository in BK-CI| 
 | BK_CI_REPO_GIT_WEBHOOK_COMMITID |Trigger the corresponding COMMIT ID| 
 | BK_CI_REPO_GIT_WEBHOOK_EVENT_TYPE |Event type triggered| 
 | BK_CI_REPO_GIT_WEBHOOK_INCLUDE_BRANCHS |The Branch that triggers the listening of the Plugin| 
 | BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_BRANCHS |Trigger excluded Branch of Plugin| 
 | BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_USERS |Excluded person who triggered the Plugin| 


 ## GITHUB CREATE Branch Or Tag event Trigger 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_REPO_GITHUB_WEBHOOK_CREATE_REF_NAME 	 | TAG or BRANCH name| 
 | BK_CI_REPO_GITHUB_WEBHOOK_CREATE_REF_TYPE |REF type, TAG or BRANCH| 
 | BK_CI_REPO_GITHUB_WEBHOOK_CREATE_USERNAME 	 | Author who create REF| 


 ## GITHUB Commit Push Hook event Trigger 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_REPO_GIT_WEBHOOK_PUSH_USERNAME |user of Push| 
 | BK_CI_REPO_GIT_WEBHOOK_BRANCH |Push corresponding Branch 
 | 


 ## Trigger of GITHUB Pull Request Hook event 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_REPO_GIT_WEBHOOK_MR_AUTHOR |Author or submit of PR| 
 | BK_CI_REPO_GIT_WEBHOOK_TARGET_URL |target Code Repository URL for PR| 
 | BK_CI_REPO_GIT_WEBHOOK_SOURCE_URL |Code Repository URL for PR| 
 | BK_CI_REPO_GIT_WEBHOOK_TARGET_BRANCH |target Branch for PR| 
 | BK_CI_REPO_GIT_WEBHOOK_SOURCE_BRANCH |Source Branch of PR| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_CREATE_TIME |creationTime of PR| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_UPDATE_TIME |Timestamp of PR| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_ID |ID of PR| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_NUMBER |Timestamp for PR| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_DESC |description of PR| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_TITLE |Title of PR| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_ASSIGNEE |principal of PR| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_URL |URL of PR| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_REVIEWERS |Reviewers of PR (including necessary reviewers)| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_MILESTONE |Milestone name for PR| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_MILESTONE_DUE_DATE |PR Milestone time| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_LABELS |label of PR| 