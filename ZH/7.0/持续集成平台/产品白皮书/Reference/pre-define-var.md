# 预定义变量列表

合理的使用变量可以更便捷的维护流水线，bk-ci 提供了很多系统变量。

> 注意：变量即意味着可变，可被用户和插件进行覆盖，所以在使用过程中，谨慎覆盖以免影响自己的业务逻辑，bk-ci 没有系统常量，一切交给用户自己决定

用法：插件配置中，输入 ${变量名} 即可获取对应变量的值。如 ${BK\_CI\_PIPELINE\_NAME}

| Variable | Description | 样例 |
| :--- | :--- | :--- |
| BK\_CI\_PIPELINE\_ID | 流水线 ID，34 位长度，全局唯一 | p-2fc5a05b25024d5586742b8e88d3c853 |
| BK\_CI\_START\_TYPE | 构建启动方式，MANUAL/TIME\_TRIGGER/WEB\_HOOK/SERVICE/PIPELINE/REMOTE 中取值 | WEB\_HOOK |
| BK\_CI\_PROJECT\_NAME | 项目英文名 | alltest |
| BK\_CI\_PIPELINE\_NAME | 流水线名称 | 持续交付流水线 |
| BK\_CI\_BUILD\_ID | 流水线当前构建 ID，34 位长度，全局唯一 | b-d82918fc4f5c44c790d538785685f36b |
| BK\_CI\_BUILD\_NUM | 构建序号，从 1 开始不断自增 |  |
| BK\_CI\_BUILD\_JOB\_ID | 流水线当前构建的当前 Job ID，34 位长度，全局唯一 |  |
| BK\_CI\_BUILD\_TASK\_ID | 流水线当前插件 Task ID，34 位长度，全局唯一 |  |
| BK\_CI\_BUILD\_REMARK | 流水线构建备注信息，在流水线运行时通过 setEnv "BK\_CI\_BUILD\_REMARK" 设置 |  |
| BK\_CI\_BUILD\_START\_TIME | 流水线启动时间， 毫秒数 |  |
| BK\_CI\_BUILD\_END\_TIME | 流水线结束时间， 毫秒数 |  |
| BK\_CI\_BUILD\_TOTAL\_TIME | 流水线执行耗时 |  |
| BK\_CI\_BUILD\_FAIL\_TASKS | 流水线执行失败的所有 TASK，内容格式：1、格式：\[STAGE 别名\]\[JOB别名\]TASK 别名 2、若有多个并发 JOB 失败，使用换行\n 分隔 | 可用于构建失败通知，或流水线执行过程中的插件中 |
| BK\_CI\_BUILD\_FAIL\_TASKNAMES | 流水线执行失败的所有 TASK，内容格式：TASK 别名,TASK 别名,TASK 别名 | 可用于构建失败通知，或流水线执行过程中的插件中 |
| BK\_CI\_TURBO\_ID | 编译加速任务 ID，只有启用了编译加速才有该变量 |  |
| BK\_CI\_MAJOR\_VERSION | 流水线里唯一，主版本号，开启“推荐版本号”功能后出现 |  |
| BK\_CI\_MINOR\_VERSION | 流水线里唯一，特性版本，开启“推荐版本号”功能后出现 |  |
| BK\_CI\_FIX\_VERSION | 流水线里唯一，修正版本，开启“推荐版本号”功能后出现 |  |
| BK\_CI\_BUILD\_NO | 流水线里唯一，构建号，开启“推荐版本号”功能后出现，可以设置不同的自增规则 |  |
| BK\_CI\_PIPELINE\_UPDATE\_USER | 流水线更新用户 |  |
| BK\_CI\_PIPELINE\_VERSION | 流水线版本号 |  |
| BK\_CI\_PROJECT\_NAME\_CN | 流水线对应的项目名称 |  |
| BK\_CI\_START\_CHANNEL | 流水线启动的 CHANNEL CODE |  |
| BK\_CI\_START\_USER\_ID | 流水线构建真正执行的用户 ID, 一般手动启动时的当前用户 ID，重试流水线人的用户 ID。如果是定时/webhook/子流水线调用， 则是流水线的最后修改人 |  |
| BK\_CI\_START\_USER\_NAME | 流水线构建启动的用户 ID, 通常值与 BK\_CI\_START\_USER\_ID 是一致的，但以下两种情况例外：1.当启动方式为 WEBHOOK，该值为 Git/SVN 的用户 ID；2.当是子流水线调用时，该值为父流水线的构建启动人 ID | 例如：parent1 和 Sub2 的最后修改人为 User0；user1 手工执行 parent1 父流水线，parent1 再启动子流水线 Sub2， 此时 Sub2 的 BK\_CI\_START\_USER\_ID 为 User0；BK\_CI\_START\_USER\_NAME 为 User1 |
| BK\_CI\_PARENT\_PIPELINE\_ID | 获取启动当前流水线的父流水线 ID，仅当作为子流水线并被父流水线触发时才有效 |  |
| BK\_CI\_PARENT\_BUILD\_ID | 获取启动当前流水线的父流水线的构建 ID，仅当作为子流水线并被父流水线触发时才有效 |  |
| BK\_CI\_START\_PIPELINE\_USER\_ID | 获取启动当前流水线的父流水线启动人，仅当作为子流水线并被父流水线触发时才有效 |  |
| BK\_CI\_START\_WEBHOOK\_USER\_ID | 获取启动当前流水线的触发 Webhook 帐号，仅当被 webhook 触发时才有效，该值将会展示在执行历史中，但实际执行人不是他，而是最后流水线修改人 |  |
| BK\_CI\_RETRY\_COUNT | 重试的次数，默认不存在， 当出现失败重试/rebuild 时， 该变量才会出现，并且+1 |  |

