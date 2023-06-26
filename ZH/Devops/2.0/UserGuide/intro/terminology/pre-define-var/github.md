# GITHUB 常量合集

## GITHUB拉取代码

| Variable   | Description |
| :--- | :--- |
| git.${group}.${project}.new.commit |  |
| git.${group}.${project}.last.commit |  |


## GITHUB触发事件公共常量

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_WEBHOOK_REPO_TYPE | 触发的代码库类型，为GIT |
| BK_CI_REPO_WEBHOOK_REPO_URL | 触发的代码库URL |
| BK_CI_REPO_WEBHOOK_NAME | 触发的代码库名称 |
| BK_CI_REPO_WEBHOOK_ALIAS_NAME | 触发的代码库在BKCI的别名 |
| BK_CI_REPO_WEBHOOK_HASH_ID | 触发的代码库在BKCI的HASH ID |
| BK_CI_REPO_GIT_WEBHOOK_COMMITID | 触发对应的COMMIT ID |
| BK_CI_REPO_GIT_WEBHOOK_EVENT_TYPE | 触发的事件类型 |
| BK_CI_REPO_GIT_WEBHOOK_INCLUDE_BRANCHS | 触发插件的监听的分支 |
| BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_BRANCHS | 触发插件的排除的分支 |
| BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_USERS | 触发插件的排除人员 |


## GITHUB CREATE Branch Or Tag事件触发

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GITHUB_WEBHOOK_CREATE_REF_NAME	 | TAG或者BRANCH名称 |
| BK_CI_REPO_GITHUB_WEBHOOK_CREATE_REF_TYPE | REF类型，TAG或者BRANCH |
| BK_CI_REPO_GITHUB_WEBHOOK_CREATE_USERNAME	 | 创建REF的作者 |


## GITHUB Commit Push Hook事件触发

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_PUSH_USERNAME | PUSH的用户 |
| BK_CI_REPO_GIT_WEBHOOK_BRANCH | PUSH对应的分支
 |


 ## GITHUB Pull Request Hook事件触发

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_MR_AUTHOR | PR的作者或提交者 |
| BK_CI_REPO_GIT_WEBHOOK_TARGET_URL | PR的目标代码库URL |
| BK_CI_REPO_GIT_WEBHOOK_SOURCE_URL | PR的源代码库URL |
| BK_CI_REPO_GIT_WEBHOOK_TARGET_BRANCH | PR的目标分支 |
| BK_CI_REPO_GIT_WEBHOOK_SOURCE_BRANCH | PR的源分支 |
| BK_CI_REPO_GIT_WEBHOOK_MR_CREATE_TIME | PR的创建时间 |
| BK_CI_REPO_GIT_WEBHOOK_MR_UPDATE_TIME | PR的创建时间戳 |
| BK_CI_REPO_GIT_WEBHOOK_MR_ID | PR的ID |
| BK_CI_REPO_GIT_WEBHOOK_MR_NUMBER | PR的更新时间戳 |
| BK_CI_REPO_GIT_WEBHOOK_MR_DESC | PR的描述 |
| BK_CI_REPO_GIT_WEBHOOK_MR_TITLE | PR的标题 |
| BK_CI_REPO_GIT_WEBHOOK_MR_ASSIGNEE | PR负责人 |
| BK_CI_REPO_GIT_WEBHOOK_MR_URL | PR的URL |
| BK_CI_REPO_GIT_WEBHOOK_MR_REVIEWERS | PR的评审人（包括必要评审人） |
| BK_CI_REPO_GIT_WEBHOOK_MR_MILESTONE | PR的里程碑名称 |
| BK_CI_REPO_GIT_WEBHOOK_MR_MILESTONE_DUE_DATE | PR的里程碑时间 |
| BK_CI_REPO_GIT_WEBHOOK_MR_LABELS | PR的标签 |
