# GIT常量合集

## GIT拉取常量

| Variable   | Description |
| :--- | :--- |
| BK_CI_GIT_REPO_URL | 拉取代码库URL |
| BK_CI_GIT_REPO_NAME | 拉取代码库名字 |
| BK_CI_GIT_REPO_ALIAS_NAME | 拉取代码库在蓝盾别名 |
| BK_CI_GIT_REPO_BRANCH | 拉取代码库分支 |
| BK_CI_GIT_REPO_TAG | 拉取代码库的TAG |
| BK_CI_GIT_REPO_CODE_PATH | 拉取代码库的本地相对目录路径 |
| BK_CI_GIT_REPO_LAST_COMMIT_ID | 上一次构建的commit id |
| BK_CI_GIT_REPO_HEAD_COMMIT_ID | 本次构建的commit id |
| BK_CI_GIT_REPO_HEAD_COMMIT_COMMENT | 本次构建的提交注释 |
| BK_CI_GIT_REPO_HEAD_COMMIT_AUTHOR | 本次构建的author |
| BK_CI_GIT_REPO_HEAD_COMMIT_COMMITTER | 本次构建的committer |


## GIT事件触发常量

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_WEBHOOK_REPO_TYPE | 触发的代码库类型，为GIT |
| BK_CI_REPO_WEBHOOK_REPO_URL | 触发的代码库URL |
| BK_CI_REPO_WEBHOOK_NAME | 触发的代码库名称 |
| BK_CI_REPO_WEBHOOK_ALIAS_NAME | 触发的代码库在蓝盾的别名 |
| BK_CI_REPO_WEBHOOK_HASH_ID | 触发的代码库在蓝盾的HASH ID |
| BK_CI_REPO_GIT_WEBHOOK_COMMITID | 触发对应的COMMIT ID |
| BK_CI_REPO_GIT_WEBHOOK_EVENT_TYPE | 触发的事件类型 |
| BK_CI_REPO_GIT_WEBHOOK_INCLUDE_BRANCH | 触发插件的监听的分支 |
| BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_BRANCH | 触发插件的排除的分支 |
| BK_CI_REPO_GIT_WEBHOOK_INCLUDE_PATHS | 触发插件的监听的路径 |
| BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_PATHS | 触发插件的排除的路径 |
| BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_USERS | 触发插件的排除的人员 |
| BK_CI_GIT_WEBHOOK_FINAL_INCLUDE_BRANCH| 插件配置"监听以下目标分支"中最终匹配的分支，如果没有配置值为空 |
| BK_CI_GIT_WEBHOOK_FINAL_INCLUDE_PATH | 插件配置"监听以下路径"中最终匹配的路径列表，如果没有配置值为空 |
| BK_REPO_GIT_WEBHOOK_PUSH_COMMIT_MSG_n | 触发的Commit日志。对于push事件n只等于1；对于mr事件n取值范围为1-32 |
| BK_CI_HOOK_MESSAGE | 	触发时的commit message |


## GIT Commit Push Hook事件触发常量

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_PUSH_USERNAME | PUSH的用户 |
| BK_CI_REPO_GIT_WEBHOOK_BRANCH | PUSH对应分支 |
| BK_REPO_GIT_WEBHOOK_PUSH_BEFORE_COMMIT | 本次PUSH前的commit id |
| BK_REPO_GIT_WEBHOOK_PUSH_AFTER_COMMIT | 本次PUSH后的commit id |
| BK_REPO_GIT_WEBHOOK_PUSH_ADD_FILE_n1_n2 | 本次PUSH所添加的文件。n1表示第几个提交，n2表示提交中第几个文件，n取值范围为1-32 |
| BK_REPO_GIT_WEBHOOK_PUSH_MODIFY_FILE_n1_n2 | 本次PUSH所变更的文件。n1表示第几个提交，n2表示提交中第几个文件，n取值范围为1-32 |
| BK_REPO_GIT_WEBHOOK_PUSH_DELETE_FILE_n1_n2 | 本次PUSH所删除的文件。n1表示第几个提交，n2表示提交中第几个文件，n取值范围为1-32 |
| BK_REPO_GIT_WEBHOOK_PUSH_ADD_FILE_COUNT | 本次PUSH所添加的文件数量 |
| BK_REPO_GIT_WEBHOOK_PUSH_MODIFY_FILE_COUNT | 本次PUSH所变更的文件数量 |
| BK_REPO_GIT_WEBHOOK_PUSH_DELETE_FILE_COUNT | 本次PUSH所删除的文件数量 |

