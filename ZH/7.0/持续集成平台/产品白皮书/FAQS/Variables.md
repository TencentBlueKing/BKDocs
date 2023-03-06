# 变量

## 预定义变量列表

合理的使用变量可以更便捷的维护流水线，bk-ci 提供了很多系统变量。

> 注意：系统变量有既定逻辑和含义，请勿在流水线中修改这些变量。

用法：插件配置中，输入 ${{变量名}} 即可获取对应变量的值。如 \${{BK_CI_PIPELINE_NAME}}

| Variable | Description | 样例 |
| --- | --- | --- |
| BK_CI_PIPELINE_ID | 流水线 ID，34 位长度，全局唯一 | p-2fc5a05b25024d5586742b8e88d3c853 |
| BK_CI_START_TYPE | 构建启动方式，MANUAL/TIME_TRIGGER/WEB_HOOK/SERVICE/PIPELINE/REMOTE 中取值 |WEB_HOOK |
| BK_CI_PROJECT_NAME | 项目英文名 | alltest |
| BK_CI_PIPELINE_NAME | 流水线名称 | 持续交付流水线 |
| BK_CI_BUILD_ID | 流水线当前构建 ID，34 位长度，全局唯一 | b-d82918fc4f5c44c790d538785685f36b |
| BK_CI_BUILD_NUM | 构建序号，从 1 开始不断自增 | |
| BK_CI_BUILD_JOB_ID | 流水线当前构建的当前 Job ID，34 位长度，全局唯一 |
| BK_CI_BUILD_TASK_ID | 流水线当前插件 Task ID，34 位长度，全局唯一 |
| BK_CI_BUILD_REMARK | 流水线构建备注信息，在流水线运行时通过 setEnv "BK_CI_BUILD_REMARK" 设置 |
| BK_CI_BUILD_START_TIME | 流水线启动时间， 毫秒数 |
| BK_CI_BUILD_END_TIME | 流水线结束时间， 毫秒数 |
| BK_CI_BUILD_TOTAL_TIME | 流水线执行耗时 |
| BK_CI_BUILD_FAIL_TASKS	| 流水线执行失败的所有 TASK，内容格式：1、格式：[STAGE 别名][JOB别名]TASK 别名 2、若有多个并发 JOB 失败，使用换行\n 分隔 | 可用于构建失败通知，或流水线执行过程中的插件中 |
| BK_CI_BUILD_FAIL_TASKNAMES | 流水线执行失败的所有 TASK，内容格式：TASK 别名,TASK 别名,TASK 别名|可用于构建失败通知，或流水线执行过程中的插件中 |
| BK_CI_TURBO_ID|编译加速任务 ID，只有启用了编译加速才有该变量|
| BK_CI_MAJOR_VERSION|流水线里唯一，主版本号，开启“推荐版本号”功能后出现	|
| BK_CI_MINOR_VERSION|流水线里唯一，特性版本，开启“推荐版本号”功能后出现|
| BK_CI_FIX_VERSION|流水线里唯一，修正版本，开启“推荐版本号”功能后出现|
| BK_CI_BUILD_NO|流水线里唯一，构建号，开启“推荐版本号”功能后出现，可以设置不同的自增规则|
| BK_CI_PIPELINE_UPDATE_USER|流水线更新用户|
| BK_CI_PIPELINE_VERSION|流水线版本号|
| BK_CI_PROJECT_NAME_CN|流水线对应的项目名称|
| BK_CI_START_CHANNEL|流水线启动的 CHANNEL CODE|
| BK_CI_START_USER_ID|流水线构建真正执行的用户 ID,  一般手动启动时的当前用户 ID，重试流水线人的用户 ID。如果是定时/webhook/子流水线调用， 则是流水线的最后修改人 |
| BK_CI_START_USER_NAME|流水线构建启动的用户 ID, 通常值与 BK_CI_START_USER_ID 是一致的，但以下两种情况例外：1.当启动方式为 WEBHOOK，该值为 Git/SVN 的用户 ID；2.当是子流水线调用时，该值为父流水线的构建启动人 ID|例如：parent1 和 Sub2 的最后修改人为 User0；user1 手工执行 parent1 父流水线，parent1 再启动子流水线 Sub2， 此时 Sub2 的 BK_CI_START_USER_ID 为  User0；BK_CI_START_USER_NAME 为 User1
| BK_CI_PARENT_PIPELINE_ID|获取启动当前流水线的父流水线 ID，仅当作为子流水线并被父流水线触发时才有效	|
| BK_CI_PARENT_BUILD_ID|获取启动当前流水线的父流水线的构建 ID，仅当作为子流水线并被父流水线触发时才有效|
| BK_CI_START_PIPELINE_USER_ID|获取启动当前流水线的父流水线启动人，仅当作为子流水线并被父流水线触发时才有效|
| BK_CI_START_WEBHOOK_USER_ID|获取启动当前流水线的触发 Webhook 帐号，仅当被 webhook 触发时才有效，该值将会展示在执行历史中，但实际执行人不是他，而是最后流水线修改人|
| BK_CI_RETRY_COUNT|重试的次数，默认不存在， 当出现失败重试/rebuild 时， 该变量才会出现，并且+1|
| BK_CI_ATOM_VERSION| 当前插件版本号，如 1.0.1 | |  
| BK_CI_ATOM_CODE| 当前插件标识| |
| BK_CI_TASK_NAME| 当前步骤别名| |
| BK_CI_ATOM_NAME| 当前插件名称| |

