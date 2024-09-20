 # GIT Constant Collection 

 ## GIT Pull Constant 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_GIT_REPO_URL |Pull Code Repository URL| 
 | BK_CI_GIT_REPO_NAME |Pull Code Repository name| 
 | BK_CI_GIT_REPO_ALIAS_NAME |Pull Code Repository in BK-CI aliasName| 
 | BK_CI_GIT_REPO_BRANCH |Pull Code Repository Branch| 
 | BK_CI_GIT_REPO_TAG |Pull the TAG of the Code Repository| 
 | BK_CI_GIT_REPO_CODE_PATH |Pull the local relative directory path of the Code Repository| 
 | BK_CI_GIT_REPO_LAST_COMMIT_ID |The commit id of One last build| 
 | BK_CI_GIT_REPO_HEAD_COMMIT_ID |The commit id of this build| 
 | BK_CI_GIT_REPO_HEAD_COMMIT_COMMENT |submit Notes for this build| 
 | BK_CI_GIT_REPO_HEAD_COMMIT_AUTHOR |Author of this build| 
 | BK_CI_GIT_REPO_HEAD_COMMIT_COMMITTER |The committer of this build| 


 ## GIT event Trigger Constant 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_REPO_WEBHOOK_REPO_TYPE |type of Code Repository triggered, GIT| 
 | BK_CI_REPO_WEBHOOK_REPO_URL |Triggered Code Repository URL| 
 | BK_CI_REPO_WEBHOOK_NAME |Triggered Code Repository name| 
 | BK_CI_REPO_WEBHOOK_ALIAS_NAME |The aliasName of the triggered Code Repository in BK-CI| 
 | BK_CI_REPO_WEBHOOK_HASH_ID |HASH ID of the triggered Code Repository in BK-CI| 
 | BK_CI_REPO_GIT_WEBHOOK_COMMITID |Trigger the corresponding COMMIT ID| 
 | BK_CI_REPO_GIT_WEBHOOK_EVENT_TYPE |Event type triggered| 
 | BK_CI_REPO_GIT_WEBHOOK_INCLUDE_BRANCH |The Branch that triggers the listening of the Plugin| 
 | BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_BRANCH |Trigger excluded Branch of Plugin| 
 | BK_CI_REPO_GIT_WEBHOOK_INCLUDE_PATHS |path to trigger Plugin listening| 
 | BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_PATHS |path to trigger exclusion of Plugin| 
 | BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_USERS |Person triggering exclusion of Plugin| 
 | BK_CI_GIT_WEBHOOK_FINAL_INCLUDE_BRANCH| Plug-in configures the final match branch in "Listen to the following target Branch", if no configuration value is empty| 
 | BK_CI_GIT_WEBHOOK_FINAL_INCLUDE_PATH |The list of the final match paths in the Plugin Config "Listen to the following path". If there is no configuration, the value is empty.| 
 | BK_REPO_GIT_WEBHOOK_PUSH_COMMIT_MSG_n |Triggered Commit log.  For push event n is only equal to 1; Access range of n for mr event is 1-32| 
 | BK_CI_HOOK_MESSAGE | 	 The commit message when triggered| 


 ## GIT Commit Push Hook event Trigger Constant 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_REPO_GIT_WEBHOOK_PUSH_USERNAME |user of Push| 
 | BK_CI_REPO_GIT_WEBHOOK_BRANCH |PUSH corresponding Branch| 
 | BK_REPO_GIT_WEBHOOK_PUSH_BEFORE_COMMIT |The commit id before this PUSH| 
 | BK_REPO_GIT_WEBHOOK_PUSH_AFTER_COMMIT |The commit id after this push| 
 | BK_REPO_GIT_WEBHOOK_PUSH_ADD_FILE_n1_n2 |file append by this PUSH.  n1 indicates the number of submit, n2 indicates the number of file Submitting, and n Access be 1-32| 
 | BK_REPO_GIT_WEBHOOK_PUSH_MODIFY_FILE_n1_n2 |file changed in this PUSH.  n1 indicates the number of submit, n2 indicates the number of file Submitting, and n Access be 1-32| 
 | BK_REPO_GIT_WEBHOOK_PUSH_DELETE_FILE_n1_n2 |file delete by this PUSH.  n1 indicates the number of submit, n2 indicates the number of file Submitting, and n Access be 1-32| 
 | BK_REPO_GIT_WEBHOOK_PUSH_ADD_FILE_COUNT |Quantity of file append in this PUSH| 
 | BK_REPO_GIT_WEBHOOK_PUSH_MODIFY_FILE_COUNT |Quantity of file changed in this PUSH| 
 | BK_REPO_GIT_WEBHOOK_PUSH_DELETE_FILE_COUNT |Quantity of file delete by this PUSH| 

 ## Constants for GIT Merge Request Hook or Merge Request Hook Accept events 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_REPO_GIT_WEBHOOK_MR_AUTHOR |Author or submit of the Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_TARGET_URL |target Code Repository URL for Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_SOURCE_URL |Code Repository URL for Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_TARGET_BRANCH |target Branch for Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_SOURCE_BRANCH |Source Branch of Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_CREATE_TIME |creationTime of Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_UPDATE_TIME |updateTime for Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_CREATE_TIMESTAMP |Timestamp of the Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_UPDATE_TIMESTAMP |Timestamp for Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_ID |Triggered Merge Request Id| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_NUMBER |Triggered Merge Request Number| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_DESC |description of Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_TITLE |Title of Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_ASSIGNEE |Merge Request principal| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_URL |URL of Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_REVIEWERS |Reviewers for Merge Request (including necessary reviewers)| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_MILESTONE |Milestone name for Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_MR_MILESTONE_DUE_DATE |Merge Request Milestone time| 
 | Merge Request Milestone time| label for Merge Request| 
 | BK_CI_REPO_GIT_WEBHOOK_COMMITID |ID of the Merge Request| 
 | BK_REPO_GIT_WEBHOOK_MR_LAST_COMMIT |Merge Request One submit commitId| 
 | BK_REPO_GIT_WEBHOOK_MR_LAST_COMMIT_MSG |Merge Request Submission information for One last submit| 


 ## GIT Tag Push Hook event Trigger 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_REPO_GIT_WEBHOOK_TAG_NAME |submit TAG Name| 
 | BK_CI_REPO_GIT_WEBHOOK_TAG_OPERATION |TAG Operation: create or delete (create/delete)| 
 | BK_CI_REPO_GIT_WEBHOOK_TAG_USERNAME |Author of the submit TAG| 
 | BK_REPO_GIT_WEBHOOK_TAG_CREATE_FROM |From which Branch or commit point to create, if the tag created from the client, the value is empty| 


 ## GIT Code Review Hook event Trigger 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_REPO_GIT_WEBHOOK_REVIEW_REVIEWABLE_TYPE |If CR create by MR, the value is merge_request| 
 | BK_CI_REPO_GIT_WEBHOOK_REVIEW_REVIEWABLE_ID |If MR create CR, the value is mr id| 
 | BK_CI_REPO_GIT_WEBHOOK_REVIEW_RESTRICT_TYPE |Review Rules| 
 | BK_CI_REPO_GIT_WEBHOOK_REVIEW_APPROVING_REVIEWERS |Unreviewed list, split by| 
 | BK_CI_REPO_GIT_WEBHOOK_REVIEW_APPROVED_REVIEWERS |Reviewed list, split by,| 


 ## GIT ISSUE event Trigger 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_REPO_GIT_WEBHOOK_ISSUE_TITLE |issue title| 
 | BK_CI_REPO_GIT_WEBHOOK_ISSUE_ID | issue id | 
 | BK_CI_REPO_GIT_WEBHOOK_ISSUE_IID | issue iid | 
 | BK_CI_REPO_GIT_WEBHOOK_ISSUE_DESCRIPTION |Issue description| 
 | BK_CI_REPO_GIT_WEBHOOK_ISSUE_STATE |issue status| 
 | BK_CI_REPO_GIT_WEBHOOK_ISSUE_OWNER |Issue projectCreator| 
 | BK_CI_REPO_GIT_WEBHOOK_ISSUE_URL | issue url | 
 | BK_CI_REPO_GIT_WEBHOOK_ISSUE_MILESTONE_ID |issue milestone id| 
 | BK_CI_REPO_GIT_WEBHOOK_ISSUE_ACTION |issue Operation| 


 ## GIT Note event Trigger 

 | Variable   | Description | 
 | :--- | :--- | 
 | BK_CI_REPO_GIT_WEBHOOK_NOTE_COMMENT |content| 
 | BK_CI_REPO_GIT_WEBHOOK_NOTE_ID |Comment ID| 
 | BK_CI_REPO_GIT_WEBHOOK_NOTE_NOTEABLE_TYPE |Review, Commit, Issue| 
 | BK_CI_REPO_GIT_WEBHOOK_NOTE_AUTHOR_ID |Review Author| 
 | BK_CI_REPO_GIT_WEBHOOK_NOTE_CREATED_AT |Comment creationTime| 
 | BK_CI_REPO_GIT_WEBHOOK_NOTE_UPDATED_AT |Comment updateTime| 
 | BK_CI_REPO_GIT_WEBHOOK_NOTE_URL |Comment url| 