## GIT Merge Request Hook 或 Merge Request Hook Accept事件触发常量

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_MR_AUTHOR | Merge Request的作者或提交者 |
| BK_CI_REPO_GIT_WEBHOOK_TARGET_URL | Merge Request的目标代码库URL |
| BK_CI_REPO_GIT_WEBHOOK_SOURCE_URL | Merge Request的源代码库URL |
| BK_CI_REPO_GIT_WEBHOOK_TARGET_BRANCH | Merge Request的目标分支 |
| BK_CI_REPO_GIT_WEBHOOK_SOURCE_BRANCH | Merge Request的源分支 |
| BK_CI_REPO_GIT_WEBHOOK_MR_CREATE_TIME | Merge Request的创建时间 |
| BK_CI_REPO_GIT_WEBHOOK_MR_UPDATE_TIME | Merge Request的更新时间 |
| BK_CI_REPO_GIT_WEBHOOK_MR_CREATE_TIMESTAMP | Merge Request的创建时间戳 |
| BK_CI_REPO_GIT_WEBHOOK_MR_UPDATE_TIMESTAMP | Merge Request的更新时间戳 |
| BK_CI_REPO_GIT_WEBHOOK_MR_ID | 触发的Merge Request Id |
| BK_CI_REPO_GIT_WEBHOOK_MR_NUMBER | 触发的Merge Request Number |
| BK_CI_REPO_GIT_WEBHOOK_MR_DESC | Merge Request的描述 |
| BK_CI_REPO_GIT_WEBHOOK_MR_TITLE | Merge Request的标题 |
| BK_CI_REPO_GIT_WEBHOOK_MR_ASSIGNEE | Merge Request负责人 |
| BK_CI_REPO_GIT_WEBHOOK_MR_URL | Merge Request的URL |
| BK_CI_REPO_GIT_WEBHOOK_MR_REVIEWERS | Merge Request的评审人（包括必要评审人） |
| BK_CI_REPO_GIT_WEBHOOK_MR_MILESTONE | Merge Request的里程碑名称 |
| BK_CI_REPO_GIT_WEBHOOK_MR_MILESTONE_DUE_DATE | Merge Request的里程碑时间 |
| Merge Request的里程碑时间 | Merge Request的标签 |
| BK_CI_REPO_GIT_WEBHOOK_COMMITID | Merge Request的ID |
| BK_REPO_GIT_WEBHOOK_MR_LAST_COMMIT | Merge Request最后一个提交的commitId |
| BK_REPO_GIT_WEBHOOK_MR_LAST_COMMIT_MSG | Merge Request最后一个提交的提交信息 |


## GIT Tag Push Hook事件触发

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_TAG_NAME | 提交的TAG名字 |
| BK_CI_REPO_GIT_WEBHOOK_TAG_OPERATION | TAG操作：创建或删除(create/delete) |
| BK_CI_REPO_GIT_WEBHOOK_TAG_USERNAME | 提交的TAG的作者 |
| BK_REPO_GIT_WEBHOOK_TAG_CREATE_FROM | 从哪个分支或者commit点创建，如果从客户端创建的tag，值为空 |


## GIT Code Review Hook事件触发

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_REVIEW_REVIEWABLE_TYPE | 如果是MR创建的CR，值为merge_request |
| BK_CI_REPO_GIT_WEBHOOK_REVIEW_REVIEWABLE_ID | 如果是MR创建的CR，值为mr id |
| BK_CI_REPO_GIT_WEBHOOK_REVIEW_RESTRICT_TYPE | 评审规则 |
| BK_CI_REPO_GIT_WEBHOOK_REVIEW_APPROVING_REVIEWERS | 未评审人列表，以，分割 |
| BK_CI_REPO_GIT_WEBHOOK_REVIEW_APPROVED_REVIEWERS | 已评审人列表，以，分割 |


## GIT ISSUE事件触发

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_ISSUE_TITLE | issue标题 |
| BK_CI_REPO_GIT_WEBHOOK_ISSUE_ID | issue id |
| BK_CI_REPO_GIT_WEBHOOK_ISSUE_IID | issue iid |
| BK_CI_REPO_GIT_WEBHOOK_ISSUE_DESCRIPTION | issue描述 |
| BK_CI_REPO_GIT_WEBHOOK_ISSUE_STATE | issue状态 |
| BK_CI_REPO_GIT_WEBHOOK_ISSUE_OWNER | issue创建者 |
| BK_CI_REPO_GIT_WEBHOOK_ISSUE_URL | issue url |
| BK_CI_REPO_GIT_WEBHOOK_ISSUE_MILESTONE_ID | issue 里程碑id |
| BK_CI_REPO_GIT_WEBHOOK_ISSUE_ACTION | issue操作 |


## GIT Note事件触发

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_COMMENT | 评论内容 |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_ID | 评论ID |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_NOTEABLE_TYPE | 评论类型，有Review、Commit、Issue |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_AUTHOR_ID | 评论作者 |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_CREATED_AT | 评论创建时间 |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_UPDATED_AT | 评论更新时间 |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_URL | 评论url |