## GIT常量合集

**GIT拉取常量**

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


**GIT事件触发常量**

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


**GIT Commit Push Hook事件触发常量**

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

**GIT Merge Request Hook 或 Merge Request Hook Accept事件触发常量**

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


**GIT Tag Push Hook事件触发**

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_TAG_NAME | 提交的TAG名字 |
| BK_CI_REPO_GIT_WEBHOOK_TAG_OPERATION | TAG操作：创建或删除(create/delete) |
| BK_CI_REPO_GIT_WEBHOOK_TAG_USERNAME | 提交的TAG的作者 |
| BK_REPO_GIT_WEBHOOK_TAG_CREATE_FROM | 从哪个分支或者commit点创建，如果从客户端创建的tag，值为空 |


**GIT Code Review Hook事件触发**

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_REVIEW_REVIEWABLE_TYPE | 如果是MR创建的CR，值为merge_request |
| BK_CI_REPO_GIT_WEBHOOK_REVIEW_REVIEWABLE_ID | 如果是MR创建的CR，值为mr id |
| BK_CI_REPO_GIT_WEBHOOK_REVIEW_RESTRICT_TYPE | 评审规则 |
| BK_CI_REPO_GIT_WEBHOOK_REVIEW_APPROVING_REVIEWERS | 未评审人列表，以，分割 |
| BK_CI_REPO_GIT_WEBHOOK_REVIEW_APPROVED_REVIEWERS | 已评审人列表，以，分割 |


**GIT ISSUE事件触发**

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


**GIT Note事件触发**

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_COMMENT | 评论内容 |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_ID | 评论ID |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_NOTEABLE_TYPE | 评论类型，有Review、Commit、Issue |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_AUTHOR_ID | 评论作者 |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_CREATED_AT | 评论创建时间 |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_UPDATED_AT | 评论更新时间 |
| BK_CI_REPO_GIT_WEBHOOK_NOTE_URL | 评论url |

### GITHUB 常量合集

**GITHUB拉取代码**

| Variable   | Description |
| :--- | :--- |
| git.${group}.${project}.new.commit |  |
| git.${group}.${project}.last.commit |  |


**GITHUB触发事件公共常量**

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_WEBHOOK_REPO_TYPE | 触发的代码库类型，为GIT |
| BK_CI_REPO_WEBHOOK_REPO_URL | 触发的代码库URL |
| BK_CI_REPO_WEBHOOK_NAME | 触发的代码库名称 |
| BK_CI_REPO_WEBHOOK_ALIAS_NAME | 触发的代码库在蓝盾的别名 |
| BK_CI_REPO_WEBHOOK_HASH_ID | 触发的代码库在蓝盾的HASH ID |
| BK_CI_REPO_GIT_WEBHOOK_COMMITID | 触发对应的COMMIT ID |
| BK_CI_REPO_GIT_WEBHOOK_EVENT_TYPE | 触发的事件类型 |
| BK_CI_REPO_GIT_WEBHOOK_INCLUDE_BRANCHS | 触发插件的监听的分支 |
| BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_BRANCHS | 触发插件的排除的分支 |
| BK_CI_REPO_GIT_WEBHOOK_EXCLUDE_USERS | 触发插件的排除人员 |


**GITHUB CREATE Branch Or Tag事件触发**

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GITHUB_WEBHOOK_CREATE_REF_NAME	 | TAG或者BRANCH名称 |
| BK_CI_REPO_GITHUB_WEBHOOK_CREATE_REF_TYPE | REF类型，TAG或者BRANCH |
| BK_CI_REPO_GITHUB_WEBHOOK_CREATE_USERNAME	 | 创建REF的作者 |


**GITHUB Commit Push Hook事件触发**

| Variable   | Description |
| :--- | :--- |
| BK_CI_REPO_GIT_WEBHOOK_PUSH_USERNAME | PUSH的用户 |
| BK_CI_REPO_GIT_WEBHOOK_BRANCH | PUSH对应的分支
 |


**GITHUB Pull Request Hook事件触发**

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
